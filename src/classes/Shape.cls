/*
  *  Purpose         :    This Class will display details about shapes
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/06/25
  *  Revision Logs   :    V_1.0 - Created - 2022/06/25
*/
public class Shape{
    public Shape(){
        System.debug('Details of Shape');
    }

    /*
      *  Purpose         :    This Class will display details about triangle
      *  Created By      :    Vishal Tourani
      *  Created Date    :    2022/06/25
      *  Revision Logs   :    V_1.0 - Created - 2022/06/25
    */
    public class Triangle{
        public Triangle(){
            System.debug('Details of Triangle');
        }
        public void details(){
            System.debug('Sides : 3');
            System.debug('Corners : 3');
        }
    }

    /*
      *  Purpose         :    This Class will display details about rectangle
      *  Created By      :    Vishal Tourani
      *  Created Date    :    2022/06/25
      *  Revision Logs   :    V_1.0 - Created - 2022/06/25
    */
    public class Rectangle{
        public Rectangle(){
            System.debug('Details of Rectangle');
        }
        public void details(){
            System.debug('Sides : 4');
            System.debug('Corners : 4');
        }
    }
}