/*
  *  Purpose         :    This Class is to process orders
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public with sharing class ProcessPurchaseOrder{
    PurchaseOrder orderCustomer;
    PurchaseOrder orderEmployee;

    public ProcessPurchaseOrder(){
        orderCustomer = new CustomerPurchaseOrder();
        orderEmployee = new EmployeePurchaseOrder();
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
            /*
            order.benifit();
            Error : Method does not exist or incorrect signature
            Cannot call this method because this method is not define in interface
            */
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will process orders
      * Params        :    Void
      * Return        :    Void
    */
    public void orderPurchased(){
        processOrder(orderCustomer);
        processOrder(orderEmployee);
    }
}