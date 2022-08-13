/*
  *  Purpose         :    Helper class for State trigger
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/08
  *  Revision Logs   :    V_1.0 - Created - 2022/08/08
*/
public with sharing class StateTriggerHelper{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to update number of states on country 
      * Params        :    List<State__c> newList, Map<Id, State__c> oldMap
      * Return        :    Void
    */
    public static void updateStateCount(List<State__c> newList, Map<Id, State__c> oldMap){
        Map<Id, Integer> mapCountryWithStateCount = new Map<Id, Integer>();
        Map<Id, Integer> mapCountryWithDistrictCount = new Map<Id, Integer>();

        for(State__c newState : newList){
            if(oldMap != null){
                if(oldMap.get(newState.Id).Country__c != newState.Country__c){
                    
                    if(mapCountryWithStateCount.containsKey(newState.Country__c)){
                        Integer count = mapCountryWithStateCount.get(newState.Country__c);
                        mapCountryWithStateCount.put(newState.Country__c, count + 1);

                        //For District
                        Integer districtCount = (Integer)newState.Number_of_District__c;
                        Integer districtCountFromMap = mapCountryWithDistrictCount.get(newState.Country__c);
                        mapCountryWithDistrictCount.put(newState.Country__c, districtCount + districtCountFromMap);
                    }
                    else{
                        mapCountryWithStateCount.put(newState.Country__c, 1);

                        //For District
                        Integer districtCount = (Integer)newState.Number_of_District__c;
                        mapCountryWithDistrictCount.put(newState.Country__c, districtCount);
                    }

                    if(mapCountryWithStateCount.containsKey(oldMap.get(newState.Id).Country__c)){
                        Integer count = mapCountryWithStateCount.get(oldMap.get(newState.Id).Country__c);
                        mapCountryWithStateCount.put(oldMap.get(newState.Id).Country__c, count -1);

                        //For District
                        Integer districtCount = (Integer)oldMap.get(newState.Id).Number_of_District__c;
                        Integer districtCountFromMap = mapCountryWithDistrictCount.get(oldMap.get(newState.Id).Country__c);
                        mapCountryWithDistrictCount.put(oldMap.get(newState.Id).Country__c, districtCountFromMap - districtCount);
                    }
                    else{
                        mapCountryWithStateCount.put(oldMap.get(newState.Id).Country__c, -1);

                        //For District
                        Integer districtCount = (Integer)oldMap.get(newState.Id).Number_of_District__c;
                        mapCountryWithDistrictCount.put(oldMap.get(newState.Id).Country__c, -districtCount);
                    }
                }
            }
            else{
                if(mapCountryWithStateCount.containsKey(newState.Country__c)){
                    Integer count = mapCountryWithStateCount.get(newState.Country__c);
                    mapCountryWithStateCount.put(newState.Country__c, count + 1);
                }
                else{
                    mapCountryWithStateCount.put(newState.Country__c, 1);
                }
            }
        }

        if(!mapCountryWithStateCount.isEmpty()){
            List<Country__c> listCountry = [Select Id, Name, Number_of_State__c, Number_of_District__c from Country__c where Id IN :mapCountryWithStateCount.keySet()];

            for(Country__c recCountry : listCountry){
                Integer count = mapCountryWithStateCount.get(recCountry.Id);

                if(recCountry.Number_of_State__c != null){
                    recCountry.Number_of_State__c = recCountry.Number_of_State__c + count;
                        
                    if(!mapCountryWithDistrictCount.isEmpty()){
                        if(recCountry.Number_of_District__c != null && mapCountryWithDistrictCount.get(recCountry.Id) != null){
                            recCountry.Number_of_District__c = recCountry.Number_of_District__c + mapCountryWithDistrictCount.get(recCountry.Id);    
                        }
                        else{
                            recCountry.Number_of_District__c = mapCountryWithDistrictCount.get(recCountry.Id);   
                        }       
                    } 
                }
                else{
                    recCountry.Number_of_State__c = count;

                    if(!mapCountryWithDistrictCount.isEmpty()){
                        recCountry.Number_of_District__c = mapCountryWithDistrictCount.get(recCountry.Id);    
                    }
                }
            }

            if(!listCountry.isEmpty()){
                update listCountry;
            }

            updateJsonField(listCountry);
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to reduce number of states on country after deletion
      * Params        :    List<State__c> oldList
      * Return        :    Void
    */
    public static void reduceStateCount(List<State__c> oldList){
        Map<Id, Integer> mapCountryWithStateCount = new Map<Id, Integer>();
        Map<Id, Integer> mapCountryWithDistrictCount = new Map<Id, Integer>();

        for(State__c recState : oldList){
            if(mapCountryWithStateCount.containsKey(recState.Country__c)){
                Integer count =  mapCountryWithStateCount.get(recState.Country__c);
                mapCountryWithStateCount.put(recState.Country__c, count - 1);
            }
            else{
                mapCountryWithStateCount.put(recState.Country__c, -1);
            }
        }

        List<Country__c> listCountry = [Select Id, Name, Number_of_State__c, Number_of_District__c from Country__c 
                                        where Id IN: mapCountryWithStateCount.keySet()];

        for(Country__c recCountry : listCountry){
            Integer count = mapCountryWithStateCount.get(recCountry.Id);
            recCountry.Number_of_State__c = recCountry.Number_of_State__c + count;
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