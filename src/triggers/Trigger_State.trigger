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