public with sharing class CollectionClass 
{
    public CollectionClass() 
    {
        //List
        List<String> l1 = new List<String>();
        l1.add('Rajasthan');
        l1.add('Gujarat');
        l1.add('Maharashtra');
        System.debug('Values in List : ' + l1);
        
        System.debug('Value at 2 index : ' + l1.get(1));

        List<String> dupl1 = l1.clone();
        System.debug('Copy of l1 : ' + dupl1);

        dupl1.sort();
        System.debug('After Sorting : ' + dupl1);

        //Set
        Set<Integer> s1 = new Set<Integer>();
        s1.add(2);
        s1.add(6);
        s1.add(4);
        System.debug('Values in Set : ' + s1);

        List <Integer> l2 = new List<Integer>{3,9,1};
        s1.addall(l2);

        System.debug('Check if list values are present : ' + s1.containsAll(l2));

        System.debug('After adding list values in Set : ' + s1);

        System.debug('Check if 10 is present : ' + s1.contains(10));

        s1.remove(3);
        System.debug('After emoving element 3 : ' + s1);

        Set<Account> s2 = new Set<Account>();
        Account a1 = new Account(Name = 'Flipkart', NumberOfEmployees = 50000);
        Account a2 = new Account(Name = 'Myntra', NumberOfEmployees = 60000);
        Account a3 = new Account(Name = 'Flipkart');
        s2.add(a1);
        s2.add(a2);
        s2.add(a3);
        System.debug('Values in Account Set : ' + s2);

        //Map
        Map<Integer, String> m1 = new Map<Integer, String>();
        m1.put(10,'John');
        m1.put(20,'Michael');
        m1.put(30,'Steve');
        System.debug(m1);

        System.debug('Keys in Map : '+m1.keySet());

        m1.clear();
        System.debug('Check if Map is empty : '+m1.isEmpty());
    }
}