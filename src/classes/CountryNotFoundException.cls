/*
  *  Purpose         :    Exception class when country is not found
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/07
  *  Revision Logs   :    V_1.0 - Created - 2022/07/07
*/
public with sharing class CountryNotFoundException extends Exception{
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display message when exception occurs
      * Params        :    Void
      * Return        :    String
    */
    public override String getMessage(){
        return 'Country Not Found';
    }
}