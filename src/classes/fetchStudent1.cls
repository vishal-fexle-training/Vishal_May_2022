public class fetchStudent1 
{
	public fetchStudent1()
    {
        //To fetch all Records
        List<Student__c> s1 = [Select Roll_Number__c, Name, Mobile_Number__c, Email__c, Father_Name__c, Father_Mobile_Number__c, Address__c, 
                               HomePhone__c, Stream__c, Class__c, Section__c, X1st_Sem_Percentage__c, X1st_Sem_Back__c, X2nd_Sem_Percentage__c, 
                               X2nd_Sem_Back__c, X3rd_Sem_Percentage__c, X3rd_Sem_Back__c, X4th_Sem_Percentage__c, X4th_Sem_Back__c, Bank_Name__c, 
                               IFSC_Code__c, Account_Number__c, Bank_Mobile_Number__c, Bank_City__c, Bank_State__c, Bank_Phone_Number__c, 
                               Aadhar_Card_No__c, LinkedIn_Profile__c, Date_of_Birth__c, Date_of_Joining__c, Class_Timing__c, Description__c, 
                               Overall_Percentage__c, Overall_Grade__c, Pending_Overall_Amount__c from Student__c];

		for(Student__c student : s1)
		{
			
		}
        
        //System.debug( [ Select Name from Student__c ] );

        for(Integer i=0; i<s1.size(); i++){
            System.debug(s1[i]);
        }
    }
}