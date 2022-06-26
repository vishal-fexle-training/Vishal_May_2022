/*
  *  Purpose         :    This Class will updateadd and display new University Address
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/26
  *  Revision Logs   :    V_1.0 - Created - 2022/06/26
*/
public with sharing class AddUniversityAddress{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will update university address
      * Params        :    String address
      * Return        :    Void
    */
    public static void add(String address){
        List<Student__c> listStudent = new List<Student__c>();
        listStudent = [Select Name, University_Address__c from Student__c];

        for(Student__c student : listStudent){
            student.University_Address__c = address;
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display name and university address
      * Params        :    Void
      * Return        :    Void
    */
    public static void display(){
        List<Student__c> listStudent = new List<Student__c>();
        listStudent = [Select Name, University_Address__c from Student__c];

        for(Student__c student : listStudent){
            System.debug('Name : '+student.Name+' University Address : '+student.University_Address__c);
        }
    }
}