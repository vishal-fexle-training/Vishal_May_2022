/*
  *  Purpose         :    Helper class for triggers
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/19
  *  Revision Logs   :    V_1.0 - Created - 2022/07/19
*/
public with sharing class TriggerHelperClass{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called if Account records are inserted
      * Params        :    List<Account> newAcc
      * Return        :    Void
    */
    public static void triggerInsertDisplayRecords(List<Account> newAcc){
        System.debug('Newly inserted record is');
        for(Account recAcc : newAcc){
            System.debug('Name of Account : '+recAcc.Name);
            System.debug('Account Number : '+recAcc.AccountNumber);
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
            System.debug('Name of Account : '+recAcc.Name);
            System.debug('Account Number : '+recAcc.AccountNumber);
        }

        System.debug('Updated record value is');
        for(Account recAcc : newAcc){
            System.debug('Name of Account : '+recAcc.Name);
            System.debug('Account Number : '+recAcc.AccountNumber);
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
            if(recAcc.MailID__c != null){
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