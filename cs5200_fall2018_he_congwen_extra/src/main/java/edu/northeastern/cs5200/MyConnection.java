package edu.northeastern.cs5200;

import java.sql.*;

public class MyConnection 
{
	private static MyConnection instance = null;
	private MyConnection() {}
	public static MyConnection getInstance()
	{
		if (instance == null)
			instance = new MyConnection();
		return instance;
	}
	

	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String URL = "jdbc:mysql://cs5200-fall2018-congwenhe.czzfymjtq8o2.us-east-2.rds.amazonaws.com:3304/assignmentExtra_congwen?autoReconnect=true&useSSL=false";
	private static final String USER = "CongwenHe";
	private static final String PASSWORD = "hecongwen-921";
	
	

	public static java.sql.Connection getConnection() throws ClassNotFoundException, SQLException 
	{
   	Class.forName(DRIVER);
   	return  DriverManager.getConnection(URL, USER, PASSWORD);
	}
	
	public static void closeConnection(java.sql.Connection conn) {
  	 try {
  		 conn.close();
  	 } catch (SQLException e) {
  		 // TODO Auto-generated catch block
  		 e.printStackTrace();
  	 }
	}
}
