package tp5;

import java.io.*;
import java.sql.*;

public class Exo1{
    public static void main(String args[]) throws SQLException,IOException{
	try{
	    Class.forName("oracle.jdbc.driver.OracleDriver");}
	catch(ClassNotFoundException x){
	    System.out.println("Driver could not be loaded");}
    
	String dbacct, passwrd,lname,fname;
    
	dbacct="youlhajen";

	passwrd="youlhajen";
    
	Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@orval.fil.univ-lille1.fr:1521:filora10gr2",dbacct,passwrd);


    String stmt1="select nom,prenom from PATIENTS where numpat=1";

	PreparedStatement p = conn.prepareStatement(stmt1);
	
	p.clearParameters();
    
	ResultSet r = p.executeQuery();
	while(r.next()){
	    lname = r.getString(1);
	    fname = r.getString(2);
	    System.out.println(lname+" "+fname);
	} 
	conn.close();
    
    }
  


}