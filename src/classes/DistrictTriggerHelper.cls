/*
  *  Purpose         :    Helper class for District trigger
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/08
  *  Revision Logs   :    V_1.0 - Created - 2022/08/08
*/
public with sharing class DistrictTriggerHelper{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to update number of districts on state and country
      * Params        :    List<District__c> newList, Map<Id, District__c> oldMap
      * Return        :    Void
    */
    public static void updateDistrictCount(List<District__c> newList, Map<Id, District__c> oldMap){
        Map<Id, Integer> mapStateWithDistrictCount = new Map<Id, Integer>();
        Map<Id, Integer> mapCountryWithDistrictCount = new Map<Id, Integer>();

        for(District__c newDistrict : newList){
            if(oldMap != null){
                if(oldMap.get(newDistrict.Id).State__c != newDistrict.State__c){
                    if(mapStateWithDistrictCount.containsKey(newDistrict.State__c)){
                        Integer count =  mapStateWithDistrictCount.get(newDistrict.State__c);
                        mapStateWithDistrictCount.put(newDistrict.State__c, count + 1);
                    }
                    else{
                        mapStateWithDistrictCount.put(newDistrict.State__c, 1);
                    }
                    
                    if(mapStateWithDistrictCount.containsKey(oldMap.get(newDistrict.Id).State__c)){
                        Integer count =  mapStateWithDistrictCount.get(oldMap.get(newDistrict.Id).State__c);
                        mapStateWithDistrictCount.put(oldMap.get(newDistrict.Id).State__c, count - 1);    
                    }
                    else{
                        mapStateWithDistrictCount.put(oldMap.get(newDistrict.Id).State__c, -1);  
                    }
                }
            }
            else{
                if(mapStateWithDistrictCount.containsKey(newDistrict.State__c)){
                    Integer count =  mapStateWithDistrictCount.get(newDistrict.State__c);
                    mapStateWithDistrictCount.put(newDistrict.State__c, count + 1);
                }
                else{
                    mapStateWithDistrictCount.put(newDistrict.State__c, 1);
                }    
            }
        }

        List<State__c> listState = [Select Id, State_Name__c, Number_of_District__c, Country__r.Id, Country__r.Name, Country__r.Number_of_District__c 
                                    from State__c where Id IN: mapStateWithDistrictCount.keySet()];
        List<Country__c> listCountry = new List<Country__c>();

        //For updating state records
        for(State__c recState : listState){
            Integer districtCount = mapStateWithDistrictCount.get(recState.Id);

            if(recState.Number_of_District__c != null){
                recState.Number_of_District__c = recState.Number_of_District__c + districtCount;

                if(mapCountryWithDistrictCount.containsKey(recState.Country__r.Id)){
                    Integer count = mapCountryWithDistrictCount.get(recState.Country__r.Id);
                    count = count + districtCount;
                    mapCountryWithDistrictCount.put(recState.Country__r.Id, count);
                }
                else{
                    mapCountryWithDistrictCount.put(recState.Country__r.Id, districtCount);
                }
            }
            else{
                recState.Number_of_District__c = districtCount;  

                if(mapCountryWithDistrictCount.containsKey(recState.Country__r.Id)){
                    Integer count = mapCountryWithDistrictCount.get(recState.Country__r.Id);
                    count = count + districtCount;
                    mapCountryWithDistrictCount.put(recState.Country__r.Id, count);
                }
                else{
                    mapCountryWithDistrictCount.put(recState.Country__r.Id, districtCount);
                }
            }
        }

        //For updating country records
        for(State__c recState : listState){
            Integer districtCount = mapCountryWithDistrictCount.get(recState.Country__r.Id);

            if(districtCount != 0){
                if(recState.Country__r.Number_of_District__c != null){
                    recState.Country__r.Number_of_District__c = recState.Country__r.Number_of_District__c + districtCount;
                }
                else{
                    recState.Country__r.Number_of_District__c = districtCount;
                }  
                listCountry.add(recState.Country__r);
            }
        }
        if(!listState.isEmpty()){
            update listState;
        }

        if(!listCountry.isEmpty()){
            update listCountry;
        }

        updateJsonField(listCountry);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to reduce number of districts on state and country after deletion
      * Params        :    List<District__c> oldList
      * Return        :    Void
    */
    public static void reduceDistrictCount(List<District__c> oldList){
        Map<Id, Integer> mapStateWithDistrictCount = new Map<Id, Integer>();
        Map<Id, Integer> mapCountryWithDistrictCount = new Map<Id, Integer>();

        for(District__c recDistrict : oldList){
            if(mapStateWithDistrictCount.containsKey(recDistrict.State__c)){
                Integer count =  mapStateWithDistrictCount.get(recDistrict.State__c);
                mapStateWithDistrictCount.put(recDistrict.State__c, count - 1);
            }
            else{
                mapStateWithDistrictCount.put(recDistrict.State__c, -1);
            }
        }

        List<State__c> listState = [Select Id, State_Name__c, Number_of_District__c, Country__r.Id, Country__r.Name, Country__r.Number_of_District__c 
                                    from State__c where Id IN: mapStateWithDistrictCount.keySet() ALL ROWS];
        List<Country__c> listCountry = new List<Country__c>();

        //For updating state records
        for(State__c recState : listState){
            Integer districtCount = mapStateWithDistrictCount.get(recState.Id);
            recState.Number_of_District__c = recState.Number_of_District__c + districtCount;

            if(mapCountryWithDistrictCount.containsKey(recState.Country__r.Id)){
                Integer count = mapCountryWithDistrictCount.get(recState.Country__r.Id);
                count = count + districtCount;
                mapCountryWithDistrictCount.put(recState.Country__r.Id, count);
            }
            else{
                mapCountryWithDistrictCount.put(recState.Country__r.Id, districtCount);
            }
        }

        //For updating country records
        for(State__c recState : listState){
            Integer districtCount = mapCountryWithDistrictCount.get(recState.Country__r.Id);
            recState.Country__r.Number_of_District__c = recState.Country__r.Number_of_District__c + districtCount;
            listCountry.add(recState.Country__r);    
        }

        if(!listState.isEmpty()){
            update listState;
        }
        if(!listCountry.isEmpty()){
            update listCountry;
        }

        updateJsonField(listCountry);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to update Country Hierarchy field
      * Params        :    List<Country__c> listCountry
      * Return        :    Void
    */
    public static void updateJsonField(List<Country__c> listCountry){
        Set<String> setCountryAlphabet = new Set<String>();    

        for(Country__c recCountry : listCountry){
            setCountryAlphabet.add(recCountry.Name.substring(0,1));
        }

        for(String countryAlphabet : setCountryAlphabet){
            CountriesAndDistrictsDynamic objHierarchy = new CountriesAndDistrictsDynamic(countryAlphabet);
        }
    }
}