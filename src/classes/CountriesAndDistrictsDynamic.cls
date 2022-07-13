/*
  *  Purpose         :    Class to insert Country, State and Districts details
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/07
  *  Revision Logs   :    V_1.0 - Created - 2022/07/07
*/
public with sharing class CountriesAndDistrictsDynamic{
    public List<State__c> listRecords = new List<State__c>();
    public List<Country__c> listRecordsCountry = new List<Country__c>();
    String dataJSON = '';

    public CountriesAndDistrictsDynamic(String startingCharacter){
        listRecords = [Select State_Name__c, Country__r.Country_Code__c, Country__r.Name, Country__r.Total_No_of_Districts__c, Country__r.Total_No_of_States__c,Country__r.Country_Hierarchy__c,
                      (Select Name from Districts__r where Name like :startingCharacter+'%') 
                       from State__c 
                       where State_Name__c like :startingCharacter+'%' 
                       and Country__r.Name like :startingCharacter+'%'];
        
        try{
            if(listRecords.isEmpty()){
                listRecordsCountry = [Select Country_Code__c, Name, Total_No_of_Districts__c, Total_No_of_States__c 
                                      from Country__c 
                                      where Name like :startingCharacter+'%'];

                if(listRecordsCountry.isEmpty()){
                    throw new CountryNotFoundException();
                }
                else{
                    for(Country__c recCountry: listRecordsCountry){
                        CountryWrapper countryDetails = new CountryWrapper();
                            
                        countryDetails.countryCode = recCountry.Country_Code__c;
                        countryDetails.totalDistricts = recCountry.Total_No_of_Districts__c;
                        countryDetails.totalStates = recCountry.Total_No_of_States__c;

                        dataJSON = Json.serialize(countryDetails);
                        recCountry.Country_Hierarchy__c = dataJSON;

                        String recordLink = URL.getSalesforceBaseUrl().toExternalForm()+'/'+recCountry.id ;
                        System.debug(recordLink);
                    }
                }    
            }
            else{
                for(State__c recState : listRecords){
                    CountryWrapper countryDetails = new CountryWrapper();
                            
                    countryDetails.countryCode = recState.Country__r.Country_Code__c;
                    countryDetails.totalDistricts = recState.Country__r.Total_No_of_Districts__c;
                    countryDetails.totalStates = recState.Country__r.Total_No_of_States__c;

                    List<String> listDistrict = new List<String>();
                    for(District__c recDistrict : recState.Districts__r){
                        listDistrict.add(recDistrict.Name);
                    } 
                    countryDetails.setMapHierarchy(recState.Country__r.Name, recState.State_Name__c, listDistrict);

                    dataJSON = Json.serialize(countryDetails);
                    recState.Country__r.Country_Hierarchy__c = dataJSON;  
                    listRecordsCountry.add(recState.Country__r);  

                    String recordLink = URL.getSalesforceBaseUrl().toExternalForm()+ '/' +recState.Country__r.id ;
                    System.debug(recordLink);
                }
            }
            update listRecordsCountry;     
        }
        catch(ListException e){
            System.debug('There is a problem with list : '+e.getMessage());
        }
        catch(CountryNotFoundException e){
            System.debug(e.getMessage());
        }    
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will query records of specified size
      * Params        :    Integer longestSize
      * Return        :    Void
    */
    public void longestDistrict(Integer longestSize){
        String count='';
        for(Integer i=0; i<longestSize; i++){
            count=count+'_';
        }
        List<District__c> listRecords = new List<District__c>();    
        listRecords = [ Select Name from District__c where Name like :count+'%' ];

        for(District__c recDistrict : listRecords){
            System.debug(recDistrict.Name);
        }
    }
}