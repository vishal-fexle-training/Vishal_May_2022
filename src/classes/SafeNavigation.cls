/*
  *  Purpose         :    This Class is to perform safe navigation operator on different datatypes
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public with sharing class SafeNavigation{
    /*
     * Created By    :    Vishal Tourani
     * Purpose       :    This method perfroms safe navigation with String
     * Params        :    Void
     * Return        :    Void
    */
    public static void methodString(){
        String name;
        System.debug('Size of name : '+(name?.length()));
        name = 'John';
        System.debug('Size of name after assigning some value : '+(name?.length()));
    }

    /*
     * Created By    :    Vishal Tourani
     * Purpose       :    This method perfroms safe navigation with list
     * Params        :    Void
     * Return        :    Void
    */
    public static void methodList(){
        List<String> listCountry;
        System.debug('List of countries : '+listCountry?.toString());
        listCountry =  new List<String>();
		System.debug('List of countries : '+listCountry?.toString());  
        listCountry.add('India');
        listCountry.add('Germany');
        listCountry.add('USA');    
        System.debug('List of countries : '+listCountry?.toString());
    }   

    /*
     * Created By    :    Vishal Tourani
     * Purpose       :    This method perfroms safe navigation with set
     * Params        :    Void
     * Return        :    Void
    */
    public static void methodSet(){
        List<String> listCountry =  new List<String>{'India', 'Germany', 'USA'};

        Set<String> setCountry;
        System.debug('Check if elements of list are present : '+(setCountry?.containsAll(listCountry)));
        setCountry = new Set<String>();
        System.debug('Check if elements of list are present : '+(setCountry?.containsAll(listCountry)));
        setCountry.add('India');
        setCountry.add('Germany');
        setCountry.add('USA');   
        System.debug('Check if elements of list are present : '+(setCountry?.containsAll(listCountry)));
    }

    /*
     * Created By    :    Vishal Tourani
     * Purpose       :    This method perfroms safe navigation with query
     * Params        :    Void
     * Return        :    Void
    */
    public static void methodQuery(){
        String name = [Select Name from Student__c where createddate = TODAY limit 1]?.Name;
        System.debug('Student Name : '+name);
        name = [Select Name from Student__c limit 1]?.Name;
        System.debug('Student Name : '+name);
    }

    /*
     * Created By    :    Vishal Tourani
     * Purpose       :    This method perfroms safe navigation with map
     * Params        :    Void
     * Return        :    Void
    */
    public static void withMap(){
        Map<Integer, String> mapName = new Map<Integer, String>();
        String name = mapName?.get(1);
        System.debug(name);
        mapName.put(1, 'John');
        mapName.put(2, 'Alex');
        mapName.put(3, 'Bruce');
        name = mapName?.get(2);
        System.debug(name);
    }
}