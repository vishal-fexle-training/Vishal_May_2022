/*
  *  Purpose         :    This Class is to understand externalId field
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/08
  *  Revision Logs   :    V_1.0 - Created - 2022/07/08
*/
public with sharing class ExternalId{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method  creates parent and child record in single statement
      * Params        :    String fName, String lName, Integer size
      * Return        :    Void
    */
    public void insertContact(){
        List<Contact> listContact =  new List<Contact>();
        Account accountReference = new Account(MyExtID__c='SAP111111');
        
        Contact con1 = new Contact(FirstName = 'Bruce', LastName = 'Wayne', Account = accountReference);
        Contact con2 = new Contact(FirstName = 'John', LastName = 'Tyson', Account = accountReference);

        Account parentAccount = new Account(Name='Hallie',MyExtID__c='SAP111111');

        Database.SaveResult[] results = Database.insert(new SObject[] {parentAccount, con1}, false);
        
        for(Integer i = 0; i < results.size(); i++){
            if(results[i].isSuccess()){
                System.debug('Successfully created ID: '+ results[i].getId());                                      //0015i00000A9hYwAAJ  //0035i000009CvBOAA0
            } 
            else{
                System.debug('Error: could not create sobject '+ 'for array element ' + i + '.');
                System.debug('The error reported was: '+ results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }
}