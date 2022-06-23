public with sharing class YogaClass 
{
    public YogaClass() 
    {
        Map<String, Map<String, List<Student__c>>> yogaClassMap = new Map<String, Map<String, List< Student__c>>>();

        //For Students in MA, Arts
        List<Student__c> listStudentsMAArts = new List<Student__c>();

        listStudentsMAArts = [ Select Id, Roll_Number__c, Name, Class__c, Stream__c 
			                   FROM Student__c
			                   WHERE Class__c = 'MA' and Stream__c = 'Arts' ];

        Map<String, List<Student__c>> mapOfStudentsInMA = new Map<String, List<Student__c>>();
        mapOfStudentsInMA.put('Arts', listStudentsMAArts);


        //ForStudents in MBA, Commerce
        List<Student__c> listStudentsMBACommerce = new List<Student__c>();

        listStudentsMBACommerce = [ Select Id, Roll_Number__c, Name, Class__c, Stream__c 
					                FROM Student__c
					                WHERE Class__c = 'MBA' and Stream__c = 'Commerce' ];

        Map<String, List<Student__c>> mapOfStudentsInMBA = new Map<String, List<Student__c>>();
        mapOfStudentsInMBA.put('Commerce', listStudentsMBACommerce);



        //Query to retrieve Students in MScIT, Science
        List<Student__c> listStudentsMScITScience = new List<Student__c>();

        listStudentsMScITScience = [ Select Id, Roll_Number__c, Name, Class__c, Stream__c 
					                 FROM Student__c
					                 WHERE Class__c = 'MScIT' and Stream__c = 'Science' ];

        Map<String, List<Student__c>> mapOfStudentsInMScIT = new Map<String, List<Student__c>>();
        mapOfStudentsInMScIT.put('Science', listStudentsMScITScience);

        yogaClassMap.put('MA', mapOfStudentsInMA);
        yogaClassMap.put('MBA', mapOfStudentsInMBA);
        yogaClassMap.put('MScIT', mapOfStudentsInMScIT);

        System.debug('Students in MA' + yogaClassMap.get('MA'));
        System.debug('Students in MBA' + yogaClassMap.get('MBA'));
        System.debug('Students in MScIT' + yogaClassMap.get('MScIT'));

        for( Map< String, List<Student__c>> m1 : yogaClassMap.values() )
        {
            System.debug(m1);
        }
    }
}