public with sharing class Patterns 
{
    public static void downTriangle(Integer lines) 
    {
        String s = '';
        
        for( Integer i=1; i<lines-1; i++ )
        {	
            //To print first line 
	        if( i==1 )
	        {
	    	    for( Integer l=1; l<lines*2; l++ )
			        s = s + '*';

    	        System.debug(s);
    	        s = '';
            }

            //To print lines in between
            for( Integer j=0; j<i; j++ )
		        s = s + '_';
	        s = s + '*';
	
    	    for( Integer k=i; k<=lines-i+1; k++ )
	    	    s = s + '_';
            s = s + '*';

            System.debug(s);
            s = '';

            //To print last line
            if( i==lines-2 )
            {
    	        for( Integer m=1; m<lines; m++ )
			        s = s + '_';

		        s = s + '*';
		        System.debug(s);
            }
        }
    }

    public static void leftPascalTriangle(Integer lines)
    {
        String s = '';
        Integer i = 0;
        Integer j,k;

        for( ; i<lines/2+1; i++ )
        {
            for( j=i; j<lines/2; j++ )
                s = s + '_';

            for( k=0; k<=i; k++ )
                s = s + '*';

            System.debug(s);
            s = '';
        }

        for( ; i<lines; i++ )
        {
            for( j=lines/2; j<i; j++ )
	            s = s + '_';

            for( k=i; k<lines; k++ )
	            s = s + '*';

            System.debug(s);
            s = '';
        }
    }
}