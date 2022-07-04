/*
  *  Purpose         :    This Class is to find records and typecast according to object type 
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public with sharing class TypeCastSobject{
    List<Contact> listContact = new List<Contact>();
    List<Lead> listLead = new List<Lead>();
    List<Account> listAccount = new List<Account>();
    List<Student__c> listStudent = new List<Student__c>();

    public TypeCastSobject(String phoneNumber){
        List<List<SObject>> results = [FIND :phoneNumber 
                                       IN Phone FIELDS 
                                       RETURNING Contact(Id, Phone, FirstName, LastName), 
                                       Lead(Id, Phone, FirstName, LastName), 
                                       Account(Id, Phone, Name),
                                       Student__c(Id, Name, Mobile_Number__c)];

        if(!results.isEmpty()){                               
            for(List<SObject> listResults : results){
                for(SObject record : listResults){
                    if(record.getSObjectType() == Contact.sObjectType){ 
                        listContact.add((Contact) record);
                        System.debug('Records of Contact '+record);
                    }
                    else if(record.getSObjectType() == Lead.sObjectType){ 
                        listLead.add((Lead) record);
                        System.debug('Records of Lead '+record);
                    }
                    else if(record.getSObjectType() == Account.sObjectType){ 
                        listAccount.add((Account) record); 
                        System.debug('Records of Account '+record);
                    }
                    else if(record.getSObjectType() == Student__c.sObjectType){ 
                        listStudent.add((Student__c) record); 
                        System.debug('Records of Student '+record);
                        System.debug('Student Records ID : '+record.id);
                        /*
                        System.debug('Student Records Name : '+record.Name);
                        This is not allowed, typecasting is required. Only id can be accessd in sObject
                        For this use get() method as mentioned below
                        */
                        System.debug('Student Records Name : '+record.get('Name'));
                    }
                }
            }
        }
    }
}