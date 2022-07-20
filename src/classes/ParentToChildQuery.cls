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
        for(Account recAccount : [Select Name,(Select FirstName, LastName From Contacts) From Account limit 2]){
            System.debug('Name : '+recAccount.Name);                                                                    //Name : GenePoint

            for(Contact recContact : recAccount.Contacts){
                System.debug('First Name : '+recContact.FirstName+', Last Name : '+recContact.LastName);                //First Name : Edna, Last Name : Frank
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
            System.debug('Name : '+recCollege.Name+', City : '+recCollege.City__c);                                     //Name : Aryabhatta College, City : Jaipur

            for(Teacher__c recTeacher : recCollege.Teachers__r){
                System.debug('Name of Teacher : '+recTeacher.Name);                                                     //Name of Teacher : Suresh Mishra       //Name of Teacher : Deepika Rawat
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Query records from parent(standard object) to child(custom object)
      * Params        :    Void
      * Return        :    Void
    */
    public void standardObjectAsParent(){
        for(Account recAccount : [Select Name,(Select Name from Books__r) from Account]){   
            System.debug('Account Name : '+recAccount.Name);                                                            //Account Name : Acme1

            for(Book__c recBook : recAccount.Books__r){
                System.debug('Book Name : '+recBook.Name);                                                              //Book Name : Harry Potter
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Query records from parent(custom object) to child(standard object)
      * Params        :    Void
      * Return        :    Void
    */
    public void customObjectAsParent(){
        for(Notebook__c recNotebook : [Select Name,(Select Name from Accounts__r) from Notebook__c]){
            System.debug('Notebook Name : '+recNotebook.Name);                                                          //Notebook Name : Maths                               

            for(Account recAccount : recNotebook.Accounts__r){
                System.debug('Account Name : '+recAccount.Name);                                                        //Account Name : Acme2
            }
        }
    }
}