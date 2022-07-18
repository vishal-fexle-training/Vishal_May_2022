/*
  *  Purpose         :    Class to insert Country, State and Districts details
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/07
  *  Revision Logs   :    V_1.0 - Created - 2022/07/07
*/
public with sharing class CountriesAndDistrictsDynamic{
    public List<State__c> listRecords = new List<State__c>();
    public List<Country__c> listRecordsCountry = new List<Country__c>();
    public Map<String, Map<String, List<String>>> mapCountry = new Map<String, Map<String, List<String>>>();
    String dataJSON = '';

    /*
      *  Purpose         :    Wrapper Class to store Country details
      *  Created By      :    Vishal Tourani
      *  Created Date    :    2022/07/07
      *  Revision Logs   :    V_1.0 - Created - 2022/07/07
    */
    public class CountryWrapper{
        public Decimal countryCode{get; set;}
        public Decimal totalStates{get; set;}
	    public Decimal totalDistricts{get; set;}
        public List<StateWrapper> listState = new List<StateWrapper>();

        /*
          * Created By    :    Vishal Tourani
          * Purpose       :    Contructor when country, state and district combination is found 
          * Params        :    Decimal countryCode, String country, StateWrapper stateDetails    
        */
        public CountryWrapper(Decimal countryCode, String country, StateWrapper stateDetails){
            this.countryCode = countryCode;

            AggregateResult aggTotalStates = [Select COUNT(State_Name__c) Total_States from State__c where Country__r.Name like :country
                                              group by Country__r.Name limit 1];
            this.totalStates = (Decimal)aggTotalStates.get('Total_States');

            AggregateResult aggTotalDistricts = [Select COUNT(Name) Total_Districts from District__c where State__r.Country__r.Name like :country 
                                                 group by State__r.Country__r.Name limit 1];
            this.totalDistricts = (Decimal)aggTotalDistricts.get('Total_Districts');

            this.listState.add(stateDetails);
        }

        /*
          * Created By    :    Vishal Tourani
          * Purpose       :    Contructor when country, state and district combination is not found 
          * Params        :    Decimal countryCode, String country    
        */
        public CountryWrapper(Decimal countryCode, String country){
            this.countryCode = countryCode;
            
            AggregateResult aggTotalStates = [Select COUNT(State_Name__c) Total_States from State__c where Country__r.Name like :country
                                              group by Country__r.Name limit 1];
            this.totalStates = (Decimal)aggTotalStates.get('Total_States');

            AggregateResult aggTotalDistricts = [Select COUNT(Name) Total_Districts from District__c where State__r.Country__r.Name like :country 
                                                 group by State__r.Country__r.Name limit 1];
            this.totalDistricts = (Decimal)aggTotalDistricts.get('Total_Districts');
        }
    }

    /*
      *  Purpose         :    Wrapper Class to store State details
      *  Created By      :    Vishal Tourani
      *  Created Date    :    2022/07/07
      *  Revision Logs   :    V_1.0 - Created - 2022/07/07
    */
    public class StateWrapper{
        public String stateName{get; set;}
        public Decimal totalDistricts{get; set;}
        public List<DistrictWrapper> listDistrict = new List<DistrictWrapper>();

        public StateWrapper(String stateName, List<DistrictWrapper> listDistrictDetails){
            this.stateName = stateName;

            AggregateResult aggTotalDistricts = [Select COUNT(Name) Total_Districts from District__c where State__r.State_Name__c like :stateName
                                                 group by State__r.State_Name__c limit 1];
            this.totalDistricts = (Decimal)aggTotalDistricts.get('Total_Districts');

            this.listDistrict = listDistrictDetails;
        }
    }

    /*
      *  Purpose         :    Wrapper Class to store State details
      *  Created By      :    Vishal Tourani
      *  Created Date    :    2022/07/07
      *  Revision Logs   :    V_1.0 - Created - 2022/07/07
    */
    public class DistrictWrapper{
        public String districtName{get; set;}
    }

    public CountriesAndDistrictsDynamic(String startingCharacter){
        //Query to find combination of country, state and districts
        listRecords = [Select State_Name__c, Country__r.Country_Code__c, Country__r.Name, Country__r.Country_Hierarchy__c,
                      (Select Name From Districts__r Where Name like :startingCharacter+'%') From State__c 
                       Where State_Name__c like :startingCharacter+'%' and Country__r.Name like :startingCharacter+'%'];
        
        try{
            if(listRecords.isEmpty()){
                //Query to find only country 
                listRecordsCountry = [Select Country_Code__c, Name From Country__c Where Name like :startingCharacter+'%'];

                if(listRecordsCountry.isEmpty()){
                    throw new CountryNotFoundException();
                }
                else{
                    for(Country__c recCountry: listRecordsCountry){
                        CountryWrapper countryDetails = new CountryWrapper(recCountry.Country_Code__c, recCountry.Name);
                
                        dataJSON = Json.serialize(countryDetails);
                        recCountry.Country_Hierarchy__c = dataJSON;
                        generateURL(recCountry.id);
                    }
                }    
            }
            else{
                for(State__c recState : listRecords){
                    List<String> listDistrict = new List<String>();
                    List<DistrictWrapper> listdistrictDetails = new List<DistrictWrapper>();

                    for(District__c recDistrict : recState.Districts__r){
                        DistrictWrapper districtDetails = new DistrictWrapper();
                        districtDetails.districtName =  recDistrict.Name;
                        listdistrictDetails.add(districtDetails);
                    }
                    
                    createMap(recState.Country__r.Name, recState.State_Name__c, listDistrict);
                
                    StateWrapper stateDetails = new StateWrapper(recState.State_Name__c, listdistrictDetails);
                    CountryWrapper countryDetails = new CountryWrapper(recState.Country__r.Country_Code__c, recState.Country__r.Name,stateDetails);
                    
                    dataJSON = Json.serialize(countryDetails);
                    recState.Country__r.Country_Hierarchy__c = dataJSON;  
                    listRecordsCountry.add(recState.Country__r);  
                    generateURL(recState.Country__r.id);
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
      * Purpose       :    This method will put values in map
      * Params        :    String country, String state, List<String> district
      * Return        :    Void
    */
    public void createMap(String country, String state, List<String> district){
        Map<String, List<String>> mapState= new Map<String, List<String>>{state=>district};
        mapCountry.put(country, mapState);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will give URL of updated record
      * Params        :    Id recordId
      * Return        :    Void
    */
    public void generateURL(Id recordId){
        String recordLink = URL.getSalesforceBaseUrl().toExternalForm()+ '/' +recordId;
        System.debug(recordLink);    
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
        listRecords = [Select Name From District__c Where Name like :count+'%'];

        for(District__c recDistrict : listRecords){
            System.debug(recDistrict.Name);
        }
    }
}