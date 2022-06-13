public class insertStudent 
{
    public insertStudent()
    {
		//Insert Student Record
		Student__c s1 = new Student__c();
        
        //Student Personal Info.
		s1.Name = 'Suresh Jain';
        s1.Mobile_Number__c = '7514862323';
		s1.Email__c = 'suresh.jain@icloud.com';
		s1.Father_Name__c = 'Anukul Jain';
        s1.Father_Mobile_Number__c = '7514898965';
		s1.Address__c = '486, Gaziabad, Uttar Pradesh';
        s1.HomePhone__c = '01451545455';
            
        //Class Info.
        s1.Stream__c = 'Science';
        s1.Class__c = 'MScIT';
        s1.Section__c = 'C';
        
        //Semester Info.
        s1.X1st_Sem_Percentage__c = 65;
        s1.X1st_Sem_Back__c = false;
        s1.X2nd_Sem_Percentage__c = 33;
        s1.X2nd_Sem_Back__c = true;
        s1.Subjects_in_which_Back_2nd_Sem__c = 'C++, Java';
        s1.X3rd_Sem_Percentage__c = 72;
        s1.X3rd_Sem_Back__c = false;
        s1.X4th_Sem_Percentage__c = 75;
        s1.X4th_Sem_Back__c = false;
        
        //Fees Info
        s1.Current_Year__c = 2021;
        s1.Fees_Submitted__c = true;
        s1.Pending_Exam_Fees__c = 0;
        s1.Exam_Fees_Submitted__c = false;
        s1.Pending_Exam_Fees__c = 550;
        s1.Is_Donation__c = false;
        
        //Bank Details
        s1.Bank_Name__c = 'Citi Bank';
        s1.IFSC_Code__c = 'CITI1596';
        s1.Account_Number__c = 456232321552l;
        s1.Bank_Mobile_Number__c = '753625963526';
        s1.Bank_City__c = 'Gaziabad';
        s1.Bank_State__c = 'Uttar Pradesh';
        s1.Bank_Phone_Number__c = '01451212454';
        
        //Other Details
        s1.Aadhar_Card_No__c = '748562359562';
        s1.LinkedIn_Profile__c = 'https://in.linkedin.com/in';
        s1.Date_of_Birth__c = Date.newInstance(2000, 07, 28);
        s1.Date_of_Joining__c = DateTime.newInstance(2021, 06, 01, 11, 30, 00);
        s1.Class_Timing__c = Time.newInstance(10, 15, 00, 00);
        s1.Description__c = 'Ambitious and driven. Not comfortable with settling, and always looking for an opportunity to do better and achieve greatness.';
        
        insert s1;
    }
}