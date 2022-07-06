/*
  *  Purpose         :    This Class is used to use various Control Statements
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/24
  *  Revision Logs   :    V_1.0 - Created - 2022/06/24
*/
public with sharing class ControlStatements{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will check if Number is Even or Odd(Using if else)
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void checkEven(Integer num){
        if(math.mod(num,2)==0)
            System.debug('It is a Even Number');
        else 
            System.debug('It is a Odd Number');
    }       

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display grade(Using if else if ladder)
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void checkGrade(Integer num){
        if(num<=36)
            System.debug('Fail');
        else if(num>=37 && num<=60)
            System.debug('C');
        else if(num>=61 && num<=85)
            System.debug('B');
        else
            System.debug('A');
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display rank(Using switch)
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void checkRank(Integer num){   
        switch on num {
            when 1 {
                System.debug('Winner');
            }
            when 2 {
                System.debug('Runner Up');
            }
            when 3 {
                System.debug('Second Runner Up');
            }
            when else {
                System.debug('Participant');
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will print table(Using do while loop)
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void displayTable(Integer num){
        Integer count=1;
        do{
            System.debug(num+' * '+count+' = '+(num*count));
            count++;
        }while(count>=10);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display sum(Using while loop)
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void displaySum(Integer num){
        Integer count=num;
        Integer sum=0;
        while(num>=count){
            sum+=count;
            count++;
        }
        System.debug('Sum is : '+sum);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display prime numbers(Using for loop)
      * Params        :    Integer num
      * Return        :    Void
    */
    public static void printPrime(Integer num){
        for(Integer i=2; i<=num; i++){
            Integer count=2;

            while(i>=count){
                if(math.mod(i,count)==0)
                    break;
                else
                    count++;
            }
            if(i==count)
                System.debug(i+' is Prime Number');
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display list of students(Using for each loop)
      * Params        :    Void
      * Return        :    Void
    */
    public static void displayStudents(){
        List<Student__c> listStudents = [Select Roll_Number__c, Name, Email__c from Student__c];
        for(Student__c student : listStudents){
	        System.debug('Student Details : '+student);
        }
    }
}