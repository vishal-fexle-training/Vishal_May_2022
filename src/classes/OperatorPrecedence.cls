/*
  *  Purpose         :    This Class is to understand Operator Precedence
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public with sharing class OperatorPrecedence {
    public OperatorPrecedence(Integer num1, Integer num2, Integer num3, Integer num4){
        Integer result;

        result = (num1 * num2) + num3 / num4;
        System.debug('Value of (num1 + num2) * num3 / num4 is : '+result);

        result = ((num1 * num2) + num3) / num4;
        System.debug('Value of ((num1 + num2) * num3) / num4 is  : '+result);

        result = (num1 * num2) + (num3 / num4);
        System.debug('Value of (num1 + num2) * (num3 / num4) is  : '+result);

        result = num1 * (num2 + num3) / num4;
        System.debug('Value of num1 + (num2 * num3) / num4 is  : '+result);

        result = (num1 * num2 + num3) / num4;
        System.debug('Value of (num1 + num2 * num3) / num4 is  : '+result);

        result = num1 * (num2 + num3 / num4);
        System.debug('Value of (num1 + num2 * num3) / num4 is  : '+result);
    }
}