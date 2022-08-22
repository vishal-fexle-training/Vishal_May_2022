/*
  *  Purpose         :    Class to understand Scheduled Apex
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
public with sharing class ScheduledApexExample implements Schedulable{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to update account record
      * Params        :    SchedulableContext ct
      * Return        :    Void
    */
    public void execute(SchedulableContext ct){
        Account recAccount = [Select Id, Name from Account where Name = 'Acc to test Scheduled'];
        recAccount.name = 'Acc to test Scheduled Updated';
        update recAccount;
    }
}