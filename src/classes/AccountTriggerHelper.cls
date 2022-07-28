/*
  *  Purpose         :    Helper class for triggers
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/19
  *  Revision Logs   :    V_1.0 - Created - 2022/07/19
*/
public with sharing class AccountTriggerHelper{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called if Account records are inserted
      * Params        :    List<Account> newAcc
      * Return        :    Void
    */
    public static void triggerInsertDisplayRecords(List<Account> newAcc){
        System.debug('Newly inserted record is');
        for(Account recAcc : newAcc){
            /*
            recAcc.Test_Value__c = 10;
            Allowed in BEFORE_TRIGGER 
            Not allowed in AFTER_TRIGGER because in AFTER_TRIGGER Trigger.New is read-only 
            Exception - System.FinalException: Record is read-only
            */
            System.debug('New Account : '+recAcc);                                                  //New Account : Account:{Id=null, Name=Acme 3, Type=Savings, RecordTypeId=0125i000000QA9dAAG}
        }
    }
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called if Account records are updated
      * Params        :    List<Account> oldAcc, List<Account> newAcc
      * Return        :    Void
    */
    public static void triggerUpdateDisplayRecords(List<Account> oldAcc, List<Account> newAcc){
        System.debug('Before updation value was');
        for(Account recAcc : oldAcc){
            /*
            recAcc.Test_Value__c = 20;
            Trigger.old is always read-only.
            Exception - System.FinalException: Record is read-only
            */
            System.debug('Old Account : '+recAcc);                                                  //Old Account : Account:{Id=0015i00000Kk40dAAB, Name=Acme 3, Type=Savings, RecordTypeId=0125i000000QA9dAAG}                                        
        }

        System.debug('Updated record value is');
        for(Account recAcc : newAcc){
            /*
            recAcc.Test_Value__c = 30;
            Allowed in BEFORE_TRIGGER 
            Not allowed in AFTER_TRIGGER because in AFTER_TRIGGER Trigger.New is read-only
            Exception - System.FinalException: Record is read-only
            */
            System.debug('New Account : '+recAcc);                                                  //New Account : Account:{Id=0015i00000Kk40dAAB, Name=Acme 4, Type=Savings, RecordTypeId=0125i000000QA9dAAG}
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called for sending mail
      * Params        :    List<Account> newAcc
      * Return        :    Void
    */
    public static void triggerInsertSendMail(List<Account> newAcc){
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();

        for(Account recAcc : newAcc){
            if(recAcc.MailID__c != null && recAcc.AccountNumber != null){
                Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                mail.setToAddresses(new List<String>{recAcc.MailID__c});
                mail.setSubject('Account is created');
                mail.setSenderDisplayName('Vishal');
                mail.setHtmlBody('Congratulations '+recAcc.Name+' your Account is activated!!!! <br/> Account Number is : '+recAcc.AccountNumber);
                listMail.add(mail);
            }
        }
        System.debug(listMail);
        Messaging.sendEmail(listMail);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to check account prefix
      * Params        :    List<Account> newAcc
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