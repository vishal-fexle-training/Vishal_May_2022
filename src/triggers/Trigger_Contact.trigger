/*
  *  Purpose         :    Trigger to update status field on contact
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/10
  *  Revision Logs   :    V_1.0 - Created - 2022/08/10
*/
trigger Trigger_Contact on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete){
    //System.debug('Contact : '+Trigger.operationType);
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ContactTriggerHelper.updateStatus(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            ContactTriggerHelper.updateAccountAndPropertyStatus(Trigger.new, Trigger.oldMap);
        }
    }
}