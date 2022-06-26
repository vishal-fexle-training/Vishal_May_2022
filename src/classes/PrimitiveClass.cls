/*
  *  Purpose         :    This Class is used to test Primitive Datatypes
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/22
  *  Revision Logs   :    V_2.0 - Created - 2022/06/24
*/
public with sharing class PrimitiveClass{
    public PrimitiveClass(){
        Boolean isPass = false;
        System.debug('Bolean Value is : '+isPass);

        //Date
        Date d1;
        System.debug('Date is : '+d1);
        d1 = Date.newInstance(2020,10,16);
        d1.addDays(10);
        d1.addMonths(1);
        d1.addYears(2);
        System.debug('After adding Date is : '+d1);

        //Time
        Time t1 = Time.newInstance(10,40,30,10);
        System.debug('Time is : '+t1);
        t1.addMinutes(10);
        t1.addMilliseconds(33);
        System.debug('After adding minutes : '+t1.minute());
        System.debug('After adding milliseconds : '+t1.millisecond());

        //DateTime
        Datetime dt1 = Datetime.newInstance(2021,08,20,12,48,40);
        System.debug('DateTime is : '+dt1);
        dt1.addHours(4);

        //Decimal
        Decimal phoneNum = 7896523568.0;
        System.debug('Phone Number : '+phoneNum);

        //Double
        Double d = 3.147;
        System.debug('Value in d : '+d);

        //Integer
        Integer i = 45; 
        System.debug('Value in i : '+d);

        //Long
        Long accNum = 147526325686l; 
        System.debug('Account Number : '+accNum);

        //String
        String name = 'Vishal';
        System.debug('Character at 3 position : '+name.charAt(3));
        System.debug('If contains : '+name.containsAny('ish'));
        System.debug('Difference : '+name.difference('Tushar'));
    }
}