/*
  *  Purpose         :    This Class is for orders purchased by Employee
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public class EmployeePurchaseOrder implements PurchaseOrder{
    public Double discount(){
      return .10; 
    }

    public void benifit(){
      System.debug('Being an Employee extra 5 percent discount is applied');
    }
}