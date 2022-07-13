/*
  *  Purpose         :    Wrapper class to store Country details
  *  Created By      :    Vishal Tourani
  *  Created Date    :    2022/07/07
  *  Revision Logs   :    V_1.0 - Created - 2022/07/07
*/
public with sharing class CountryWrapper{
    public Decimal countryCode;
	  public Decimal totalDistricts;
	  public Decimal totalStates;
	  public Map<String, Map<String, List<String>>> mapHierarchy = new Map<String, Map<String, List<String>>>();

    /*
      * Created By    :    Vishal Tourani
      * Purpose       :    This method will set country hierarchy
      * Params        :    String country, String state, List<String> districts
      * Return        :    Void
    */
	  public void setMapHierarchy(String country, String state, List<String> districts){
		  Map<String, List<String>> mapState = new Map<String, List<String>>();
		  mapState.put(state, districts);
		  mapHierarchy.put(country, mapState);
	  }
}