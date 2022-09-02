/*
  *  Purpose         :    Class to query records for LWC Component  
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/09/01
  *  Revision Logs   :    V_1.0 - Created - 2022/09/01
*/
public with sharing class AccountChildRecordsComponentHelper{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    To query Conatct records
      * Params        :    Id accId
      * Return        :    List<Account>
    */
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(Id accId){
        List<Contact> listContact = [Select Id, Name from Contact where AccountId = :accId];
        return listContact;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    To query Opportunity records
      * Params        :    Id accId
      * Return        :    List<Opportunity>
    */
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity(Id accId){
        List<Opportunity> listOpp = [Select Id, Name from Opportunity where AccountId = :accId];
        return listOpp;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    To query Case records
      * Params        :    Id accId
      * Return        :    List<Case>
    */
    @AuraEnabled(cacheable=true)
    public static List<Case> getCase(Id accId){
        List<Case> listCase = [Select Id, CaseNumber, Status from Case where AccountId = :accId];
        return listCase;
    }
}