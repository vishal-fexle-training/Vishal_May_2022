/*
  *  Purpose         :    This Class will classify districts according to states and countries
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2021/12/10
  *  Revision Logs   :    V_2.0 - Created - 2022/06/24
*/
public with sharing class CountriesAndDistricts{
    Map<Integer, Map<String, Map<String, List<String>>>> mapCountryCode = new Map<Integer, Map<String, Map<String, List<String>>>>();

    //List<String> listCountry = new List<String>{'India', 'Australia', 'Germany'};
    public CountriesAndDistricts(){
        //Lists for Bangladesh,880
        List<String> districtBarisalDivision = new List<String>{'Bhola', 'Jhalokati', 'Patuakhali'};
        List<String> districtRangpurDivision = new List<String>{'Saidpur', 'Kaunia', 'Chilmari', 'Niphamari'};

        //Lists for China,86
        List<String> districtChongqing = new List<String>{'Chengkou', 'Fendu', 'Bishan'};
        List<String> districtShanghai = new List<String>{'Huajing', 'Fengjing', 'Jinze', 'Qibao'};

        //Lists for India,91
        List<String> districtRajasthan = new List<String>{'Ajmer', 'Jaipur', 'Udaipur', 'Jodhpur'};
        List<String> districtGujarat = new List<String>{'Ahmedabad', 'Anand', 'Surat', 'Mehsana'};
        List<String> districtMaharashtra = new List<String>{'Pune', 'Mumbai', 'Nagpur'};
        
        //Lists for Australia,61
        List<String> districtTexas = new List<String>{'Dallas', 'San Antonio', 'Austin'};
        List<String> districtNewYork = new List<String>{'Troy', 'Watertown', 'Syracuse'};

        //Lists for Germany,49
        List<String> districtHamburg = new List<String>{'Steilshoop', 'St. Georg', 'Syracuse'};
        List<String> districtBerlin = new List<String>{'Mitte', 'Pankow', 'Spandau'};

        //Assigning List of districts according to states
        Map<String, List<String>> mapIndia = new Map<String, List<String>>{'Rajasthan'=>districtRajasthan , 'Gujarat'=>districtGujarat , 'Maharashtra'=>districtMaharashtra};
        Map<String, List<String>> mapChina = new Map<String, List<String>>{'Chongqing'=>districtChongqing, 'Shanghai'=>districtShanghai};
        Map<String, List<String>> mapBangladesh = new Map<String, List<String>>{'Barisal Division'=>districtBarisalDivision, 'Rangpur Division'=>districtRangpurDivision};
        Map<String, List<String>> mapAustralia = new Map<String, List<String>>{'Texas'=>districtTexas , 'New York'=>districtNewYork};
        Map<String, List<String>> mapGermany = new Map<String, List<String>>{'Hamburg'=>districtHamburg , 'Berlin'=>districtBerlin};

        //Assigning Map of states according to country
        Map<String, Map<String, List<String>>> mapAsia = new Map<String, Map<String, List<String>>>{'India'=> mapIndia, 'China'=> mapChina, 'Bangladesh'=> mapBangladesh};
        Map<String, Map<String, List<String>>> mapOceania = new Map<String, Map<String, List<String>>>{'Australia'=> mapAustralia};
        Map<String, Map<String, List<String>>> mapEurope = new Map<String, Map<String, List<String>>>{'Germany'=> mapGermany};

        //Assigning Map of country 
        mapCountryCode = new Map<Integer, Map<String, Map<String, List<String>>>>{1=>mapAsia, 2=>mapOceania, 3=>mapEurope};
    }
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display country, states and districts starting with same alphabet
      * Params        :    String startingCharacter
      * Return        :    Void
    */
    public void findWith(String startingCharacter){
        //To get Continent Code Set
        Set<Integer> setKeys =  mapCountryCode.keySet();
        Integer flag=0;

        //To get Continent Code
        for(Integer keyCountryCode : mapCountryCode.keySet()){
            //To get Continent Map
            Map<String, Map<String, List<String>>> mapContinent = mapCountryCode.get(keyCountryCode);

            //Iterating Country Name keys from map
            for(String keyCountryName : mapContinent.keySet()){
                //Checking Country Name starts from
                if(keyCountryName.startsWithIgnoreCase(startingCharacter)){
                    //To get Country Map
                    Map<String, List<String>> mapCountry = mapContinent.get(keyCountryName);

                    //Iterating State Name keys from map
                    for(String keyState : mapCountry.keySet()){
                        //Checking State Name starts from
                        if(keyState.startsWithIgnoreCase(startingCharacter)){
                            //To get district list
                            List<String> listDistricts = mapCountry.get(keyState);

                            //Iterating District Name from list
                            for(String districtName : listDistricts){
                                //Checking District Name starts from
                                if(districtName.startsWithIgnoreCase(startingCharacter)){
                                    System.debug('Country : '+keyCountryName+', State : '+keyState+', District : '+districtName);
                                    flag = 1;
                                }
                            }
                        }
                    }
                }
            }
        } 
        if(flag==0){
            System.debug('Country, state and district not found with same alphabet : '+startingCharacter);
        }
    }
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display districts with same longest size
      * Params        :    Integer longestSize
      * Return        :    Void
    */
    public void longestDistrict(Integer longestSize){
        List<String> allDistricts = new List<String>();

        for(Integer keyCountryCode : mapCountryCode.keySet()){
            Map<String, Map<String, List<String>>> mapContinent = mapCountryCode.get(keyCountryCode);

            for(String keyCountryName : mapContinent.keySet()){
                Map<String, List<String>> mapCountry = mapContinent.get(keyCountryName);

                for(String keyState : mapCountry.keySet()){
                    List<String> listDistricts = mapCountry.get(keyState);
                    allDistricts.addAll(listDistricts);
                }
            }
        }

        System.debug('Districts with length greater then '+longestSize);
        for(String district : allDistricts){
            if(district.length() > longestSize){
                System.debug(district);
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display districts in country with same longest size
      * Params        :    Integer longestSize
      * Return        :    Map<String, List<String>>
    */
    public Map<Integer, Map<String, List<String>>> longestDistrictWithCountry(Integer longestSize){
        Map<Integer, Map<String, List<String>>> districtsWithCountry = new Map<Integer, Map<String, List<String>>>();
        Integer count = 0; 
        
        for(Integer keyCountryCode : mapCountryCode.keySet()){
            Map<String, Map<String, List<String>>> mapContinent = mapCountryCode.get(keyCountryCode);

            for(String keyCountryName : mapContinent.keySet()){
                Map<String, List<String>> mapCountry = mapContinent.get(keyCountryName);

                for(String keyState : mapCountry.keySet()){
                    List<String> listDistricts = mapCountry.get(keyState);

                    for(String district : listDistricts){
                        if(district.length() > longestSize){
                            System.debug(district);
                            count++;
                            Map<String, List<String>> mapTemp = new Map<String, List<String>>{keyState=>listDistricts};
                            districtsWithCountry.put(count, mapTemp);
                        }
                    }
                }
            }
        }
        return districtsWithCountry;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display districts with mentioned staring alphabet
      * Params        :    Integer longestSize
      * Return        :    Void
    */
    public void findAllStartingWith(String startingCharacter){
        Integer flag=0;

        //To get Continent Code
        for(Integer keyCountryCode : mapCountryCode.keySet()){
            //To get Continent Map
            Map<String, Map<String, List<String>>> mapContinent = mapCountryCode.get(keyCountryCode);

            //Iterating Country Name keys from map
            for(String keyCountryName : mapContinent.keySet()){
                //Checking Country Name starts from
                if(keyCountryName.startsWithIgnoreCase(startingCharacter)){
                    System.debug('Country : '+keyCountryName);

                    //To get Country Map
                    Map<String, List<String>> mapCountry = mapContinent.get(keyCountryName);

                    //Iterating State Name keys from map
                    for(String keyState : mapCountry.keySet()){
                        //Checking State Name starts from
                        if(keyState.startsWithIgnoreCase(startingCharacter)){
                            System.debug('State : '+keyState);

                            //To get district list
                            List<String> listDistricts = mapCountry.get(keyState);

                            //Iterating District Name from list
                            for(String districtName : listDistricts){
                                //Checking District Name starts from
                                if(districtName.startsWithIgnoreCase(startingCharacter)){
                                    System.debug('District : '+districtName);
                                    flag = 1;
                                }
                            }
                        }
                    }
                }
            }
        } 
        if(flag==0){
            System.debug('Country, state and district not found with same alphabet : '+startingCharacter);
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display districts with mentioned staring alphabet
      * Params        :    Integer longestSize
      * Return        :    Void
    */
    public void findDistrictsStartingWith(String startingCharacter){
        System.debug('Name of districts starting with : '+startingCharacter);
        //To get Continent Code
        for(Integer keyCountryCode : mapCountryCode.keySet()){
            //To get Continent Map
            Map<String, Map<String, List<String>>> mapContinent = mapCountryCode.get(keyCountryCode);

            //Iterating Country Name keys from map
            for(String keyCountryName : mapContinent.keySet()){
                //To get Country Map
                Map<String, List<String>> mapCountry = mapContinent.get(keyCountryName);

                //Iterating State Name keys from map
                for(String keyState : mapCountry.keySet()){
                    //To get district list
                    List<String> listDistricts = mapCountry.get(keyState);

                    //Iterating District Name from list
                    for(String districtName : listDistricts){
                        //Checking District Name starts from
                        if(districtName.startsWithIgnoreCase(startingCharacter)){
                             System.debug(districtName);
                        }
                    }
                }
            }
        } 
    }
}