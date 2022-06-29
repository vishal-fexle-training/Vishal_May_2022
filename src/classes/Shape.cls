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
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display details of triangle
      * Params        :    Void
      * Return        :    Void
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
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will display details of rectangle
      * Params        :    Void
      * Return        :    Void
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