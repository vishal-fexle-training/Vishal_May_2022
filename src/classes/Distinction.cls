/*
  *  Purpose         :    This Class will display Students who got Distinction(To try final keyword)
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/22
  *  Revision Logs   :    V_2.0 - Created - 2022/06/24
*/
public with sharing class Distinction{
    public final static Integer PERCENTCHECK = 75;
    public static List<Student__c> l1 = new List <Student__c>();
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method is used to display Name and Percentage of Student
      * Params        :    Void
      * Return        :    Void
    */
    public static void display(){
        l1 = [Select Name, Overall_Percentage__c from Student__c];
        
        System.debug('Students with Distinction');
        for(Student__c rec : l1){
            if(rec.Overall_Percentage__c > Distinction.PERCENTCHECK){
                System.debug(rec);
            }
        }
    }
}