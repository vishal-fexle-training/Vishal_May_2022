public with sharing class Distinction 
{
    public final static Integer percentCheck = 75;
    
    public static List < Student__c > l1 = new List < Student__c >();
    
    public static void display() 
    {
        l1 = [Select Name, Overall_Percentage__c from Student__c];
        System.debug('Students with Distinction');
        for( Student__c rec : l1)
        {
            if(rec.Overall_Percentage__c > Distinction.percentCheck)
            {
                System.debug(rec);
            }
        }
    }
}