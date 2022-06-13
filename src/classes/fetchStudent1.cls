public class fetchStudent1 
{
	public fetchStudent1()
    {
        //To fetch all Records
        List<Student__c> s1 = [Select Roll_Number__c, Name, Email__c, Father_Name__c, Address__c, Stream__c, Class__c, Section__c from Student__c];

		for(Student__c student : s1)
		{
			system.debug('Student Details : ' + student);
		}
        
        //Another Way
        //System.debug( [ Select Name from Student__c ] );
    }
}