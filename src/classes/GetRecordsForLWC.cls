/*
  *  Purpose         :    Class for DisplayAccount LWC Component  
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/26
  *  Revision Logs   :    V_1.0 - Created - 2022/08/26
*/
public with sharing class GetRecordsForLWC{
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    To query account records
      * Params        :    Void
      * Return        :    List<Account>
    */
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount(){
        return [Select Id, Name, Phone, Status__c from Account Order by CreatedDate DESC LIMIT 5];
    }
}