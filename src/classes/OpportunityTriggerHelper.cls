/*
  *  Purpose         :    Helper class for Opportunity trigger
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/30
  *  Revision Logs   :    V_1.0 - Created - 2022/07/30
*/
public with sharing class OpportunityTriggerHelper{
    
    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to check Automobile size
      * Params        :    List<Opportunity> listNew
      * Return        :    Void
    */
    public static void checkAutomobileSize(List<Opportunity> listNew){
        Map<String, Opportunity> mapAutomobileWithOpportunity = new Map<String, Opportunity>();

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

            if(!listRecords.isEmpty()){
                for(String record : listRecords){
                    if(record.deleteWhitespace().length() > Constants.AUTOMOBILE_SIZE){
                        mapAutomobileWithOpportunity.put(record.deleteWhitespace(), recNew);
                    }    
                }
            }
        }

        if(!mapAutomobileWithOpportunity.isEmpty()){
            for(String automobile : mapAutomobileWithOpportunity.keySet()){
                Opportunity recOpp = mapAutomobileWithOpportunity.get(automobile);

                if(recOpp.Automobile_Tag_Details_1__c != null && recOpp.Automobile_Tag_Details_1__c.contains(automobile)){
                    recOpp.Automobile_Tag_Details_1__c.replace(automobile, automobile.substring(0, Constants.AUTOMOBILE_SIZE));   
                }
                if(recOpp.Automobile_Tag_Details_2__c != null && recOpp.Automobile_Tag_Details_2__c.contains(automobile)){
                    recOpp.Automobile_Tag_Details_2__c.replace(automobile, automobile.substring(0, Constants.AUTOMOBILE_SIZE));   
                }
                if(recOpp.Automobile_Tag_Details_3__c != null && recOpp.Automobile_Tag_Details_3__c.contains(automobile)){
                    recOpp.Automobile_Tag_Details_3__c.replace(automobile, automobile.substring(0, Constants.AUTOMOBILE_SIZE));   
                }
                if(recOpp.Return_To_HQ__c != null && recOpp.Return_To_HQ__c.contains(automobile)){
                    recOpp.Return_To_HQ__c.replace(automobile, automobile.substring(0, Constants.AUTOMOBILE_SIZE));   
                }
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to split and put automobile records in map
      * Params        :    Opportunity recOpp,  Map<String, Opportunity> mapAutomobileWithOpportunity
      * Return        :    Void
    */
    public static void splitAndAddAutomobiles(Opportunity recOpp,  Map<String, Opportunity> mapAutomobileWithOpportunity){
        Set<String> setNewAutomobiles = new Set<String>();

        if(recOpp.Automobile_Tag_Details_1__c != null){
            setNewAutomobiles.addAll(recOpp.Automobile_Tag_Details_1__c.split('\n'));
        }
        if(recOpp.Automobile_Tag_Details_2__c != null){
            setNewAutomobiles.addAll(recOpp.Automobile_Tag_Details_2__c.split('\n'));
        }
        if(recOpp.Automobile_Tag_Details_3__c != null){
            setNewAutomobiles.addAll(recOpp.Automobile_Tag_Details_3__c.split('\n'));
        }
        if(recOpp.Return_To_HQ__c != null){
            setNewAutomobiles.addAll(recOpp.Return_To_HQ__c.split('\n'));
        }

        if(!setNewAutomobiles.isEmpty()){
            for(String automobile : setNewAutomobiles){
                automobile = automobile.deleteWhitespace();
                mapAutomobileWithOpportunity.put(automobile, recOpp);
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to create and delete Automobile records
      * Params        :    List<Opportunity> listNew, Map<Id, Opportunity> mapOld
      * Return        :    Void
    */
    public static void createAutomobileRecords(List<Opportunity> listNew, Map<Id, Opportunity> mapOld){
        List<Opportunity> listNewOpportunities = new List<Opportunity>();
        Map<String, Opportunity> mapAutomobileWithOpportunity = new Map<String, Opportunity>();

        for(Opportunity newOpportunity : listNew){
            if( mapOld != null && (newOpportunity.Automobile_Tag_Details_1__c != mapOld.get(newOpportunity.Id).Automobile_Tag_Details_1__c ||
                                   newOpportunity.Automobile_Tag_Details_2__c != mapOld.get(newOpportunity.Id).Automobile_Tag_Details_2__c ||
                                   newOpportunity.Automobile_Tag_Details_3__c != mapOld.get(newOpportunity.Id).Automobile_Tag_Details_3__c ||
                                   newOpportunity.Return_To_HQ__c != mapOld.get(newOpportunity.Id).Return_To_HQ__c) ){

                if(newOpportunity.StageName == Constants.OPP_STAGE_SHIPPED_TO_CUSTOMER || newOpportunity.StageName == Constants.OPP_STAGE_RETURN_TO_CUSTOMER || newOpportunity.StageName == Constants.OPP_STAGE_RETURN_TO_HQ){
                    splitAndAddAutomobiles(newOpportunity, mapAutomobileWithOpportunity);
                } 
            }
            else if(newOpportunity.StageName == Constants.OPP_STAGE_SHIPPED_TO_CUSTOMER || newOpportunity.StageName == Constants.OPP_STAGE_RETURN_TO_CUSTOMER || newOpportunity.StageName == Constants.OPP_STAGE_RETURN_TO_HQ){
                splitAndAddAutomobiles(newOpportunity, mapAutomobileWithOpportunity);
            }
        }

        
            
        if(!mapAutomobileWithOpportunity.isEmpty()){
            List<Sobject> listAutomobile = new List<Sobject>();
            listAutomobile.addAll([Select Name from Automobile_Presence_Sensor__c where Name In :mapAutomobileWithOpportunity.keySet()]);
            listAutomobile.addAll([Select Name from Automobile_Sensor__c where Name In :mapAutomobileWithOpportunity.keySet()]);
            listAutomobile.addAll([Select Name from Automobile_Tag__c where Name In :mapAutomobileWithOpportunity.keySet()]);
            listAutomobile.addAll([Select Name from Automobile_TDU__c where Name In :mapAutomobileWithOpportunity.keySet()]);

            Map<String, Sobject> mapAutomobile = new Map<String, Sobject>();
            for(Sobject automobile : listAutomobile){
                mapAutomobile.put((String)automobile.get('Name'), automobile);
            }

            for(String newAutomobile : mapAutomobileWithOpportunity.keySet()){
                if(!mapAutomobile.containsKey(newAutomobile)){
                    if(newAutomobile.startsWith(Constants.AUTOMOBILE_SENSOR)){
                        Automobile_Sensor__c rec = new Automobile_Sensor__c();
                        rec.Name = newAutomobile;
                        rec.Opportunity__c = mapAutomobileWithOpportunity.get(newAutomobile).Id;
                        rec.Account__c = mapAutomobileWithOpportunity.get(newAutomobile).AccountId;
                        
                        mapAutomobile.put(newAutomobile, rec);
                    }
                    else if(newAutomobile.startsWith(Constants.AUTOMOBILE_PRESENCE_SENSOR)){
                        Automobile_Presence_Sensor__c rec = new Automobile_Presence_Sensor__c();
                        rec.Name = newAutomobile;
                        rec.Opportunity__c = mapAutomobileWithOpportunity.get(newAutomobile).Id;
                        rec.Account__c = mapAutomobileWithOpportunity.get(newAutomobile).AccountId;
                        
                        mapAutomobile.put(newAutomobile, rec);
                    }
                    else if(newAutomobile.startsWith(Constants.AUTOMOBILE_TDU)){
                        Automobile_TDU__c rec = new Automobile_TDU__c();
                        rec.Name = newAutomobile;
                        rec.Opportunity__c = mapAutomobileWithOpportunity.get(newAutomobile).Id;
                        rec.Account__c = mapAutomobileWithOpportunity.get(newAutomobile).AccountId;
                    
                        mapAutomobile.put(newAutomobile, rec);
                    }
                    else if(newAutomobile.length() > 7 && newAutomobile.substring(0,3).isNumeric() && newAutomobile.substring(3,4)=='-' && newAutomobile.substring(7,8)=='-'){
                        Automobile_Tag__c rec = new Automobile_Tag__c();
                        rec.Name = newAutomobile;
                        rec.Opportunity__c = mapAutomobileWithOpportunity.get(newAutomobile).Id;
                        rec.Account__c = mapAutomobileWithOpportunity.get(newAutomobile).AccountId;
                        
                        mapAutomobile.put(newAutomobile, rec);
                    }
                }                        
            }
            upsert mapAutomobile.values();
        }

        if(mapOld!=null){
            Set<String> setOldAutomobiles = new Set<String>();
            Set<String> setNewAutomobiles = new Set<String>();

            for(Opportunity recNew : listNew){
                Opportunity recOld = mapOld.get(recNew.Id);

                //Adding old Automobile records from Opportunity
                if(recOld.Automobile_Tag_Details_1__c != null){
                    setOldAutomobiles.addAll(recOld.Automobile_Tag_Details_1__c.split('\n'));
                }
                if(recOld.Automobile_Tag_Details_2__c != null){
                    setOldAutomobiles.addAll(recOld.Automobile_Tag_Details_2__c.split('\n'));
                }
                if(recOld.Automobile_Tag_Details_3__c != null){
                    setOldAutomobiles.addAll(recOld.Automobile_Tag_Details_3__c.split('\n'));
                }
                if(recOld.Return_To_HQ__c != null){
                    setOldAutomobiles.addAll(recOld.Return_To_HQ__c.split('\n'));
                }
                if(!setOldAutomobiles.isEmpty()){
                    for(String automobile : setOldAutomobiles){
                        String automobileRemovedWhiteSpaces = automobile.deleteWhitespace();
                        setOldAutomobiles.remove(automobile);
                        setOldAutomobiles.add(automobileRemovedWhiteSpaces);
                    }    
                }

                //Adding new Automobile records from Opportunity
                if(recNew.Automobile_Tag_Details_1__c != null){
                    setNewAutomobiles.addAll(recNew.Automobile_Tag_Details_1__c.split('\n'));
                }
                if(recNew.Automobile_Tag_Details_2__c != null){
                    setNewAutomobiles.addAll(recNew.Automobile_Tag_Details_2__c.split('\n'));
                }
                if(recNew.Automobile_Tag_Details_3__c != null){
                    setNewAutomobiles.addAll(recNew.Automobile_Tag_Details_3__c.split('\n'));
                }
                if(recNew.Return_To_HQ__c != null){
                    setNewAutomobiles.addAll(recNew.Return_To_HQ__c.split('\n'));
                }
                if(!setNewAutomobiles.isEmpty()){
                    for(String automobile : setNewAutomobiles){
                        String automobileRemovedWhiteSpaces =  automobile.deleteWhitespace();
                        setNewAutomobiles.remove(automobile);
                        setNewAutomobiles.add(automobileRemovedWhiteSpaces);
                    }    
                }
            }
            setOldAutomobiles.removeAll(setNewAutomobiles);
            
            if(!setOldAutomobiles.isEmpty()){
                List<Sobject> listAutomobile = new List<Sobject>();
                listAutomobile.addAll([Select Name from Automobile_Presence_Sensor__c where Name In :setOldAutomobiles]);
                listAutomobile.addAll([Select Name from Automobile_Sensor__c where Name In :setOldAutomobiles]);
                listAutomobile.addAll([Select Name from Automobile_Tag__c where Name In :setOldAutomobiles]);
                listAutomobile.addAll([Select Name from Automobile_TDU__c where Name In :setOldAutomobiles]);

                delete listAutomobile;
            }
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to be called if Opportunity stage is updated
      * Params        :    Map<Id, Opportunity> mapNew, List<Opportunity> listOld
      * Return        :    Void
    */
    public static void checkStageName(List<Opportunity> listNew, Map<Id, Opportunity> mapOld){
        List<Opportunity> listNewOpportunities = new List<Opportunity>();
        Map<String, Id> mapAutomobileWithAccount = new Map<String, Id>();

        for(Opportunity opportunityToAdd : listNew){
            if(mapOld != null){
                if(opportunityToAdd.StageName != mapOld.get(opportunityToAdd.Id).StageName){
                    if(( opportunityToAdd.StageName == Constants.OPP_STAGE_RETURN_TO_HQ ) && 
                       ( mapOld.get(opportunityToAdd.Id).StageName != Constants.OPP_STAGE_RETURN_TO_HQ )){
                        listNewOpportunities.add(opportunityToAdd);
                    }
                    else if( (opportunityToAdd.StageName == Constants.OPP_STAGE_SHIPPED_TO_CUSTOMER || 
                              opportunityToAdd.StageName == Constants.OPP_STAGE_RETURN_TO_CUSTOMER) 
                              && (mapOld.get(opportunityToAdd.Id).StageName == Constants.OPP_STAGE_RETURN_TO_HQ) ){
                        listNewOpportunities.add(opportunityToAdd);         
                    }
                }
            }
            else{
                if(opportunityToAdd.StageName==Constants.OPP_STAGE_RETURN_TO_HQ){
                    listNewOpportunities.add(opportunityToAdd);
                }    
            }
        }

        if(!listNewOpportunities.isEmpty()){
            for(Opportunity newOpportunity : listNewOpportunities){
                Set<String> setAutomobile = new Set<String>();

                if(newOpportunity.StageName == Constants.OPP_STAGE_RETURN_TO_HQ){
                    if(newOpportunity.Return_To_HQ__c != null){
                        setAutomobile.addAll(newOpportunity.Return_To_HQ__c.split('\n'));
                
                        for(String automobile : setAutomobile){
                            mapAutomobileWithAccount.put(automobile.deleteWhitespace(), newOpportunity.Shipment_Account__c);
                        }
                    }
                }
                else{
                    if(newOpportunity.Automobile_Tag_Details_1__c != null){
                        setAutomobile.addAll(newOpportunity.Automobile_Tag_Details_1__c.split('\n'));
                    }
                    if(newOpportunity.Automobile_Tag_Details_2__c != null){
                        setAutomobile.addAll(newOpportunity.Automobile_Tag_Details_2__c.split('\n'));
                    }
                    if(newOpportunity.Automobile_Tag_Details_2__c != null){
                        setAutomobile.addAll(newOpportunity.Automobile_Tag_Details_3__c.split('\n'));
                    }

                    for(String automobile : setAutomobile){
                        mapAutomobileWithAccount.put(automobile.deleteWhitespace(), newOpportunity.AccountId);    
                    }
                }
            }
        }

        if(!mapAutomobileWithAccount.isEmpty()){
            List<Sobject> listAutomobile = new List<Sobject>();
            listAutomobile.addAll([Select Name from Automobile_Presence_Sensor__c where Name In :mapAutomobileWithAccount.keySet()]);
            listAutomobile.addAll([Select Name from Automobile_Sensor__c where Name In :mapAutomobileWithAccount.keySet()]);
            listAutomobile.addAll([Select Name from Automobile_Tag__c where Name In :mapAutomobileWithAccount.keySet()]);
            listAutomobile.addAll([Select Name from Automobile_TDU__c where Name In :mapAutomobileWithAccount.keySet()]);
            
            for(Sobject automobile : listAutomobile){
                Id idAccount = mapAutomobileWithAccount.get((String)automobile.get('Name'));
                automobile.put('Account__c', idAccount);
            }
            update listAutomobile;
        }
    
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to send mail to Opportunity owner
      * Params        :    List<Opportunity> listNew
      * Return        :    Void
    */ 
    public static void sendMail(List<Opportunity> listNew, Map<Id, Opportunity> mapOld){
        List<Messaging.SingleEmailMessage> listMailsToSend =  new List<Messaging.SingleEmailMessage>();
        Map<Id, Opportunity> mapOpportunityToSendMail = new Map<Id, Opportunity>();
        List<Id> listUserId =  new List<Id>();
        List<Sobject> listAllAutomobile = new List<Sobject>();
        Map<Id, User> mapIdWithUser;

        try{
            if(mapOld == null){
                for(Opportunity recNew : listNew){
                    if(recNew.StageName == Constants.OPP_STAGE_SHIPPED_TO_CUSTOMER || recNew.StageName == Constants.OPP_STAGE_RETURN_TO_CUSTOMER || recNew.StageName == Constants.OPP_STAGE_RETURN_TO_HQ){
                        mapOpportunityToSendMail.put(recNew.Id, recNew);
                        listUserId.add(recNew.OwnerId);    
                    }
                }
            }
            else{
                for(Opportunity recNew : listNew){
                    Opportunity recOld = mapOld.get(recNew.Id);

                    if(recOld.StageName != recNew.StageName){
                        if(recNew.StageName == Constants.OPP_STAGE_SHIPPED_TO_CUSTOMER || recNew.StageName == Constants.OPP_STAGE_RETURN_TO_CUSTOMER || recNew.StageName == Constants.OPP_STAGE_RETURN_TO_HQ){
                            mapOpportunityToSendMail.put(recNew.Id, recNew);
                            listUserId.add(recNew.OwnerId);    
                        }    
                    }
                }
            }

            if(!listUserId.isEmpty()){
                mapIdWithUser = new Map<Id, User>([Select Id, Name, Email from User where Id In :listUserId]);
            }

            if(!mapOpportunityToSendMail.isEmpty()){
                List<Automobile_Presence_Sensor__c> listAutomobilePresenceSensor= [Select Id, Name, Opportunity__c, Account__c, Account__r.Name from Automobile_Presence_Sensor__c 
                                                                                   where Opportunity__c In :mapOpportunityToSendMail.keySet()];
                List<Automobile_Sensor__c> listAutomobileSensor= [Select Id, Name, Opportunity__c, Account__c, Account__r.Name from Automobile_Sensor__c 
                                                                  where Opportunity__c In :mapOpportunityToSendMail.keySet()];
                List<Automobile_Tag__c> listAutomobileTag = [Select Id, Name, Opportunity__c, Account__c, Account__r.Name from Automobile_Tag__c 
                                                             where Opportunity__c In :mapOpportunityToSendMail.keySet()];
                List<Automobile_TDU__c> listAutomobileTDU = [Select Id, Name, Opportunity__c, Account__c, Account__r.Name from Automobile_TDU__c 
                                                             where Opportunity__c In :mapOpportunityToSendMail.keySet()];

                for(Opportunity opportunityToSendMail : mapOpportunityToSendMail.values()){
                    List<String> listAutomobileInOpp = new List<String>();
                
                    if(opportunityToSendMail.Automobile_Tag_Details_1__c !=  null){
                        listAutomobileInOpp.addAll(opportunityToSendMail.Automobile_Tag_Details_1__c.split('\n'));
                    }
                    if(opportunityToSendMail.Automobile_Tag_Details_2__c !=  null){
                        listAutomobileInOpp.addAll(opportunityToSendMail.Automobile_Tag_Details_2__c.split('\n'));
                    }
                    if(opportunityToSendMail.Automobile_Tag_Details_3__c !=  null){
                        listAutomobileInOpp.addAll(opportunityToSendMail.Automobile_Tag_Details_3__c.split('\n'));
                    }
                    if(opportunityToSendMail.Return_To_HQ__c !=  null){
                        listAutomobileInOpp.addAll(opportunityToSendMail.Return_To_HQ__c.split('\n'));
                    }

                    if(!listAutomobileInOpp.isEmpty()){
                        for(String automobile : listAutomobileInOpp){
                            listAutomobileInOpp.set( listAutomobileInOpp.indexOf(automobile), automobile.deleteWhitespace());
                        }  
                        listMailsToSend.add(generateMailFormat(opportunityToSendMail, listAutomobileInOpp, mapOpportunityToSendMail, mapIdWithUser, 
                                                               listAutomobilePresenceSensor, listAutomobileSensor, listAutomobileTag, 
                                                               listAutomobileTDU));
                    }
                }
                Messaging.sendEmail(listMailsToSend);
            }
        }
        catch(Exception e){
            System.debug('Exception occured : '+e.getMessage());
        }
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    Method to fill mail details
      * Params        :    List<Opportunity> listNew
      * Return        :    Void
    */
    public static Messaging.SingleEmailMessage generateMailFormat(Opportunity opportunityToSendMail, List<String> listAutomobileInOpp, 
                                                                  Map<Id, Opportunity> mapOpportunityToSendMail, Map<Id, User> mapIdWithUser, 
                                                                  List<Automobile_Presence_Sensor__c> listAutomobilePresenceSensor,
                                                                  List<Automobile_Sensor__c> listAutomobileSensor, 
                                                                  List<Automobile_Tag__c> listAutomobileTag, List<Automobile_TDU__c> listAutomobileTDU){

        Messaging.SingleEmailMessage mailToSend =  new Messaging.SingleEmailMessage();

        mailToSend.setToAddresses(new List<String>{mapIdWithUser.get(opportunityToSendMail.OwnerId).Email});
        mailToSend.setSubject(opportunityToSendMail.Name + ' ' +System.today());
        mailToSend.setSenderDisplayName('Vishal Tourani');

        String mailBody='Sensor shipment process is completed. Please refer below mentioned details to get all the success and failure details.<br/><br/>Successful:<br/><table style="width:100%" border="1">';            
        String tableRow='<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';

        for(Automobile_Presence_Sensor__c automobile : listAutomobilePresenceSensor){
            if(listAutomobileInOpp.contains(automobile.Name)){
                listAutomobileInOpp.remove( listAutomobileInOpp.indexOf(automobile.Name) );

                if(automobile.Opportunity__c == opportunityToSendMail.Id){
                    if(automobile.Account__c == opportunityToSendMail.AccountId){
                        tableRow = tableRow + '<tr><td>Presence Sensor</td><td>'+automobile.Name+'</td><td>Sensor inserted under installation account : '+automobile.Account__r.Name+'</td></tr>';
                    }
                    else{
                        tableRow = tableRow + '<tr><td>Presence Sensor</td><td>'+automobile.Name+'</td><td>Sensor moved from installation account to shipment account : '+automobile.Account__r.Name+'</td></tr>'; 
                    }
                }
            }
        }

        for(Automobile_Sensor__c automobile : listAutomobileSensor){
            if(listAutomobileInOpp.contains(automobile.Name)){
                listAutomobileInOpp.remove( listAutomobileInOpp.indexOf(automobile.Name) );

                if(automobile.Opportunity__c == opportunityToSendMail.Id){
                    if(automobile.Account__c == opportunityToSendMail.AccountId){
                        tableRow = tableRow + '<tr><td>Sensor</td><td>'+automobile.Name+'</td><td>Sensor inserted under installation account : '+automobile.Account__r.Name+'</td></tr>';
                    }
                    else{
                        tableRow = tableRow + '<tr><td>Sensor</td><td>'+automobile.Name+'</td><td>Sensor moved from installation account to shipment account : '+automobile.Account__r.Name+'</td></tr>'; 
                    }
                }
            }
        }

        for(Automobile_Tag__c automobile : listAutomobileTag){
            if(listAutomobileInOpp.contains(automobile.Name)){
                listAutomobileInOpp.remove( listAutomobileInOpp.indexOf(automobile.Name) );

                if(automobile.Opportunity__c == opportunityToSendMail.Id){
                    if(automobile.Account__c == opportunityToSendMail.AccountId){
                        tableRow = tableRow + '<tr><td>Tag Sensor</td><td>'+automobile.Name+'</td><td>Sensor inserted under installation account : '+automobile.Account__r.Name+'</td></tr>';
                    }
                    else{
                        tableRow = tableRow + '<tr><td>Tag Sensor</td><td>'+automobile.Name+'</td><td>Sensor moved from installation account to shipment account : '+automobile.Account__r.Name+'</td></tr>'; 
                    }
                }
            }
        }

        for(Automobile_TDU__c automobile : listAutomobileTDU){
            if(listAutomobileInOpp.contains(automobile.Name)){
                listAutomobileInOpp.remove( listAutomobileInOpp.indexOf(automobile.Name) );

                if(automobile.Opportunity__c == opportunityToSendMail.Id){
                    if(automobile.Account__c == opportunityToSendMail.AccountId){
                        tableRow = tableRow + '<tr><td>TDU Sensor</td><td>'+automobile.Name+'</td><td>Sensor inserted under installation account : '+automobile.Account__r.Name+'</td></tr>';
                    }
                    else{
                        tableRow = tableRow + '<tr><td>TDU Sensor</td><td>'+automobile.Name+'</td><td>Sensor moved from installation account to shipment account : '+automobile.Account__r.Name+'</td></tr>'; 
                    }
                }
            }
        }
        mailBody = mailBody+tableRow+'</table>'+'<br/><br/>';

        if(!listAutomobileInOpp.isEmpty()){
            mailBody = mailBody+'Unsuccessful : <br/><table style="width:100%" border="1">';
            tableRow = '<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';

            for(String unsuccessfulAutomobile : listAutomobileInOpp){
                if(unsuccessfulAutomobile.startsWith(Constants.AUTOMOBILE_SENSOR)){
                    tableRow =  tableRow + '<tr><td>Sensor</td><td>'+unsuccessfulAutomobile+'</td><td>Sensor cannot inserted  under installation account because it already exists under the installation account.</td></tr>';
                }
                else if(unsuccessfulAutomobile.startsWith(Constants.AUTOMOBILE_PRESENCE_SENSOR)){
                    tableRow =  tableRow + '<tr><td>Presence Sensor</td><td>'+unsuccessfulAutomobile+'</td><td>Presence Sensor cannot inserted  under installation account because it already exists under the installation account.</td></tr>';
                }
                else if(unsuccessfulAutomobile.startsWith(Constants.AUTOMOBILE_TDU)){
                    tableRow =  tableRow + '<tr><td>TDU Sensor</td><td>'+unsuccessfulAutomobile+'</td><td>TDU Sensor cannot inserted  under installation account because it already exists under the installation account.</td></tr>';
                }
                else if(unsuccessfulAutomobile.length() > 4        && unsuccessfulAutomobile.substring(0,3).isNumeric() && 
                        unsuccessfulAutomobile.substring(3,4)=='-' && unsuccessfulAutomobile.substring(7,8)=='-'){
                    tableRow =  tableRow + '<tr><td>Tag Sensor</td><td>'+unsuccessfulAutomobile+'</td><td>Tag Sensor cannot inserted  under installation account because it already exists under the installation account.</td></tr>'; 
                }
                else{
                    tableRow =  tableRow + '<tr><td>Sensor</td><td>'+unsuccessfulAutomobile+'</td><td>Invalid Sensor</td></tr>';
                }
            }
            mailBody = mailBody+tableRow+'</table>'; 
        }
        mailToSend.setHtmlBody(mailBody);

        return mailToSend;
    }
}