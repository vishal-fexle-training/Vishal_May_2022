/*
  *  Purpose         :    Test class for future DML
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
@isTest
public class FutureDMLTest{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to insert account and user record
      * Params        :    Void
      * Return        :    Void
    */
    @isTest 
    public static void testForAccountAndUser(){
        //UserInfo will query details of current user
        User recUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];

        //System.runAs() allows mixed DML operations in test context
        System.runAs(recUser){
            //startTest/stopTest block to run future method synchronously
            Test.startTest();        
            FutureDML.useFutureMethod();
            Test.stopTest();
        }
        //The future method will run after Test.stopTest();
        
        //To Verify account is created
        Account[] accts = [SELECT Id from Account WHERE Name='Account for User'];
        System.assertEquals(1, accts.size());

        //To Verify user is created
        User[] users = [SELECT Id from User where username='vishal.tourani@fexle.com'];
        System.assertEquals(1, users.size());
    }
}