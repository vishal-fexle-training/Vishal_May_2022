public class insertStudent1 
{
	public static void insertRecord() 
    {
		//Insert Student Record
		Student__c s1 = new Student__c();
        
        //Student Personal Info.
		s1.Name = 'Harish Soni';
        s1.Mobile_Number__c = '7531596548';
		s1.Email__c = 'harish.soni@icloud.com';
		s1.Father_Name__c = 'Ram Soni';
        s1.Father_Mobile_Number__c = '7514898525';
		s1.Address__c = '852, Jodhpur, Rajasthan';
        s1.HomePhone__c = '01456235623';
            
        //Class Info.
        s1.Stream__c = 'Arts';
        s1.Class__c = 'MA';
        s1.Section__c = 'A';
        
        //Semester Info.
        s1.X1st_Sem_Percentage__c = 65;
        s1.X1st_Sem_Back__c = false;
        s1.X2nd_Sem_Percentage__c = 84;
        s1.X2nd_Sem_Back__c = false;
        s1.X3rd_Sem_Percentage__c = 72;
        s1.X3rd_Sem_Back__c = false;
        s1.X4th_Sem_Percentage__c = 75;
        s1.X4th_Sem_Back__c = false;
        
        //Fees Info
        s1.Current_Year__c = 2021;
        s1.Fees_Submitted__c = true;
        s1.Pending_Exam_Fees__c = 0;
        s1.Exam_Fees_Submitted__c = true;
        s1.Pending_Exam_Fees__c = 0;
        s1.Is_Donation__c = false;
        
        //Bank Details
        s1.Bank_Name__c = 'Indusland Bank';
        s1.IFSC_Code__c = 'INDUS596';
        s1.Account_Number__c = 753269852525l;
        s1.Bank_Mobile_Number__c = '7532589632';
        s1.Bank_City__c = 'Jodhpur';
        s1.Bank_State__c = 'Rajasthan';
        s1.Bank_Phone_Number__c = '01451535265';
        
        //Other Details
        s1.Aadhar_Card_No__c = '753269852365';
        s1.LinkedIn_Profile__c = 'https://in.linkedin.com/in';
        s1.Date_of_Birth__c = Date.newInstance(1999, 01, 15);
        s1.Date_of_Joining__c = DateTime.newInstance(2022, 01, 14, 12, 30, 00);
        s1.Class_Timing__c = Time.newInstance(09, 15, 00, 00);
        s1.Description__c = 'Ambitious and driven. Not comfortable with settling, and always looking for an opportunity to do better and achieve greatness.';
        
        insert s1;
    }
}