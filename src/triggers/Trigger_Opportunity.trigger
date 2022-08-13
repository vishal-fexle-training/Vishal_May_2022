/*
  *  Purpose         :    Trigger to create and update automobile records
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/30
  *  Revision Logs   :    V_1.0 - Created - 2022/07/30
*/
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
            OpportunityTriggerHelper.checkStageName(Trigger.new, Trigger.oldMap);
            OpportunityTriggerHelper.sendMail(Trigger.new, Trigger.oldMap);

        }
        if(Trigger.isUpdate){
            OpportunityTriggerHelper.createAutomobileRecords(Trigger.new, Trigger.oldMap); 
            OpportunityTriggerHelper.checkStageName(Trigger.new, Trigger.oldMap);
            OpportunityTriggerHelper.sendMail(Trigger.new, Trigger.oldMap);
        }
    }
}
