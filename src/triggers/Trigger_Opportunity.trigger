trigger Trigger_Opportunity on Opportunity (before insert, after insert, before update, after update, after delete, after undelete){
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OpportunityTriggerHelper.checkAutomobileSize(Trigger.new);  
        }
        if(Trigger.isUpdate){
            OpportunityTriggerHelper.checkAutomobileSize(Trigger.new);   
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OpportunityTriggerHelper.createAutomobileRecords(Trigger.new, Trigger.oldMap);
            //OpportunityTriggerHelper.checkStageName(Trigger.new, Trigger.oldMap);
            OpportunityTriggerHelper.sendMail(Trigger.new, Trigger.oldMap);

        }
        if(Trigger.isUpdate){
            OpportunityTriggerHelper.createAutomobileRecords(Trigger.new, Trigger.oldMap); 
            //OpportunityTriggerHelper.checkStageName(Trigger.new, Trigger.oldMap);
            OpportunityTriggerHelper.sendMail(Trigger.new, Trigger.oldMap);
        }
    }
}