/*
  *  Purpose         :    Trigger to update status field on account and contact
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/17
  *  Revision Logs   :    V_1.0 - Created - 2022/08/17
*/
trigger Trigger_Property on Property__c (after update){
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            if(Constants.restrictPropertyChange){
                PropertyTriggerHelper.updateAccountAndContactStatus(Trigger.new, Trigger.oldMap);
            }
        }
    }
}