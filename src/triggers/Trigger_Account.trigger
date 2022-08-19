/*
  *  Purpose         :    Trigger to send mail and check prefix
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/19
  *  Revision Logs   :    V_1.0 - Created - 2022/07/19
*/
trigger Trigger_Account on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete){
    //System.debug('Account : '+Trigger.operationType);
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTriggerHelper.triggerCheckAccountPrefix(Trigger.new);  
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTriggerHelper.triggerInsertSendMail(Trigger.new);
            AccountTriggerHelper.triggerInsertDisplayRecords(Trigger.new);
            AccountTriggerHelper.createDuplicateAccount(Trigger.new);
        }
        if(Trigger.isUpdate){
            AccountTriggerHelper.triggerUpdateDisplayRecords(Trigger.old, Trigger.new);
            if(Constants.restrictAccountChange){
                AccountTriggerHelper.updatePropertyAndContactStatus(Trigger.new, Trigger.oldMap);
            }
        }
    }
}