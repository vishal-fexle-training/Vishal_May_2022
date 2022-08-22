/*
  *  Purpose         :    Test class for Queueable Apex
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
@isTest
public with sharing class QueueableApexExampleTest{
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to test insertion of account
      * Params        :    Void
      * Return        :    Void
    */
    @isTest
    public static void testForAccount(){
        Test.startTest();
        //QueueableApexExample obj = new QueueableApexExample();
        //System.enqueueJob(obj);
        System.enqueueJob(new QueueableApexExample());
        Test.stopTest();

        Account recAccount = [Select Name, Phone from Account Where Name = 'Acc to test Queueable' Limit 1];
        System.assertEquals('(415) 555-1212', recAccount.Phone);
        System.assertNotEquals(null, recAccount);
    }
}