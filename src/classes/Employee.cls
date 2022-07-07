/*
  *  Purpose         :    This Class is a child class of person and stores employee details
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/25
  *  Revision Logs   :    V_1.0 - Created - 2022/06/25
*/
public class Employee extends Person{
    private String employeeId;
    private Integer employeeSalary;

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    A non-parameterised contructor which assigns Undefined  
      * Params        :    Void    
    */
    public Employee(){
        super();
        employeeId='Undefined';
        employeeSalary=0;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    A parameterised contructor which assigns name, address, id and salary
      * Params        :    String name, String address, String id, Integer salary
    */
    public Employee(String name, String address, String id, Integer salary){
        super(name, address);
        employeeId=id;
        employeeSalary=salary;
    }

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display person and employee details(Method Overriding)
      * Params        :    Void
      * Return        :    Void
    */
    public override void displayDetails(){
        super.displayDetails();
        System.debug('Employee ID : '+employeeId);
        System.debug('Salary : '+employeeSalary);
    }
}