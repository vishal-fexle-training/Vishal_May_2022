/*
  *  Purpose         :    Helper class for Opportunity trigger
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/30
  *  Revision Logs   :    V_1.0 - Created - 2022/07/30
*/
public with sharing class OpportunityTriggerHelper{
    public static Map<Id, Sobject> mapSobject;
    public static Map<Id, Automobile_Presence_Sensor__c> mapAutomobilePresenceSensor;
    public static Map<Id, Automobile_Sensor__c> mapAutomobileSensor;
    public static Map<Id, Automobile_Tag__c> mapAutomobileTag;
    public static Map<Id, Automobile_TDU__c> mapAutomobileTDU;
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to fill static variables
      * Params        :    Void
      * Return        :    Void
    */
    public static void fillObjects(){
        mapSobject = new Map<Id, Sobject>();
    
        mapAutomobilePresenceSensor = new Map<Id, Automobile_Presence_Sensor__c>([Select Id, Name, Account__r.Name, Opportunity__c from Automobile_Presence_Sensor__c]);
        mapSobject.putAll(mapAutomobilePresenceSensor);
        mapAutomobileSensor = new Map<Id, Automobile_Sensor__c>([Select Id, Name, Account__r.Name, Opportunity__c from Automobile_Sensor__c]);
        mapSobject.putAll(mapAutomobileSensor);
        mapAutomobileTag = new Map<Id, Automobile_Tag__c>([Select Id, Name, Account__r.Name, Opportunity__c from Automobile_Tag__c]);
        mapSobject.putAll(mapAutomobileTag);
        mapAutomobileTDU= new Map<Id, Automobile_TDU__c>([Select Id, Name, Account__r.Name, Opportunity__c from Automobile_TDU__c]);
        mapSobject.putAll(mapAutomobileTDU);
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to check Automobile size
      * Params        :    List<Opportunity> listNew
      * Return        :    Void
    */
    public static void checkAutomobileSize(List<Opportunity> listNew){
        for(Opportunity recNew : listNew){
            List<String> listRecords = new List<String>();

            if(recNew.Automobile_Tag_Details_1__c != null){
                listRecords.addAll(recNew.Automobile_Tag_Details_1__c.split('\n'));
            }
            if(recNew.Automobile_Tag_Details_2__c != null){
                listRecords.addAll(recNew.Automobile_Tag_Details_2__c.split('\n'));
            }
            if(recNew.Automobile_Tag_Details_3__c != null){
                listRecords.addAll(recNew.Automobile_Tag_Details_3__c.split('\n'));
            }
            if(recNew.Return_To_HQ__c != null){
                listRecords.addAll(recNew.Return_To_HQ__c.split('\n'));
            }

            if(listRecords!=null){
                for(String record : listRecords){
                    if(record.length()>18){
                        recNew.addError('Automobile must be less than 18 characters!!!!!');
                    }
                }        
            }   
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to check unique records
      * Params        :    List<Opportunity> listNew, Map<Id, Opportunity> mapOld
      * Return        :    Void
    */
    public static void createUniqueRecords(List<Opportunity> listNew, Map<Id, Opportunity> mapOld){
        fillObjects();

        if(mapOld!=null){
            for(Opportunity recNew : listNew){
                Opportunity recOld = mapOld.get(recNew.Id);
                List<String> listOldAutomobile = new List<String>();
                if(recOld.Automobile_Tag_Details_1__c!=null){
                    listOldAutomobile.addAll(recOld.Automobile_Tag_Details_1__c.split('\n'));
                }
                if(recOld.Automobile_Tag_Details_2__c!=null){
                    listOldAutomobile.addAll(recOld.Automobile_Tag_Details_2__c.split('\n'));
                }
                if(recOld.Automobile_Tag_Details_3__c!=null){
                    listOldAutomobile.addAll(recOld.Automobile_Tag_Details_3__c.split('\n'));   
                }

                List<String> listNewAutomobile = new List<String>();
                if(recNew.Automobile_Tag_Details_1__c!=null){
                    listNewAutomobile.addAll(recNew.Automobile_Tag_Details_1__c.split('\n'));
                }
                if(recNew.Automobile_Tag_Details_2__c!=null){
                    listNewAutomobile.addAll(recNew.Automobile_Tag_Details_2__c.split('\n'));
                }
                if(recNew.Automobile_Tag_Details_3__c!=null){
                    listNewAutomobile.addAll(recNew.Automobile_Tag_Details_3__c.split('\n'));
                }
                
                if(listNewAutomobile!=listOldAutomobile){
                    for(String newAutomobile : listNewAutomobile){
                        if(!listOldAutomobile.contains(newAutomobile)){
                            for(Sobject sobjectFromMap : mapSobject.values()){
                                if(sobjectFromMap.get('Name')==newAutomobile){
                                    recNew.addError(newAutomobile+' Automobile record is already present!!!!');
                                }
                            }
                        }
                    }
                }
            }        
        }    
        else{
            for(Opportunity recNew : listNew){
                List<String> listNewAutomobile = new List<String>();
                if(recNew.Automobile_Tag_Details_1__c!=null){
                    listNewAutomobile.addAll(recNew.Automobile_Tag_Details_1__c.split('\n'));
                }
                if(recNew.Automobile_Tag_Details_2__c!=null){
                    listNewAutomobile.addAll(recNew.Automobile_Tag_Details_2__c.split('\n'));
                }
                if(recNew.Automobile_Tag_Details_3__c!=null){
                    listNewAutomobile.addAll(recNew.Automobile_Tag_Details_3__c.split('\n'));
                }

                for(Sobject recAutomobile : mapSobject.values()){
                    if(listNewAutomobile!=null){
                        if(listNewAutomobile.contains((String)recAutomobile.get('Name'))){
                            recNew.addError('Automobile Name '+recAutomobile.get('Name')+' is already present !!!!!!!!!');        
                        }
                    }
                }
            }
        }
    }
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to create Child records if opportunity is created
      * Params        :    List<Opportunity> listNew
      * Return        :    Void
    */
    public static void createAutomobileRecords(List<Opportunity> listNew){
        List<SObject> listRecordsToInsert = new List<SObject>();

        for(Opportunity recNew : listNew){
            List<String> listRecords = new List<String>();

            if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer')
            {
                if(recNew.Automobile_Tag_Details_1__c != null){
                    listRecords.addAll(recNew.Automobile_Tag_Details_1__c.split('\n'));
                }
                if(recNew.Automobile_Tag_Details_2__c != null){
                    listRecords.addAll(recNew.Automobile_Tag_Details_2__c.split('\n'));
                }
                if(recNew.Automobile_Tag_Details_3__c != null){
                    listRecords.addAll(recNew.Automobile_Tag_Details_3__c.split('\n'));
                }
            }
            else if(recNew.StageName=='Return to HQ')
            {
                if(recNew.Return_To_HQ__c != null){
                    listRecords.addAll(recNew.Return_To_HQ__c.split('\n'));
                }
            }
            
            if(listRecords != null){
                for(String record : listRecords){
                    if(record.startsWith('00:11:CE:00')){
                        Automobile_Sensor__c rec = new Automobile_Sensor__c();
                        rec.Name=record;
                        rec.Opportunity__c=recNew.Id;
                        if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer'){
                            rec.Account__c=recNew.AccountId;
                        }
                        else{
                            rec.Account__c=recNew.Shipment_Account__c;
                        }
                        listRecordsToInsert.add(rec);
                    }
                    else if(record.startsWith('00:11:CE:D')){
                        Automobile_Presence_Sensor__c rec = new Automobile_Presence_Sensor__c();
                        rec.Name=record;
                        rec.Opportunity__c=recNew.Id;
                        if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer'){
                            rec.Account__c=recNew.AccountId;
                        }
                        else{
                            rec.Account__c=recNew.Shipment_Account__c;
                        }
                        listRecordsToInsert.add(rec);
                    }
                    else if(record.startsWith('00:11:CE:E')){
                        Automobile_TDU__c rec = new Automobile_TDU__c();
                        rec.Name=record;
                        rec.Opportunity__c=recNew.Id;
                        if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer'){
                            rec.Account__c=recNew.AccountId;
                        }
                        else{
                            rec.Account__c=recNew.Shipment_Account__c;
                        }
                        listRecordsToInsert.add(rec);
                    }
                    else if(record.substring(3,4)=='-'){
                        Automobile_Tag__c rec = new Automobile_Tag__c();
                        rec.Name=record;
                        rec.Opportunity__c=recNew.Id;
                        if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer'){
                            rec.Account__c=recNew.AccountId;
                        }
                        else{
                            rec.Account__c=recNew.Shipment_Account__c;
                        }
                        listRecordsToInsert.add(rec);
                    }
                }
            }
        }
        insert listRecordsToInsert;    
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to create Child records if opportunity updated
      * Params        :    List<Opportunity> listNew, Map<Id, Opportunity> mapOld
      * Return        :    Void
    */
    public static void createAutomobileRecords(List<Opportunity> listNew, Map<Id, Opportunity> mapOld){
        List<SObject> listRecordsToInsert = new List<SObject>();

        for(Opportunity recNew : listNew){
            Opportunity recOld = mapOld.get(recNew.Id);

            List<String> listOldAutomobile = new List<String>();
            if(recOld.Automobile_Tag_Details_1__c!=null){
                listOldAutomobile.addAll(recOld.Automobile_Tag_Details_1__c.split('\n'));
            }
            if(recOld.Automobile_Tag_Details_2__c!=null){
                listOldAutomobile.addAll(recOld.Automobile_Tag_Details_2__c.split('\n'));
            }
            if(recOld.Automobile_Tag_Details_3__c!=null){
                listOldAutomobile.addAll(recOld.Automobile_Tag_Details_3__c.split('\n'));   
            }
            if(recNew.Return_To_HQ__c!=null){
                listOldAutomobile.addAll(recNew.Return_To_HQ__c.split('\n'));
            }

            List<String> listNewAutomobile = new List<String>();
            if(recNew.Automobile_Tag_Details_1__c!=null){
                listNewAutomobile.addAll(recNew.Automobile_Tag_Details_1__c.split('\n'));
            }
            if(recNew.Automobile_Tag_Details_2__c!=null){
                listNewAutomobile.addAll(recNew.Automobile_Tag_Details_2__c.split('\n'));
            }
            if(recNew.Automobile_Tag_Details_3__c!=null){
                listNewAutomobile.addAll(recNew.Automobile_Tag_Details_3__c.split('\n'));
            }
            if(recNew.Return_To_HQ__c!=null){
                listNewAutomobile.addAll(recNew.Return_To_HQ__c.split('\n'));
            }
            
            if(listNewAutomobile!=listOldAutomobile){
                for(String newAutomobile : listNewAutomobile){
                    if(!listOldAutomobile.contains(newAutomobile)){
                        if(newAutomobile.startsWith('00:11:CE:00')){
                            Automobile_Sensor__c rec = new Automobile_Sensor__c();
                            rec.Name=newAutomobile;
                            rec.Opportunity__c=recNew.Id;
                            if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer'){
                                rec.Account__c=recNew.AccountId;
                            }
                            else{
                                rec.Account__c=recNew.Shipment_Account__c;
                            }
                            listRecordsToInsert.add(rec);
                        }
                        else if(newAutomobile.startsWith('00:11:CE:D')){
                            Automobile_Presence_Sensor__c rec = new Automobile_Presence_Sensor__c();
                            rec.Name=newAutomobile;
                            rec.Opportunity__c=recNew.Id;
                            if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer'){
                                rec.Account__c=recNew.AccountId;
                            }
                            else{
                                rec.Account__c=recNew.Shipment_Account__c;
                            }
                            listRecordsToInsert.add(rec);
                        }
                        else if(newAutomobile.startsWith('00:11:CE:E')){
                            Automobile_TDU__c rec = new Automobile_TDU__c();
                            rec.Name=newAutomobile;
                            rec.Opportunity__c=recNew.Id;
                            if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer'){
                                rec.Account__c=recNew.AccountId;
                            }
                            else{
                                rec.Account__c=recNew.Shipment_Account__c;
                            }
                            listRecordsToInsert.add(rec);
                        }
                        else if(newAutomobile.substring(2,3)=='-'){
                            Automobile_Tag__c rec = new Automobile_Tag__c();
                            rec.Name=newAutomobile;
                            rec.Opportunity__c=recNew.Id;
                            if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer'){
                                rec.Account__c=recNew.AccountId;
                            }
                            else{
                                rec.Account__c=recNew.Shipment_Account__c;
                            }
                            listRecordsToInsert.add(rec);
                        }
                    }
                }
            }
            if(listRecordsToInsert!=null){
                insert listRecordsToInsert;
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called if Opportunity stage is updated
      * Params        :    Map<Id, Opportunity> mapNew, List<Opportunity> listOld
      * Return        :    Void
    */
    public static void checkStageName(Map<Id, Opportunity> mapNew, List<Opportunity> listOld){
        fillObjects();

        for(Opportunity recOld : listOld){
            Opportunity recNew = mapNew.get(recOld.Id);

            if(recOld.StageName!=recNew.StageName){
                if((recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer') && (recOld.StageName=='Return to HQ')){
                    List<String> listTagDetails = new List<String>();
                    listTagDetails.addAll(recNew.Automobile_Tag_Details_1__c.split('\n'));
                    listTagDetails.addAll(recNew.Automobile_Tag_Details_2__c.split('\n'));
                    listTagDetails.addAll(recNew.Automobile_Tag_Details_3__c.split('\n'));    

                    for(Sobject recAutomobile : mapSobject.values()){
                        if(recAutomobile.get('Opportunity__c')==recNew.Id && listTagDetails.contains((String)recAutomobile.get('Name'))){
                            recAutomobile.put('Account__c', recNew.AccountId);
                        }
                    }
                }
                else if(recNew.StageName=='Return to HQ'){
                    List<String> listReturnToHQ = recNew.Return_To_HQ__c.split('\n');

                    for(Sobject recAutomobile : mapSobject.values()){
                        if(recAutomobile.get('Opportunity__c') == recNew.Id && listReturnToHQ.contains((String)recAutomobile.get('Name'))){
                            recAutomobile.put('Account__c', recNew.Shipment_Account__c);
                        }
                    }
                }
            }
        }
        update mapSobject.values();    
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to delete Child records if opportunity updated
      * Params        :    List<Opportunity> listNew, Map<Id, Opportunity> mapOld
      * Return        :    Void
    */
    public static void deleteAutomobileRecords(List<Opportunity> listNew, Map<Id, Opportunity> mapOld){
        fillObjects();

        List<Sobject> listRecordsToDelete = new List<Sobject>();

        for(Opportunity recNew : listNew){
            Opportunity recOld = mapOld.get(recNew.Id);
            
            List<String> listOldAutomobile = new List<String>();
            if(recOld.Automobile_Tag_Details_1__c!=null){
                listOldAutomobile.addAll(recOld.Automobile_Tag_Details_1__c.split('\n'));
            }
            if(recOld.Automobile_Tag_Details_2__c!=null){
                listOldAutomobile.addAll(recOld.Automobile_Tag_Details_2__c.split('\n'));
            }
            if(recOld.Automobile_Tag_Details_3__c!=null){
                listOldAutomobile.addAll(recOld.Automobile_Tag_Details_3__c.split('\n'));   
            }
            if(recOld.Return_To_HQ__c!=null){
                listOldAutomobile.addAll(recOld.Return_To_HQ__c.split('\n'));
            }

            List<String> listNewAutomobile = new List<String>();
            if(recNew.Automobile_Tag_Details_1__c!=null){
                listNewAutomobile.addAll(recNew.Automobile_Tag_Details_1__c.split('\n'));
            }
            if(recNew.Automobile_Tag_Details_2__c!=null){
                listNewAutomobile.addAll(recNew.Automobile_Tag_Details_2__c.split('\n'));
            }
            if(recNew.Automobile_Tag_Details_3__c!=null){
                listNewAutomobile.addAll(recNew.Automobile_Tag_Details_3__c.split('\n'));
            }
            if(recNew.Return_To_HQ__c!=null){
                listNewAutomobile.addAll(recNew.Return_To_HQ__c.split('\n'));
            }

            if(listNewAutomobile!=listOldAutomobile){
                for(String oldAutomobile : listOldAutomobile){
                    if(!listNewAutomobile.contains(oldAutomobile)){
                        for(Sobject sobjectFromMap : mapSobject.values()){
                            if(sobjectFromMap.get('Name')==oldAutomobile){
                                listRecordsToDelete.add(sobjectFromMap);
                            }
                        }
                    }
                }
            }
        }
        if(listRecordsToDelete!=null){
            delete listRecordsToDelete;
        }
    }

    public static void sendMailToOwner(List<Opportunity> listNew, List<Opportunity> listOld){
        if(listOld==null){
            for(Opportunity recNew : listNew){
                if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer' || recNew.StageName=='Return to HQ'){
                    generateMailFormat(recNew);
                }
            }
        }
        else{
            for(Opportunity recNew : listNew){
                for(Opportunity recOld : listOld){
                    if(recOld.Id==recNew.Id && recOld.StageName!=recNew.StageName){
                        if(recNew.StageName=='Shipped to Customer' || recNew.StageName=='Return to Customer' || recNew.StageName=='Return to HQ'){
                            generateMailFormat(recNew);
                        }    
                    }
                }
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to send mail to Opportunity owner
      * Params        :    List<Opportunity> listNew
      * Return        :    Void
    */  
    public static void generateMailFormat(Opportunity opportunityRecord){
        fillObjects();

        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();

        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        //mail.setToAddresses(new List<String>{opportunityRecord.Owner.Email});
        mail.setToAddresses(new List<String>{'vishal.tourani@fexle.com'});
        //System.debug(opportunityRecord.Owner.Email);
        String subject = opportunityRecord.Name+' '+System.today();
        mail.setSubject(subject);
        mail.setSenderDisplayName('Vishal');
        
        String mailBody='Sensor shipment process is completed. Please refer below mentioned details to get all the success and failure details.<br/><br/>Successful:<br/><table style="width:100%" border="1">';            
        String tableRow='<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';
    
        for(Automobile_Sensor__c recAutomobile : mapAutomobileSensor.values()){
            if(recAutomobile.Opportunity__c  == opportunityRecord.Id){
                tableRow = tableRow + '<tr><td>Sensor</td><td>'+recAutomobile.Name+'</td><td>Sensor inserted under installation account : '+recAutomobile.Account__r.Name+'</td></tr>';
            }        
        }
        for(Automobile_Presence_Sensor__c recAutomobile : mapAutomobilePresenceSensor.values()){
            if(recAutomobile.Opportunity__c  == opportunityRecord.Id){
                tableRow = tableRow + '<tr><td>Presence Sensor</td><td>'+recAutomobile.Name+'</td><td>Sensor inserted under installation account : '+recAutomobile.Account__r.Name+'</td></tr>';
            }
        }
        for(Automobile_TDU__c recAutomobile : mapAutomobileTDU.values()){
            if(recAutomobile.Opportunity__c  == opportunityRecord.Id){
                tableRow = tableRow + '<tr><td>TUD</td><td>'+recAutomobile.Name+'</td><td>Sensor inserted under installation account : '+recAutomobile.Account__r.Name+'</td></tr>';
            }        
        }
        for(Automobile_Tag__c recAutomobile : mapAutomobileTag.values()){
            if(recAutomobile.Opportunity__c  == opportunityRecord.Id){
                tableRow = tableRow + '<tr><td>Tag</td><td>'+recAutomobile.Name+'</td><td>Sensor inserted under installation account : '+recAutomobile.Account__r.Name+'</td></tr>';
            } 
        }
        mailBody = mailBody+tableRow+'</table>'+'<br/><br/>';

        List<String> listUnsuccessfulSensor = new List<String>();
        if(opportunityRecord.Automobile_Tag_Details_1__c!=null){
            listUnsuccessfulSensor.addAll(opportunityRecord.Automobile_Tag_Details_1__c.split('\n'));
        }
        if(opportunityRecord.Automobile_Tag_Details_2__c!=null){
            listUnsuccessfulSensor.addAll(opportunityRecord.Automobile_Tag_Details_2__c.split('\n'));
        }
        if(opportunityRecord.Automobile_Tag_Details_3__c!=null){
            listUnsuccessfulSensor.addAll(opportunityRecord.Automobile_Tag_Details_3__c.split('\n'));   
        }
        if(opportunityRecord.Return_To_HQ__c!=null){
            listUnsuccessfulSensor.addAll(opportunityRecord.Return_To_HQ__c.split('\n'));
        }
        for(Sobject sobjectFromMap : mapSobject.values()){
            if(listUnsuccessfulSensor.contains((String)sobjectFromMap.get('Name'))){
                listUnsuccessfulSensor.remove(listUnsuccessfulSensor.indexOf((String)sobjectFromMap.get('Name')));    
            }
        }

        if(listUnsuccessfulSensor!=null){
            mailBody = mailBody+'Unsuccessful : <br/><table style="width:100%" border="1">';
            tableRow = '<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';

            for(String unsuccessfulSensor : listUnsuccessfulSensor){
                tableRow =  tableRow + '<tr><td>Sensor</td><td>'+unsuccessfulSensor+'</td><td>Sensor not inserted .</td></tr>';
            }

            mailBody = mailBody+tableRow+'</table>';
        }
        mail.setHtmlBody(mailBody);
        listMail.add(mail);

        Messaging.sendEmail(listMail);
    }
}