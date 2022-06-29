/*
  *  Purpose         :    This Class is used to try Argument Passing
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/24
  *  Revision Logs   :    V_1.0 - Created - 2022/06/24
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
      * Purpose       :    This method will display multiplication of 2 values(Method Overloading)
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void multiplication(Integer num1, Integer num2){
        System.debug('Multiplying Values : '+(num1*num2));
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display multiplication of 3 values(Method Overloading)
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void multiplication(Integer num1, Integer num2, Integer num3){
        System.debug('Multiplying Values : '+(num1*num2*num3));
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
}