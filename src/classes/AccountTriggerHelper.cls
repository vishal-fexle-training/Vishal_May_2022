/*
  *  Purpose         :    Helper class for triggers
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/19
  *  Revision Logs   :    V_1.0 - Created - 2022/07/19
*/
public with sharing class AccountTriggerHelper{
    public static Boolean flag = true;
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called if Account records are inserted
      * Params        :    List<Account> listNewAcc
      * Return        :    Void
    */
    public static void triggerInsertDisplayRecords(List<Account> listNewAcc){
        System.debug('Newly inserted record is');
        for(Account newAcc : listNewAcc){
            /*
            newAcc.Test_Value__c = 10;
            Allowed in BEFORE_TRIGGER 
            Not allowed in AFTER_TRIGGER because in AFTER_TRIGGER Trigger.New is read-only 
            Exception - System.FinalException: Record is read-only
            */
            
            /*
            Update listNewAcc;

            System.SObjectException: DML statement cannot operate on trigger.new or trigger.old
            When we initiate a database operation :-
                Before Triggers -> Database Operation -> After Triggers
            In before triggers actions are performed before the record commits in database
            Where we usually do validations or update the record
            Then records are commited automatically
            So we skip the DML as whatever value we give to records it naturally gets assigned
            */
            System.debug('New Account : '+newAcc);                                                  //New Account : Account:{Id=null, Name=Acme 3, Type=Savings, RecordTypeId=0125i000000QA9dAAG}
        }
    }
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called if Account records are updated
      * Params        :    List<Account> listOldAcc, List<Account> listNewAcc
      * Return        :    Void
    */
    public static void triggerUpdateDisplayRecords(List<Account> listOldAcc, List<Account> listNewAcc){
        System.debug('Before updation value was');
        for(Account oldAcc : listOldAcc){
            /*
            oldAcc.Test_Value__c = 20;
            Trigger.old is always read-only.
            Exception - System.FinalException: Record is read-only
            */
            System.debug('Old Account : '+oldAcc);                                                  //Old Account : Account:{Id=0015i00000Kk40dAAB, Name=Acme 3, Type=Savings, RecordTypeId=0125i000000QA9dAAG}                                        
        }

        System.debug('Updated record value is');
        for(Account newAcc : listNewAcc){
            /*
            newAcc.Test_Value__c = 30;
            Allowed in BEFORE_TRIGGER 
            Not allowed in AFTER_TRIGGER because in AFTER_TRIGGER Trigger.New is read-only
            Exception - System.FinalException: Record is read-only
            */
            System.debug('New Account : '+newAcc);                                                  //New Account : Account:{Id=0015i00000Kk40dAAB, Name=Acme 4, Type=Savings, RecordTypeId=0125i000000QA9dAAG}
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called if Account records are updated
      * Params        :    List<Account> newList
      * Return        :    Void
    */
    public static void createDuplicateAccount(List<Account> newList){
        if(flag){
            flag = false;
            List<Account> listDuplicate = new List<Account>();    

            for(Account newAcc : newList){
                listDuplicate.add(new Account(Name = newAcc.Name + 'Duplicate'));
            }
            insert listDuplicate;
        }
        /*
        Here flag variable is used to stop recursion
        When flag variable is not used the exception occurs
        Exception - System.DmlException: Insert failed.
        CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY, Trigger_Account: maximum trigger depth exceeded Account trigger event
        */
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called for sending mail
      * Params        :    List<Account> listNewAcc
      * Return        :    Void
    */
    public static void triggerInsertSendMail(List<Account> listNewAcc){
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();

        for(Account newAcc : listNewAcc){
            if(newAcc.MailID__c != null && newAcc.AccountNumber != null){
                Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                mail.setToAddresses(new List<String>{newAcc.MailID__c});
                mail.setSubject('Account is created');
                mail.setSenderDisplayName('Vishal');
                mail.setHtmlBody('Congratulations '+newAcc.Name+' your Account is activated!!!! <br/> Account Number is : '+newAcc.AccountNumber);
                listMail.add(mail);
            }
        }
        System.debug(listMail);
        Messaging.sendEmail(listMail);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to check account prefix
      * Params        :    List<Account> listAccounts
      * Return        :    Void
    */
    public static void triggerCheckAccountPrefix(List<Account> listAccounts){
        for(Account recAccount : listAccounts){
            if(recAccount.type=='Savings'){
                if(!recAccount.AccountNumber.startsWith('SA')){
                    recAccount.AccountNumber.addError('Account Number must start with SA');
                }
            }
            else if(recAccount.type=='Fixed Deposit'){
                if(!recAccount.AccountNumber.startsWith('FD')){
                    recAccount.AccountNumber.addError('Account Number must start with FD');  
                }
            }
        }    
    }
}