/*
  *  Purpose         :    Constant class
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/04
  *  Revision Logs   :    V_1.0 - Created - 2022/07/04
*/
public with sharing class Constants{
    //Constants for Opportunity Stage
    public static final String OPP_STAGE_SHIPPED_TO_CUSTOMER = 'Shipped to Customer';
    public static final String OPP_STAGE_RETURN_TO_CUSTOMER = 'Return to Customer';
    public static final String OPP_STAGE_RETURN_TO_HQ = 'Return to HQ';

    //Constants for Automobile Sensor
    public static final Integer AUTOMOBILE_SIZE = 18;
    public static final String AUTOMOBILE_SENSOR = '00:11:CE:00';
    public static final String AUTOMOBILE_PRESENCE_SENSOR = '00:11:CE:D';
    public static final String AUTOMOBILE_TDU = '00:11:CE:E';
}