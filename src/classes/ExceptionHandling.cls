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
    public void insertContact(String fName, String lName, Integer size){
        List<Contact> listContact =  new List<Contact>();

        for(Integer i=1 ;i<=size; i++){
            listContact.add(new Contact(FirstName = fname, LastName = lName+i));
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
      * Purpose       :    This method will create and insert contacts
      * Params        :    String fName, Integer size
      * Return        :    Void
    */
    public void insertContact(String fName, Integer size){
        List<Contact> listContact =  new List<Contact>();

        for(Integer i=1 ;i<=size; i++){
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
      * Purpose       :    This method will delete contacts
      * Params        :    Integer size
      * Return        :    Void
    */
    public void deleteRecords(Integer size){
        List<Contact> listContact =  [Select Name from Contact order by CreatedDate limit :size];

        delete listContact;
    }
}