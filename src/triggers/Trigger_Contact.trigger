trigger Trigger_Contact on Contact (before insert, before update){
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            ContactTriggerHelper.updateStatus(Trigger.new);
        }
    }
}