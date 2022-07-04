/*
  *  Purpose         :    This Class is used to try Argument Passing
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/24
  *  Revision Logs   :    V_2.0 - Created - 2022/07/04
*/
public with sharing class ArgumentPassing{
    public ArgumentPassing(){
        System.debug('For pass by value');
        Integer num1=5;
        Integer num2=7;
        swap(num1, num2);
        System.debug('Values outside menthod after swaping in num1 and num2 : '+num1+', '+num2);
        
        System.debug('For pass by refrence');
        List<Integer> listNum = new List<Integer>{2,6};
        listSwap(listNum);
        System.debug('Values outside menthod in list after swaping in num0 and num1 : '+listNum[0]+', '+listNum[1]);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will swap values(Pass By Value)
      * Params        :    Integer num
      * Return        :    Void
    */
    public void swap(Integer num1, Integer num2){
        System.debug('Value in num1 and num2 : '+num1+', '+num2);
        Integer num3=num1;
        num1=num2;
        num2=num3;
        System.debug('Values inside menthod after swaping in num1 and num2 : '+num1+', '+num2);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will swap values in list(Pass By Refrence)
      * Params        :    Integer num
      * Return        :    Void
    */
    public void listSwap(List<Integer> listNum){
        System.debug('Value in num0 and num1 : '+listNum[0]+', '+listNum[1]);
        Integer temp=listNum[0];
        listNum[0]=listNum[1];
        listNum[1]=temp;
        System.debug('Values inside menthod in list after swaping in num0 and num1 : '+listNum[0]+', '+listNum[1]);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign values in list and pass to other methods
      * Params        :    String str1, String str2
      * Return        :    Void
    */
    public void listMethod_1(String str1, String str2){                   //Passing - (Rajasthan, Gujarat)
        List<String> listState = new List<String>{str1, str2};            
        System.debug('Printing in Method 1: '+listState);                 //(Rajasthan, Gujarat)

        listMethod_2(listState);  
        System.debug('Printing after calling Method 2: '+listState);      //(Rajasthan, Gujarat, Maharashtra, Uttar Pradesh)

        listMethod_3(listState);
        System.debug('Printing after calling Method 3: '+listState);      //(Rajasthan, Gujarat, Maharashtra, Uttar Pradesh)
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will add values in list received
      * Params        :    List<String> listState
      * Return        :    Void
    */
    public void listMethod_2(List<String> listState){
        listState.add('Maharashtra');
        listState.add('Uttar Pradesh');
        System.debug('Printing in method 2 : '+listState);                //(Rajasthan, Gujarat, Maharashtra, Uttar Pradesh)
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign values in list received
      * Params        :    List<String> listState
      * Return        :    Void
    */
    public void listMethod_3(List<String> listState){
        listState = new List<String>{'Kerala', 'Goa'};
        System.debug('Printing in method 3 : '+listState);                //(Kerala, Goa) 
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign values in set and pass to other methods
      * Params        :    String str1, String str2
      * Return        :    Void
    */
    public void setMethod_1(String str1, String str2){                    //Passing - (One, Two)
        Set<String> setNumber = new Set<String>{str1, str2};       
        System.debug('Printing in Method 1: '+setNumber);                 //{One, Two}    

        setMethod_2(setNumber);  
        System.debug('Printing after calling Method 2: '+setNumber);      //{Four, One, Three, Two}

        setMethod_3(setNumber);
        System.debug('Printing after calling Method 3: '+setNumber);      //{Four, One, Three, Two}
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will add values in set received
      * Params        :    Set<String> setNumber
      * Return        :    Void
    */
    public void setMethod_2(Set<String> setNumber){
        setNumber.add('Three');
        setNumber.add('Four');
        System.debug('Printing in method 2 : '+setNumber);                //{Four, One, Three, Two}
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign values in set received
      * Params        :    Set<String> setNumber
      * Return        :    Void
    */
    public void setMethod_3(Set<String> setNumber){
        setNumber = new Set<String>{'Five', 'Six'};
        System.debug('Printing in method 3 : '+setNumber);                //{Five, Six}
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign key and values in map and pass to other methods
      * Params        :    Integer key1, String value1, Integer key2, String value2
      * Return        :    Void
    */
    public void mapMethod_1(Integer key1, String value1, Integer key2, String value2){        //Passing - (1, Ramesh, 2, Suresh)
        Map<Integer, String> mapName = new Map<Integer, String>{key1=>value1, key2=>value2};       
        System.debug('Printing in Method 1: '+mapName);                                       //{1=Ramesh, 2=Suresh}

        mapMethod_2(mapName);  
        System.debug('Printing after calling Method 2: '+mapName);                            //{1=Ramesh, 2=Suresh, 3=Vishal, 4=Tushar}

        mapMethod_3(mapName);
        System.debug('Printing after calling Method 3: '+mapName);                            //{1=Ramesh, 2=Suresh, 3=Vishal, 4=Tushar}
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will put key and values in map received
      * Params        :    Map<Integer, String> mapName
      * Return        :    Void
    */
    public void mapMethod_2(Map<Integer, String> mapName){
        mapName.put(3,'Vishal');
        mapName.put(4,'Tushar');
        System.debug('Printing in method 2 : '+mapName);                                      //{1=Ramesh, 2=Suresh, 3=Vishal, 4=Tushar}
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign key and values in map received
      * Params        :    Map<Integer, String> mapName
      * Return        :    Void
    */
    public void mapMethod_3(Map<Integer, String> mapName){
        mapName = new Map<Integer, String>{5=>'Hardik', 6=>'Abhishek'};
        System.debug('Printing in method 3 : '+mapName);                                      //{5=Hardik, 6=Abhishek}
    }    

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign string and pass to other methods
      * Params        :    String str
      * Return        :    Void
    */
    public void stringMethod_1(String str){                                                   //Passing - (Apple)
        String fruit = str;       
        System.debug('Printing in Method 1: '+str);                                           //Apple

        stringMethod_2(str);  
        System.debug('Printing after calling Method 2: '+str);                                //Apple

        stringMethod_3(str);
        System.debug('Printing after calling Method 3: '+str);                                //Apple
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will manipulate received string 
      * Params        :    String str
      * Return        :    Void
    */
    public void stringMethod_2(String str){
        System.debug('Printing in method 2 : '+str.toUpperCase());                            //APPLE
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign key and values in map received
      * Params        :    String str
      * Return        :    Void
    */
    public void stringMethod_3(String str){
        str = str.toLowerCase();
        System.debug('Printing in method 3 : '+str);                                          //apple
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign integer and pass to other methods
      * Params        :    Integer num
      * Return        :    Void
    */
    public void integerMethod_1(Integer num){                                                 //Passing - (11)
        Integer prime = num;       
        System.debug('Printing in Method 1: '+prime);                                         //11

        integerMethod_2(prime);  
        System.debug('Printing after calling Method 2: '+prime);                              //11

        integerMethod_3(prime);
        System.debug('Printing after calling Method 3: '+prime);                              //11
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will manipulate received integer 
      * Params        :    Integer num
      * Return        :    Void
    */
    public void integerMethod_2(Integer num){
        num += 5;
        System.debug('Printing in method 2 : '+num);                                          //16
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign value in received integer 
      * Params        :    Integer num
      * Return        :    Void
    */
    public void integerMethod_3(Integer num){
        num = 30;
        System.debug('Printing in method 3 : '+num);                                          //30
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign double and pass to other methods
      * Params        :    Integer num
      * Return        :    Void
    */
    public void doubleMethod_1(Double num){                                                   //Passing - (11)
        Double temprature = num;       
        System.debug('Printing in Method 1: '+temprature);                                    //11.0

        doubleMethod_2(temprature);  
        System.debug('Printing after calling Method 2: '+temprature);                         //11.0

        doubleMethod_3(temprature);
        System.debug('Printing after calling Method 3: '+temprature);                         //11.0
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will manipulate received double 
      * Params        :    Integer num
      * Return        :    Void
    */
    public void doubleMethod_2(Double num){
        num += 2.34;
        System.debug('Printing in method 2 : '+num);                                          //13.34
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign value in received double 
      * Params        :    Integer num
      * Return        :    Void
    */
    public void doubleMethod_3(Double num){
        num = 5.76;
        System.debug('Printing in method 3 : '+num);                                          //5.76
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign date and pass to other methods
      * Params        :    Integer num
      * Return        :    Void
    */  
    public void dateMethod_1(Date hDate){                                                    //Passing - (Date.newInstance(2022, 06, 20))                  
        Date holiday = hDate;       
        System.debug('Printing in Method 1: '+holiday);                                      //2022-06-20 00:00:00

        dateMethod_2(holiday);  
        System.debug('Printing after calling Method 2: '+holiday);                           //2022-06-20 00:00:00

        dateMethod_3(holiday);
        System.debug('Printing after calling Method 3: '+holiday);                           //2022-06-20 00:00:00
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will manipulate received date 
      * Params        :    Integer num
      * Return        :    Void
    */
    public void dateMethod_2(Date hDate){
        System.debug('Printing in method 2 : '+hDate.addDays(4));                            //2022-06-24 00:00:00
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will assign value in received date 
      * Params        :    Integer num
      * Return        :    Void
    */
    public void dateMethod_3(Date hDate){
        hDate = Date.newInstance(1999, 01, 15);
        System.debug('Printing in method 3 : '+hDate);                                       //1999-01-15 00:00:00
    }
}