/*
  *  Purpose         :    Trigger to check methods
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/20
  *  Revision Logs   :    V_1.0 - Created - 2022/07/20
*/
trigger Trigger_Opportunity on Opportunity (before insert, before update, before delete, after insert, after update, after delete){
    System.debug('Check is before : '+Trigger.isBefore);                    //true                      //false
    System.debug('Check is after : '+Trigger.isAfter);                      //false                     //true
    System.debug('Check is insert : '+Trigger.isInsert);                    //true                      //true
    System.debug('Check is update : '+Trigger.isUpdate);                    //false                     //false
    System.debug('Check is delete : '+Trigger.isDelete);                    //false                     //false
    System.debug('Check is undelete : '+Trigger.isUndelete);                //flase                     //false
    System.debug('Check Operation type : '+Trigger.operationType);          //BEFORE_INSERT             //AFTER_INSERT
    System.debug('Check size of records : '+Trigger.size);                  //1                         //1
    System.debug('Checking new records : '+Trigger.new);                    //Id=0065i000005m6hqAAA     //Id=0065i000005m6hqAAA 
    System.debug('Checking old records : '+Trigger.old);                    //null                      //null
}