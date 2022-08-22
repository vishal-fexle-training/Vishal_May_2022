/*
  *  Purpose         :    Class to understand Batch Apex
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
public with sharing class DeleteAccounts implements Database.Batchable<sObject>{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    start method to query Account records
      * Params        :    Database.BatchableContext bc
      * Return        :    Database.QueryLocator
    */
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Name from Account where Name Like 'Account to delete%']);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    execute method to delete Account records
      * Params        :    Database.BatchableContext bc, List<Account> listAccount
      * Return        :    Void
    */
    public void execute(Database.BatchableContext bc, List<Account> listAccount){
        delete listAccount;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    finish method to send mail
      * Params        :    Database.BatchableContext bc
      * Return        :    Void
    */
    public void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'vishal.tourani@fexle.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Apex Batch Job completed');
        mail.setPlainTextBody('Accounts has been deleted !!!!');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}