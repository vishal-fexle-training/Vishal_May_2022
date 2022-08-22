/*
  *  Purpose         :    Class to perform DML in future methods
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
public with sharing class FutureDML{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to create Account and user record 
      * Params        :    Void
      * Return        :    Void
    */
    public static void useFutureMethod(){
        //DML operation for creating account record
        Account recAccount = new Account(Name='Account for User');
        insert recAccount;
      
        //Call future method to insert a user with a role.
        UserDetails.insertNewUserWithRole('vishal.tourani@fexle.com', 'VTourani', 'vishal.tourani@fexle.com', 'Tourani');        
    }
}