/*
  *  Purpose         :    Trigger to update details on country object
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/08
  *  Revision Logs   :    V_1.0 - Created - 2022/08/08
*/
trigger Trigger_State on State__c (before insert, before update, before delete, after insert, after update, after delete, after undelete){
    //System.debug('State Operation type : '+Trigger.operationType);

    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
            StateTriggerHelper.updateStateCount(Trigger.new, Trigger.oldMap); 
        }
        if(Trigger.isDelete){
            StateTriggerHelper.reduceStateCount(Trigger.old);
        }
    }
}