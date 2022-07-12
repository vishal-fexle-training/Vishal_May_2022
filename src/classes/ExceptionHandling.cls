/*
  *  Purpose         :    This Class is to understand exception handling
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/08
  *  Revision Logs   :    V_1.0 - Created - 2022/07/08
*/
public with sharing class ExceptionHandling{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will create and insert contacts
      * Params        :    String fName, String lName, Integer size
      * Return        :    Void
    */
    public void insertContactList(String fName, String lName, Integer size){
        List<Contact> listContact =  new List<Contact>();

        for(Integer i=1 ;i<=size; i++){
            listContact.add(new Contact(FirstName = fname, LastName = lName+i));
        } 

        try{
            //Will generate List Exception because there is no such index 
            System.debug(listContact[size]);
            insert listContact;
        }
        catch(DmlException e){
            System.debug('Error : '+e.getMessage()); 
        }
        catch(ListException e){
            System.debug('List Exception occurs : '+e.getMessage());
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will create and insert contacts
      * Params        :    String fName, Integer size
      * Return        :    Void
    */
    public void insertContact(String fName, Integer size){
        List<Contact> listContact =  new List<Contact>();

        for(Integer i=1 ;i<=size; i++){
            //Will generate DML Exception because required field is not inserted
            listContact.add(new Contact(FirstName = fname+i));
        } 

        try{
            insert listContact;
        }
        catch(DmlException e){
            System.debug('Error : '+e.getMessage());
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will perform calculation
      * Params        :    Void
      * Return        :    Void
    */
    public void calculation(){
        Integer num1;
        
        try{
            //Will generate Null Pointer Exception because num1 is null
            Integer num2 = num1*10;
        }
        catch(NullPointerException e){
            System.debug('Null Exception error occured : '+e.getMessage());
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will query on Student object
      * Params        :    Void
      * Return        :    Void
    */
    public void queryStudents(){
        try{
            //Will generate Query Exception because more than one is retrieved
            Student__c recStudent = [Select Name from Student__c where Stream__c='Science']; 

            //Will generate SObject exception 
            System.debug(recStudent.Father_Name__c);
        }
        catch(QueryException e){
            System.debug('Query Exception occured : '+e.getMessage());
        }
        catch(SObjectException e){
            System.debug('SObject Exception occured : '+e.getMessage());    
        }
    }
}