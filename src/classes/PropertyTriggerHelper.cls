/*
  *  Purpose         :    Helper Class for property object
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/17
  *  Revision Logs   :    V_1.0 - Created - 2022/08/17
*/
public with sharing class PropertyTriggerHelper{
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to update status field on account
      * Params        :    List<Property__c> newList, Map<Id, Property__c> oldMap
      * Return        :    Void
    */
    public static void updateAccountAndContactStatus(List<Property__c> newList, Map<Id, Property__c> oldMap){
        Map<Id, String> mapPropertyIdWithStatus = new Map<Id, String>();
    
        for(Property__c newProperty : newList){
            if(newProperty.Status__c != oldMap.get(newProperty.Id).Status__c){
                mapPropertyIdWithStatus.put(newProperty.Id, newProperty.Status__c);
            }
        }

        if(!mapPropertyIdWithStatus.isEmpty()){
            Constants.restrictAccountChange = false;
            Constants.restricContactChange = false;

            List<Account> listAccount = [Select Id, Status__c, Property__r.Id, (Select Id, Status__c from Contacts) from Account 
                                        where Property__r.Id IN :mapPropertyIdWithStatus.keySet()];
            Set<Contact> setContact = new Set<Contact>();
            
            if(!listAccount.isEmpty()){
                for(Account recAccount : listAccount){
                    recAccount.Status__c = mapPropertyIdWithStatus.get(recAccount.Property__r.Id);
                    
                    for(Contact recContact : recAccount.Contacts){
                        recContact.Status__c = mapPropertyIdWithStatus.get(recAccount.Property__r.Id);
                        setContact.add(recContact);    
                    }
                }
                update listAccount;

                if(!setContact.isEmpty()){
                    update new List<Contact>(setContact);
                }
            }
        }
    }
}