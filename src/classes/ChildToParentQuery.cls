/*
  *  Purpose         :    Class to query records from child to parent object
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/11
  *  Revision Logs   :    V_1.0 - Created - 2022/07/11
*/
public with sharing class ChildToParentQuery{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will query records from child to parent standard object
      * Params        :    Integer size
      * Return        :    Void
    */
    public void onStandardObject(Integer size){
        List<Contact> listContact =  new List<Contact>();
        Account recAccount = [Select Name From Account Where Name = 'Acme1' limit 1];

        //Inserting Records
        for(Integer i=1 ;i<=size; i++){
            listContact.add(new Contact(FirstName = 'Con', LastName = ''+i, AccountId = recAccount.Id));
        } 
        insert listContact;
        
        //Updating Records
        recAccount = [Select Name from Account where Name = 'Acme2'];
        for(Contact recContact : listContact){
            recContact.AccountId = recAccount.Id;
        }
        update listContact;

        //Querying inserted records
        for(Contact recContact : [Select Name, Account.Name From Contact Where Name like 'Con%']){
            System.debug('Name : '+recContact.Name+', Account Name : '+recContact.Account.Name);
        }       
        
        //Deleteing Records
        delete listContact;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will query records from child to parent custom object
      * Params        :    Void
      * Return        :    Void
    */
    public void onCustomObject(){
        for(Teacher__c recTeacher : [Select Name, College__r.Name, College__r.City__c From Teacher__c]){
            System.debug('Name : '+recTeacher.Name+', College : '+recTeacher.College__r.Name+', City : '+recTeacher.College__r.City__c);
        }
    }
}