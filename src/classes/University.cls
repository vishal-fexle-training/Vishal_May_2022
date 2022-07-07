/*
  *  Purpose         :    This Class is a parent class and stores University details
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/28
  *  Revision Logs   :    V_1.0 - Created - 2022/06/28
*/
public virtual class University{
    String name;
    String address;

    public University(String name, String address){
        this.name = name;
        this.address = address;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display university details
      * Params        :    Void
      * Return        :    Void
    */
    public virtual void display(){
        System.debug('Name of University is : '+name);
        System.debug('Address of University is : '+address);
    }

    /*
      *  Purpose         :    This Class is a nested class and stores College details
      *  Created By      :    Vishal Tourani
      *  Created Date    :    2022/06/28
      *  Revision Logs   :    V_1.0 - Created - 2022/06/28
    */
    public virtual class College{
        String collegeName;
        String collegeAddress;
        University universityDetails;

        public College(String name, String address, String universityName, String universityAddress){
            collegeName = name;
            collegeAddress = address;
            universityDetails = new University(universityName, universityAddress);
        }

        /*
          * Created By    :    Vishal Tourani
          * Purpose       :    This method will display college and university details(Method Overriding)
          * Params        :    Void
          * Return        :    Void
        */
        public virtual void display(){
            System.debug('Name of College is : '+collegeName);
            System.debug('Address of College is : '+collegeAddress);
            universityDetails.display();
        }
    }
}