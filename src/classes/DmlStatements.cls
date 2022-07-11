/*
  *  Purpose         :    This Class is to understand DML Statements
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/08
  *  Revision Logs   :    V_1.0 - Created - 2022/07/08
*/
public with sharing class DmlStatements{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will create and insert contacts
      * Params        :    Integer size
      * Return        :    Void
    */
    public void insertContacts(Integer size){
        List<Contact> listContact =  new List<Contact>();
        Account recAccount = [Select Name from Account where Name = 'Acme1'];

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
        for(Contact recContact : [Select Name, Account.Name from Contact where Name like 'Con%']){
            System.debug('Name : '+recContact.Name+', Account Name : '+recContact.Account.Name);
        }       
        
        //Deleteing Records
        delete listContact;
    }
}