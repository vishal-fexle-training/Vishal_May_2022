/*
  *  Purpose         :    This Class is to understand Database methods
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/08
  *  Revision Logs   :    V_1.0 - Created - 2022/07/08
*/
public with sharing class DatabaseMethods{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method  creates parent and child record in single statement
      * Params        :    String fName, String lName, Integer size
      * Return        :    Void
    */
    public void insertContact(Integer size){                                                            //2
      List<Contact> listContact =  new List<Contact>();

      //Inserting Records
      for(Integer i=1 ;i<=size; i++){
          listContact.add(new Contact(FirstName = 'Con', LastName = ''+i));
      } 
      for(Integer i=1 ;i<=size; i++){
          listContact.add(new Contact(FirstName = 'Con'+i));
      }
      Database.SaveResult[] results = Database.insert(listContact, false);
      for(Database.SaveResult sr : results){
          if(sr.isSuccess()) {
              System.debug('Successfully inserted contacts are : ' + sr.getId());                       //0035i000009Cv9oAAC  //0035i000009Cv9pAAC    
          }
          else{              
              for(Database.Error err : sr.getErrors()){
                  System.debug('The following error has occurred.');                                                   
                  System.debug(err.getStatusCode() + ': ' + err.getMessage());                          //REQUIRED_FIELD_MISSING: Required fields are missing: [LastName]      //REQUIRED_FIELD_MISSING: Required fields are missing: [LastName]
                  System.debug('Contact fields that affected this error: ' + err.getFields());          //Contact fields that affected this error: (LastName)                  //Contact fields that affected this error: (LastName)                                                                                         
              }
          }
      }

      //Upserting Records
      for(Contact recContact : listContact){
          if(recContact.LastName == null){
            recContact.LastName = 'Updated Last Name';
          }
      }
      Database.UpsertResult[] results1 = Database.upsert(listContact);
      for(Database.UpsertResult sr : results1){
          if(sr.isSuccess()) {
              System.debug('Successfully upserted contacts are : ' + sr.getId());                       //0035i000009Cv9oAAC  //0035i000009Cv9pAAC  //0035i000009Cv9qAAC  //0035i000009Cv9rAAC
          }
          else{              
              for(Database.Error err : sr.getErrors()){
                  System.debug('The following error has occurred.');                    
                  System.debug(err.getStatusCode() + ': ' + err.getMessage());
                  System.debug('Contact fields that affected this error: ' + err.getFields());
              }
          }
      }

      //Deleteing Records
      Database.DeleteResult[] results2 = Database.delete(listContact);
      for(Database.DeleteResult sr : results2){
          if(sr.isSuccess()) {
              System.debug('Successfully deleted contacts are : ' + sr.getId());                        //0035i000009Cv9oAAC  //0035i000009Cv9pAAC  //0035i000009Cv9qAAC  //0035i000009Cv9rAAC
          }
          else{              
              for(Database.Error err : sr.getErrors()){
                  System.debug('The following error has occurred.');                    
                  System.debug(err.getStatusCode() + ': ' + err.getMessage());
                  System.debug('Contact fields that affected this error: ' + err.getFields());
              }
          }
        }
    }
}