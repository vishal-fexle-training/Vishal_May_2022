/*
  *  Purpose         :    This Class is to process orders
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public with sharing class ProcessPurchaseOrder{
    public ProcessPurchaseOrder(){
        PurchaseOrder order1 = new CustomerPurchaseOrder();
        PurchaseOrder order2 = new EmployeePurchaseOrder();

        processOrder(order1);
        processOrder(order2);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display discount
      * Params        :    PurchaseOrder order
      * Return        :    Void
    */
    public void processOrder(PurchaseOrder order){
        if(order instanceof CustomerPurchaseOrder){
            System.debug('Check Discount for Customer : '+order.discount());
        }
        else{
            System.debug('Check Discount for Employee : '+order.discount());
        }
    }
}