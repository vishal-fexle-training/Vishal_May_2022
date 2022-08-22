/*
  *  Purpose         :    To understand Queueable Apex
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
public with sharing class QueueableApexExample implements Queueable{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to insert account
      * Params        :    QueueableContext context
      * Return        :    Void
    */
    public void execute(QueueableContext context){
        Account recAccount = new Account(Name = 'Acc to test Queueable', Phone = '(415) 555-1212');
        insert recAccount;
    }
}