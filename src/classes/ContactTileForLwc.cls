/*
  *  Purpose         :    Class for Contact Tile LWC Component
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/09/16
  *  Revision Logs   :    V_1.0 - Created - 2022/09/16
*/
public with sharing class ContactTileForLwc{

    /*
     * Created By    :    Vishal Tourani
     * Purpose       :    Method to contact records
     * Params        :    Void
     * Return        :    Void
    */
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        return [Select Id, Name, FirstName, LastName from Contact];
    }
}