public class fetchStudent 
{
	public fetchStudent()
    {
       //To fetch a single Record
       Student__c s1 = [ Select Roll_Number__c, Name, Email__c, Address__c from Student__c limit 1 ];
	   System.debug( 'Student Details : ' + s1);
    }
}