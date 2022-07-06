/*
  *  Purpose         :    This Class is to understand access modifiers
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/01
  *  Revision Logs   :    V_1.0 - Created - 2022/07/01
*/
public with sharing class AccessModifiers{

    public Integer rollNo = 10;
    protected String firstName = 'Tushar';
    String lastName = 'Mittal';

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will return first name
      * Params        :    Void
      * Return        :    String
    */
    public String getFirstName(){
        return firstName;
        //To access first name because access modifier is protected
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will return last name
      * Params        :    Void
      * Return        :    String
    */
    public String getLastName(){
        return lastName;
        //To access last name because access modifier is private(default)
        //Also to provide access to the classes that extend
    }
}