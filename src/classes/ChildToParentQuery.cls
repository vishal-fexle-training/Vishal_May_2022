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
    public void onStandardObject(Integer size){                                                                     //2
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
            System.debug('Name : '+recContact.Name+', Account Name : '+recContact.Account.Name);                    //Name : Con 2, Account Name : Acme2        //Name : Con 1, Account Name : Acme2
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
            System.debug('Name : '+recTeacher.Name);                                                                //Name : Aishwarya Verma
            System.debug('College : '+recTeacher.College__r.Name);                                                  //College : Aryan College
            System.debug('City : '+recTeacher.College__r.City__c);                                                  //City : Ajmer
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Query records from child(custom object) to parent(standard object)
      * Params        :    Void
      * Return        :    Void
    */
    public void standardObjectAsParent(){
        for(Book__c recBook : [Select Name, Account_Number__r.Name from Book__c]){
            System.debug('Book Name : '+recBook.Name);                                                              //Book Name : Harry Potter
            System.debug('Account Name : '+recBook.Account_Number__r.Name);                                         //Account Name : Acme1
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Query records from child(standard object) to parent(custom object)
      * Params        :    Void
      * Return        :    Void
    */
    public void customObjectAsParent(){
        for(Account recAccount : [Select Name, Notebook__r.Name from Account]){
            System.debug('Account Name : '+recAccount.Name);                                                        //Account Name : Acme2
            System.debug('Notebook Name : '+recAccount.Notebook__r.Name);                                           //Notebook Name : Maths
        }
    }
}