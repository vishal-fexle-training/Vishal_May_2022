trigger Trigger_Opportunity on Opportunity (before insert, after insert, before update, after update, after delete, after undelete){
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OpportunityTriggerHelper.checkAutomobileSize(Trigger.new);
            OpportunityTriggerHelper.createUniqueRecords(Trigger.new, Trigger.oldMap);   
        }
        if(Trigger.isUpdate){
            OpportunityTriggerHelper.checkAutomobileSize(Trigger.new);   
            OpportunityTriggerHelper.createUniqueRecords(Trigger.new, Trigger.oldMap);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OpportunityTriggerHelper.createAutomobileRecords(Trigger.new);
            //OpportunityTriggerHelper.sendMailToOwner(Trigger.new, Trigger.old);

        }
        if(Trigger.isUpdate){
            //OpportunityTriggerHelper.checkStageName(Trigger.newMap, Trigger.old);
            OpportunityTriggerHelper.createAutomobileRecords(Trigger.new, Trigger.oldMap);
            OpportunityTriggerHelper.deleteAutomobileRecords(Trigger.new, Trigger.oldMap); 
            //OpportunityTriggerHelper.sendMailToOwner(Trigger.new, Trigger.old);
        }
    }
}