/*
  *  Purpose         :    Class to understand future methods
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/18
  *  Revision Logs   :    V_1.0 - Created - 2022/08/18
*/
public class UserDetails{

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to create user record
      * Params        :    String userName, String userAliasName, String userEmail, String userLastName
      * Return        :    Void
    */
    @future
    public static void insertNewUserWithRole(String userName, String userAliasName, String userEmail, String userLastName){

        Profile recProfile = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole recUserRole = [SELECT Id FROM UserRole WHERE Name='COO'];
        
        //Create new user with a non-null user role ID 
        User recUser = new User(alias = userAliasName, email=userEmail, emailencodingkey='UTF-8', lastname=userLastName, languagelocalekey='en_US', 
                                localesidkey='en_US', profileid = recProfile.Id, userroleid = recUserRole.Id, timezonesidkey='America/Los_Angeles', 
                                username=userName);
        insert recUser;
    }
}