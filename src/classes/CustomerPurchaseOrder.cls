/*
  *  Purpose         :    This Class is for orders purchased by Customer
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public class CustomerPurchaseOrder implements PurchaseOrder{
    public Double discount(){
        return .05;  
        //Will give 5 percent discount
    }
}