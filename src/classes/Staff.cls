/*
  *  Purpose         :    This Class is a child class and stores Staff details
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_2.0 - Created - 2022/07/05
*/
public with sharing class Staff extends University.College{
    String staffName;    

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    A non-parameterised contructor which assigns Undefined  
      * Params        :    Void    
    */
    public Staff(){
        this('Undefined', 'Undefined', 'Undefined', 'Undefined', 'Undefined');
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    A parameterised contructor which assigns Name, CCollege name, College Address, University Name, University Address  
      * Params        :    Void    
    */
    public Staff(String name, String collegeName, String collegeAddress, String universityName, String universityAddress){
        super(collegeName, collegeAddress, universityName, universityAddress);        
        staffName = name;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will return staff name to display
      * Params        :    Void
      * Return        :    String
    */
    public String displayStaff(){
        return staffName;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display staff, college and university details(Method Overriding)
      * Params        :    Void
      * Return        :    Void
    */
    public override void display(){
        super.display();
        System.debug('Name of Professor : '+staffName);
    }
}