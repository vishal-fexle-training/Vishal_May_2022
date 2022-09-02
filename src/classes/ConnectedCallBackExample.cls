/*
  *  Purpose         :    Class to understand connectedCallBack
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/31
  *  Revision Logs   :    V_1.0 - Created - 2022/08/31
*/
public with sharing class ConnectedCallBackExample{
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method-1 to return String
      * Params        :    Void
      * Return        :    String
    */
    @AuraEnabled(cacheable=true)
    public static String getTextMethod1(){
        return 'METHOD-1';
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method-2 to return String
      * Params        :    Void
      * Return        :    String
    */
    @AuraEnabled(cacheable=true)
    public static String getTextMethod2(){
        return 'METHOD-2';
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method-3 to return String
      * Params        :    Void
      * Return        :    String
    */
    @AuraEnabled(cacheable=true)
    public static String getTextMethod3(){
        return 'METHOD-3';
    }
}