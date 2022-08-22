/*
  *  Purpose         :    Test class for Scheduled Apex
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
@isTest
public with sharing class ScheduledApexExampleTest {

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to test updation of account
      * Params        :    Void
      * Return        :    Void
    */
    @isTest
    public static void testForAccount(){
        String CRON_EXP = '0 0 0 3 9 ? 2022';

        Test.startTest();
        
        Account recAccount = new Account(Name = 'Acc to test Scheduled');
        insert recAccount;

        String jobId = System.schedule('TestBasicScheduledApex', CRON_EXP, new ScheduledApexExample());

        CronTrigger ct = [Select Id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));
        System.assertNotEquals('Acc to test Scheduled Updated', [Select Id, Name from Account where Id = :recAccount.id].Name);

        Test.stopTest();

        System.assertEquals('Acc to test Scheduled Updated', [SELECT Id, Name FROM Account WHERE Id = :recAccount.Id].Name);
    }
}