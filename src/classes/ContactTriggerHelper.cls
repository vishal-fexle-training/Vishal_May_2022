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
      * Params        :    List<Contact> newList
      * Return        :    Void
    */
    public static void updateStatus(List<Contact> newList){
        List<Contact> listContactWithoutStatus = new List<Contact>();
        Set<Id> setAccountId = new Set<Id>();
        Map<Id, Account> mapAccount;

        for(Contact newContact : newList){
            if(newContact.Status__c == null && newContact.AccountId != null){
                setAccountId.add(newContact.AccountId);
                listContactWithoutStatus.add(newContact);
            }
        }

        if(!setAccountId.isEmpty()){
            mapAccount = new Map<Id, Account>([Select Id, Status__c, Property__r.Status__c from Account where Id IN :setAccountId]);

            for(Contact newContact : listContactWithoutStatus){
                if(mapAccount.get(newContact.AccountId).Status__c != null){
                    newContact.Status__c =  mapAccount.get(newContact.AccountId).Status__c;   
                }
                else if(mapAccount.get(newContact.AccountId).Property__r.Status__c != null){
                    Constants.restrictAccountChange = false;
                    mapAccount.get(newContact.AccountId).Status__c = mapAccount.get(newContact.AccountId).Property__r.Status__c;
                    
                    newContact.Status__c = mapAccount.get(newContact.AccountId).Property__r.Status__c;
                }
            }
        }
        if(Constants.restrictAccountChange == false){
            Update mapAccount.values();
        }
    }
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to update status field on contact
      * Params        :    List<Contact> newList, Map<Id, Contact> oldMap
      * Return        :    Void
    */
    public static void updateAccountAndPropertyStatus(List<Contact> newList, Map<Id, Contact> oldMap){
        Map<Id, String> mapAccountIdWithStatus = new Map<Id, String>();

        for(Contact newContact : newList){
            if(newContact.Status__c != oldMap.get(newContact.Id).Status__c){
                mapAccountIdWithStatus.put(newContact.AccountId, newContact.Status__c);
            }
        }

        if(!mapAccountIdWithStatus.isEmpty()){
            Constants.restrictAccountChange = false;
            Constants.restrictPropertyChange = false;

            List<Account> listAccount = [Select Id, Status__c, Property__r.Status__c from Account where Id IN :mapAccountIdWithStatus.keySet()];
            Set<Property__c> setProperty = new Set<Property__c>();

            if(!listAccount.isEmpty()){
                for(Account recAccount : listAccount){
                    recAccount.Status__c = mapAccountIdWithStatus.get(recAccount.Id);

                    if(recAccount.Property__r.Status__c != null){
                        recAccount.Property__r.Status__c = mapAccountIdWithStatus.get(recAccount.Id);
                        setProperty.add(recAccount.Property__r);
                    }
                }
                update listAccount;

                if(!setProperty.isEmpty()){
                    update new List<Property__c>(setProperty);
                }
            }
        }
    }
}