/*
  *  Purpose         :    This Class is used to try Method Overloading
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/04
  *  Revision Logs   :    V_1.0 - Created - 2022/07/04
*/
public with sharing class MethodOverloading{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display multiplication of 2 values
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void multiplication(Integer num1, Integer num2){
        System.debug('Multiplying Values : '+(num1*num2));
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display multiplication of 3 values
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void multiplication(Integer num1, Integer num2, Integer num3){
        System.debug('Multiplying Values : '+(num1*num2*num3));
    }     
}