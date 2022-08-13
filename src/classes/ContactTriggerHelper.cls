/*
  *  Purpose         :    Helper class for Contact trigger
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/09
  *  Revision Logs   :    V_1.0 - Created - 2022/08/10
*/
public with sharing class ContactTriggerHelper{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to update status field on contact
      * Params        :    List<District__c> oldList
      * Return        :    Void
    */
    public static void updateStatus(List<Contact> newList){
        List<Contact> listContactWithoutStatus = new List<Contact>();
        Set<Id> setAccountId = new Set<Id>();
        Map<Id, Account> mapAccount;
        List<Account> listAccount = new List<Account>();

        for(Contact newContact : newList){
            if(newContact.Status__c == null){
                if(newContact.AccountId != null){
                    setAccountId.add(newContact.AccountId);
                    listContactWithoutStatus.add(newContact);
                }
            }
        }

        if(setAccountId != null){
            mapAccount = new Map<Id, Account>([Select Id, Status__c, Property__r.Status__c from Account where Id IN :setAccountId]);

            for(Contact newContact : listContactWithoutStatus){
                if(mapAccount.get(newContact.AccountId).Status__c != null){
                    newContact.Status__c =  mapAccount.get(newContact.AccountId).Status__c;   
                }
                else{
                    if(mapAccount.get(newContact.AccountId).Property__r.Status__c != null){
                        mapAccount.get(newContact.AccountId).Status__c = mapAccount.get(newContact.AccountId).Property__r.Status__c;
                        newContact.Status__c = mapAccount.get(newContact.AccountId).Property__r.Status__c;

                        listAccount.add(mapAccount.get(newContact.AccountId));
                    }
                }
            }
        }

        if(!listAccount.isEmpty()){
            Update listAccount;
        }
    }    
}
