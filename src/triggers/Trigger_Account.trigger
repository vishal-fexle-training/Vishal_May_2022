/*
  *  Purpose         :    Trigger to send mail and check prefix
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/19
  *  Revision Logs   :    V_1.0 - Created - 2022/07/19
*/
trigger Trigger_Account on Account (after insert, after update, before insert, before update){
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TriggerHelperClass.triggerInsertSendMail(Trigger.new);
            TriggerHelperClass.triggerInsertDisplayRecords(Trigger.new);
        }
        if(Trigger.isUpdate){
            TriggerHelperClass.triggerUpdateDisplayRecords(Trigger.old, Trigger.new);
        }
    }
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            TriggerHelperClass.triggerCheckAccountPrefix(Trigger.New);    
        }
    }
}