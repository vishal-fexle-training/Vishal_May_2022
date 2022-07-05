/*
  *  Purpose         :    This Class is a parent class and stores person details
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/25
  *  Revision Logs   :    V_1.0 - Created - 2022/06/25
*/
public virtual class Person{
    private String personName;
    private String personAddress;

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    A non-parameterised contructor which assigns Undefined  
      * Params        :    Void    
    */
    public Person(){
        personName='Undefined';
        personAddress='Undefined';
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    A parameterised contructor which assigns name and address
      * Params        :    String name, String address
    */
    public Person(String name, String address){
        personName=name;
        personAddress=address;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display person details
      * Params        :    Void
      * Return        :    Void
    */
    public virtual void displayDetails(){
        System.debug('Name : '+personName);
        System.debug('Address : '+personAddress);
    }
}