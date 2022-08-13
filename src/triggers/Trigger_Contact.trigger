/*
  *  Purpose         :    Trigger to update status field on contact
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/10
  *  Revision Logs   :    V_1.0 - Created - 2022/08/10
*/
trigger Trigger_Contact on Contact (before insert, before update){
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            ContactTriggerHelper.updateStatus(Trigger.new);
        }
    }
}