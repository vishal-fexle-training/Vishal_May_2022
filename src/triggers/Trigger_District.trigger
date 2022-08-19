/*
  *  Purpose         :    Trigger to update details on country and state object
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/08/08
  *  Revision Logs   :    V_1.0 - Created - 2022/08/08
*/
trigger Trigger_District on District__c (before insert, before update, before delete, after insert, after update, after delete, after undelete){
    //System.debug('District Operation type : '+Trigger.operationType);
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
            DistrictTriggerHelper.updateDistrictCount(Trigger.New, Trigger.oldMap);
        }
        if(Trigger.isDelete){
            DistrictTriggerHelper.reduceDistrictCount(Trigger.old);
        }
    }
}