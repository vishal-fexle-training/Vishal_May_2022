public with sharing class Patterns1 
{
    public static void leftTriangle(Integer lines)
    {
        String s = '';

        for( Integer i=0; i<lines; i++ )
        {
	        for( Integer j=i; j<lines-1; j++ )
		        s = s + '_';

	        for( Integer k=0; k<=i; k++ )
		        s = s + '*';
    
            System.debug(s);
            s = '';
        }
    }   
    
    public static void downwardTriangle(Integer lines)
    {
        String s = '';

        for(Integer i=0; i<lines; i++)
        {
	        for(Integer j=i; j<lines; j++)
		        s = s + '*';
    
            System.debug(s);
            s = '';
        }
    }

    public static void reversedPyramid(Integer lines)
    {
        String s = '';
        
        for(Integer i=0; i<lines; i++)
        {
	        for(Integer j=0; j<i; j++)
		        s = s + '_';

	        for(Integer k=i; k<lines; k++)
		        s = s + '*_';
    
            System.debug(s);
            s = '';
        }
    }

    public static void rightPascalTriangle(Integer lines)
    {
        String s = '';
        Integer i=0;

        while( i < lines )
        {
	        if( i < lines/2 )
	        {
		        for( Integer j=0; j<=i; j++ )
			        s = s + '*';
		
		        i++;
	        }
	        else
	        {
		        for( Integer k=i; k<lines; k++ )
			        s = s + '*';
	
		        i++;
	        }

	        System.debug(s);
	        s = '';
        }
    }
}