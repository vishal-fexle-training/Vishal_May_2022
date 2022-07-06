/*
  *  Purpose         :    This Class is to check datatype of object
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public with sharing class CheckObjectType{
    public CheckObjectType(){
        sObject obj1 = [Select Name from Account limit 1];
        Account acc1 = (Account)obj1;

        /*
        sObject obj2 = new Account();
        Contact con1 = (Contact)obj2;
        Account object cannot be type casted into contact this will generate an error during run time
        */

        /*
        sObject obj3 = new Contact();
        Contact con2 = (Account)obj3;
        Contact cannot be type casted into account this will generate an error during compile time
        */

        List<sObject> listObj = new List<sObject>();
        listObj.add([Select Name from Account limit 1]);
        listObj.add([Select Name from Contact limit 1]);
        listObj.add([Select Name from Student__c limit 1]);

        for(sObject obj : listObj){
            if(obj instanceof Account){
                Account rec = (Account)obj;
                System.debug(rec.Name);
            }
            else if(obj instanceof Contact){
                Contact rec = (Contact)obj;
                System.debug(rec.Name);
            }
            else if(obj instanceof Student__c){
                Student__c rec = (Student__c)obj;
                System.debug(rec.Name);
            }
        }
    }
}