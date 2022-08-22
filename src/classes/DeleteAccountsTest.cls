/*
  *  Purpose         :    Test class for DeleteAccounts
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
@isTest
public with sharing class DeleteAccountsTest{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    test method to delete Account records
      * Params        :    Void
      * Return        :    Void
    */
    @isTest
    public static void test(){
        List<Account> listAccount = new List<Account>();

        for(Integer i=0; i<10; i++){
            Account recAccount = new Account(Name = 'Account to delete '+i);
            listAccount.add(recAccount);    
        }
        insert listAccount;

        Test.startTest();
        Id batchId = Database.executeBatch(new DeleteAccounts());
        Test.stopTest();
    }    
}