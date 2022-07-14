/*
  *  Purpose         :    Class to query records from parent to child object
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/11
  *  Revision Logs   :    V_1.0 - Created - 2022/07/11
*/
public with sharing class ParentToChildQuery{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will query records from parent to child standard object
      * Params        :    Void
      * Return        :    Void
    */
    public void onStandardObject(){
        for(Account recAccount : [Select Name,(Select FirstName, LastName From Contacts) From Account]){
            System.debug('Name : '+recAccount.Name);

            for(Contact recContact : recAccount.Contacts){
                System.debug('First Name : '+recContact.FirstName+', Last Name : '+recContact.LastName);
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will query records from parent to child custom object
      * Params        :    Void
      * Return        :    Void
    */
    public void onCustomObject(){
        for(College__c recCollege : [Select Name, City__c, (Select Name From Teachers__r) From College__c]){
            System.debug('Name : '+recCollege.Name+', City : '+recCollege.City__c);

            for(Teacher__c recTeacher : recCollege.Teachers__r){
                System.debug('Name of Teacher : '+recTeacher.Name);
            }
        }
    }
}