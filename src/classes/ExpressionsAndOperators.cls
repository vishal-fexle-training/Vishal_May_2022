/*
  *  Purpose         :    This Class is to perform expressions and operators
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/24
  *  Revision Logs   :    V_1.0 - Created - 2022/06/24
*/
public with sharing class ExpressionsAndOperators{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is used to display arithmetic opearations
      * Params        :    Integer operand1, Integer operand2 
      * Return        :    Void
    */
    public static void arithmeticOperators(Integer operand1, Integer operand2){
        System.debug('Addition : '+(operand1 + operand2));
        System.debug('Subtraction : '+(operand1 + operand2));
        System.debug('Multiplication : '+(operand1 * operand2));
        System.debug('Division : '+(operand1 / operand2));
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is used to display shorthand opearations
      * Params        :    Integer operand1, Integer operand2
      * Return        :    Void
    */
    public static void shorthandOpearators(Integer operand1, Integer operand2){
        operand1+=operand2;
        System.debug('Operand 1 after addition assignment : '+operand1);
        operand1-=operand2;
        System.debug('Operand 1 after subtraction assignment: '+operand1);
        operand1*=operand2;
        System.debug('Operand 1 after multiplication assignment: '+operand1);
        operand1/=operand2;
        System.debug('Operand 1 after division assignment: '+operand1);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is used to display logical and ternary opearations
      * Params        :    Integer operand1, Integer operand2
      * Return        :    Void
    */
    public static void logicalAndTernaryOperators(Integer operand1, Integer operand2){
        String msg = operand1>operand2 ? 'Operand1 is greater than Operand2' : 'Operand2 is greater than Operand1';
        System.debug(msg);
        msg = (((operand1>10) || (operand2<10)) && (operand1>100)) ? 'True' : 'False';

        Student__c s1 = [Select Name from Student__c limit 1];
        msg = s1?.Name;
        System.debug('Student Name : '+msg);

        /*
        OR
        String msg = [Select Name from Student__c limit 1]?.Name;
        System.debug('Student Name : '+msg);
        */
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is for explicit type concversion
      * Params        :    Decimal operand1
      * Return        :    Void
    */
    public static void explicitTypeConversion(Decimal operand1){ 
        Integer operand2 = (Integer)operand1;
        System.debug('Value after Explicit Type Concersion : '+operand2);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is for implicit type concversion
      * Params        :    Integer operand1, Integer operand2
      * Return        :    Void
    */
    public static void implicitTypeConversion(Integer operand1, Integer operand2){
        Double operand3 = operand1/operand2;
        System.debug('Value after Implicit Type Concersion : '+operand3);
    }
}