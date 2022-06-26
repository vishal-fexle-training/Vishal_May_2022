/*
  *  Purpose         :    This Class is used to test Collections
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/22
  *  Revision Logs   :    V_2.0 - Created - 2022/06/24
*/
public with sharing class CollectionClass{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is used to display list
      * Params        :    Void
      * Return        :    Void
    */
    public static void listDisplay(){
        List<String> listStates = new List<String>();
        listStates.add('Rajasthan');
        listStates.add('Gujarat');
        listStates.add('Maharashtra');
        System.debug('Values in List : '+listStates);
        
        System.debug('Value at 2 index : '+listStates.get(1));

        List<String> duplistStates = listStates.clone();
        System.debug('Copy of listStates : '+duplistStates);

        duplistStates.sort();
        System.debug('After Sorting : '+duplistStates);

        System.debug('Size of List : '+listStates.size());
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is used to display set
      * Params        :    Void
      * Return        :    Void
    */
    public static void setDisplay(){
        Set<Integer> setNumber = new Set<Integer>();
        setNumber.add(2);
        setNumber.add(6);
        setNumber.add(4);
        System.debug('Values in Set : '+setNumber);

        List <Integer> listNumber = new List<Integer>{3,9,1};
        setNumber.addall(listNumber);

        System.debug('Check if list values are present : '+setNumber.containsAll(listNumber));

        System.debug('After adding list values in Set : '+setNumber);

        System.debug('Check if 10 is present : '+setNumber.contains(10));

        setNumber.remove(3);
        System.debug('After emoving element 3 : '+setNumber);

        Set<Account> setAcc = new Set<Account>();
        Account a1 = new Account(Name = 'Flipkart', NumberOfEmployees = 50000);
        Account a2 = new Account(Name = 'Myntra', NumberOfEmployees = 60000);
        Account a3 = new Account(Name = 'Flipkart');
        setAcc.add(a1);
        setAcc.add(a2);
        setAcc.add(a3);
        System.debug('Values in Account Set : '+setAcc);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is used to display map
      * Params        :    Void
      * Return        :    Void
    */
    public static void mapDisplay(){
        Map<Integer, String> mapPeople = new Map<Integer, String>();
        mapPeople.put(10,'John');
        mapPeople.put(20,'Michael');
        mapPeople.put(30,'Steve');
        System.debug(mapPeople);

        System.debug('Keys in Map : '+mapPeople.keySet());

        System.debug('Values in Map'+mapPeople.values());

        System.debug('Check if 40 key is present : '+mapPeople.containsKey(10));

        mapPeople.clear();
        System.debug('Check if Map is empty : '+mapPeople.isEmpty());
    }
}