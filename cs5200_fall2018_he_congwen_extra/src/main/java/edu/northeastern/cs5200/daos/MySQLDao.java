package edu.northeastern.cs5200.daos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONObject;
import org.json.JSONTokener;

import edu.northeastern.cs5200.MyConnection;



public class MySQLDao {
	
	private static MySQLDao instance = null;
	private MySQLDao() {}
	public static MySQLDao getInstance()
	{
		if (instance == null)
			instance = new MySQLDao();
		return instance;
	}
	
	
	public void CreateTable(String Json,String name)
	{
		Statement statement = null;
		Statement statement2 = null;
		
		Connection conn = null;
		ResultSet result = null;
		
		
        JSONTokener dataToken = new JSONTokener(Json);
        JSONObject jsonData = new JSONObject(dataToken);
        StringBuilder create = new StringBuilder("Create table "+name+" (");
        String IF_EXIST = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES where "
        		+ "TABLE_SCHEMA='assignmentExtra_congwen' and "
        		+ "TABLE_NAME='"+name+"' ;";
        
        
        for(String key : jsonData.keySet()) {
        	create.append(key + " varchar(255),");
        }
        create.append("primary key(id)");
        //create.deleteCharAt(create.length() - 1);
        create.append(")");
        String CREATE_TABLE = create.toString();
		 try {
			  
			    conn = MyConnection.getConnection(); 
				statement = conn.createStatement();
				result = statement.executeQuery(IF_EXIST);
				
				if(!result.next())
				{
					statement.execute(CREATE_TABLE);
					
				}
				else {
					result = null;
					for(String key : jsonData.keySet())
					{String IF_COL_EXIST = "select * from INFORMATION_SCHEMA.COLUMNS where "
			        		+ "TABLE_SCHEMA = 'assignmentExtra_congwen' and TABLE_NAME = '"+name+"' and "
			        		+ "COLUMN_NAME = '"+ key +"';";
					
					//statement = conn.createStatement();
					result = statement.executeQuery(IF_COL_EXIST);
					 
					if(!result.next())
					{
			        String ADD_COL ="alter table "+ name +" add "+key+" varchar(225);";
			        statement2 = conn.createStatement();
					statement2.execute(ADD_COL);
					statement2.close();
					System.out.println("alter:"+ADD_COL);
					}
					}
					
				}
				
				}
		  catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		     
		       finally {
			     try {
			    	result.close();
					statement.close(); 
					 
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		            }
		
	}
	
	
	
	/////////////////////////////////////////////////////////////////////
	public String InsertValues(String Json,String name) {
		Statement statement = null;
		Connection conn = null;
		ResultSet result =null;
		//PrepareStatement preStatement = null;
		
        JSONTokener dataToken = new JSONTokener(Json);
        JSONObject jsonData = new JSONObject(dataToken);
        StringBuilder insert = new StringBuilder("insert into "+name+" ( ");
        StringBuilder ret = new StringBuilder("select * from "+ name +" where ");
        for(String key : jsonData.keySet()) {
        	insert.append(key + " ,");
        }
        insert.deleteCharAt(insert.length() - 1);
        insert.append(") values(");
        for(String key : jsonData.keySet()) {
        	insert.append("'"+jsonData.get(key)+"'" + " ,");
        	ret.append(key + "=" + "'"+jsonData.get(key)+"' and ");
        }
        ret.delete(ret.length() - 4, ret.length() - 1);
        insert.deleteCharAt(insert.length() - 1);
        insert.append(")");
        String INSERT_TABLE = insert.toString();
        String RETURN_JSON = ret.toString();
        
        
        try {
			  
		    conn = MyConnection.getConnection(); 
			statement = conn.createStatement();
			System.out.println(INSERT_TABLE);
			statement.execute(INSERT_TABLE);
			
			result = statement.executeQuery(RETURN_JSON);
			ResultSetMetaData rsmd = result.getMetaData();
			StringBuilder res = new StringBuilder("{");
			while(result.next())
			{
				for(int i = 0; i < rsmd.getColumnCount();i++) {
					String col = rsmd.getColumnName(i+1);
					String val = result.getString(col);
					res.append("\""+col+"\":");
					if(val == null) {
						res.append("null");
					}else {
						res.append("\""+val+"\"");
					}
					if(i != rsmd.getColumnCount() - 1) {
						res.append(",");
					}
				}
			}
			res.append("}");
			return res.toString();
			}
	  catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     
	       finally {
		      try {
		    	 statement.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	            }
		return null;
	}
	
	
	//////////////////////////////////////////////////////////////////////
	public String FindAll(String name)
	{
		Statement statement = null;
		Connection conn = null;
		ResultSet result =null;
		
		
		String IF_EXIST = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES where "
	        		+ "TABLE_SCHEMA='assignmentExtra_congwen' and "
	        		+ "TABLE_NAME='"+name+"' ;";
		String RETURN_JSON = "select * from "+ name;
		
		 try {
			  
			    conn = MyConnection.getConnection(); 
				statement = conn.createStatement();
				result = statement.executeQuery(IF_EXIST);
				
				if(result.next())
				{
					result = statement.executeQuery(RETURN_JSON);
					ResultSetMetaData rsmd = result.getMetaData();
					StringBuilder res = new StringBuilder("[");
					while(result.next())
					{	
						res.append("{");
						for(int i = 0; i < rsmd.getColumnCount();i++) {
							String col = rsmd.getColumnName(i+1);
							String val = result.getString(col);
							res.append("\""+col+"\":");
							if(val == null) {
								res.append("null");
							}else {
								res.append("\""+val+"\"");
							}
							if(i != rsmd.getColumnCount() - 1) {
								res.append(",");
							}
						}
						res.append("},");
					}
					res.deleteCharAt(res.length() - 1);
					res.append("]");
					return res.toString();
				}
				else
					{return null;}
	
			
	}
	  catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     
	       finally {
		      try {
		    	  result.close();
		    	 statement.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	       }
		return null;
	}
	
	
	
///////////////////////////////////////////////////////////////////////////
	
	public String FindByCondition(String name, String predicates)
	{
		Statement statement = null;
		Connection conn = null;
		ResultSet result =null;
		
		String IF_EXIST = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES where "
        		+ "TABLE_SCHEMA='assignmentExtra_congwen' and "
        		+ "TABLE_NAME='"+name+"' ;";
	    String RETURN_JSON = "select * from  "+ name +" where "+predicates;
	    System.out.println(RETURN_JSON);
	    
	    try {
			  
		    conn = MyConnection.getConnection(); 
			statement = conn.createStatement();
			result = statement.executeQuery(IF_EXIST);
			
			if(result.next())
			{
				result = statement.executeQuery(RETURN_JSON);
				ResultSetMetaData rsmd = result.getMetaData();
				StringBuilder res = new StringBuilder("[");
				while(result.next())
				{	
					res.append("{");
					for(int i = 0; i < rsmd.getColumnCount();i++) {
						String col = rsmd.getColumnName(i+1);
						String val = result.getString(col);
						res.append("\""+col+"\":");
						if(val == null) {
							res.append("null");
						}else {
							res.append("\""+val+"\"");
						}
						if(i != rsmd.getColumnCount() - 1) {
							res.append(",");
						}
					}
					res.append("},");
				}
				res.deleteCharAt(res.length() - 1);
				res.append("]");
				return res.toString();
			}
			else
				{return null;}

		
}
  catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
     
       finally {
	      try {
	    	  result.close();
	    	 statement.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       }
	return null;
	}
	
	
	
	/////////////////////////////////////////////////////////////////////////
	public String FindById(String name, String id)
	{
		Statement statement = null;
		Connection conn = null;
		ResultSet result =null;
		
		
		String IF_EXIST = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES where "
        		+ "TABLE_SCHEMA='assignmentExtra_congwen' and "
        		+ "TABLE_NAME='"+name+"' ;";
	    String RETURN_JSON = "select * from "+ name +" where id="+id;
	    System.out.println(RETURN_JSON);
	    
	    try {
			  
		    conn = MyConnection.getConnection(); 
			statement = conn.createStatement();
			result = statement.executeQuery(IF_EXIST);
			
			if(result.next())
			{
				result = statement.executeQuery(RETURN_JSON);
				ResultSetMetaData rsmd = result.getMetaData();
				StringBuilder res = new StringBuilder("[");
				while(result.next())
				{	
					res.append("{");
					for(int i = 0; i < rsmd.getColumnCount();i++) {
						String col = rsmd.getColumnName(i+1);
						String val = result.getString(col);
						res.append("\""+col+"\":");
						if(val == null) {
							res.append("null");
						}else {
							res.append("\""+val+"\"");
						}
						if(i != rsmd.getColumnCount() - 1) {
							res.append(",");
						}
					}
					res.append("},");
				}
				res.deleteCharAt(res.length() - 1);
				res.append("]");
				return res.toString();
			}
			else
				{return null;}

		
}
  catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
     
       finally {
	      try {
	    	  result.close();
	    	 statement.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       }
	return null;
	}
	
	
	
	
	//////////////////////////////////////////////////////////////
	
	public String UpdateById(String name, String id, String Json)
	{
		Statement statement = null;
		Connection conn = null;
		ResultSet result =null;
		
		
		String IF_EXIST = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES where "
        		+ "TABLE_SCHEMA='assignmentExtra_congwen' and "
        		+ "TABLE_NAME='"+name+"' ;";
		
		String REC_EXIST = "select * from "+ name +" where id="+id;
	    String DELETE_JSON = "delete from "+ name +" where id="+id;
	    System.out.println(REC_EXIST);
	    System.out.println(DELETE_JSON);
	    
	    try {
			  
		    conn = MyConnection.getConnection(); 
			statement = conn.createStatement();
			result = statement.executeQuery(IF_EXIST);
			
			if(result.next())
			{
				
				result = statement.executeQuery(REC_EXIST);
				
				if(result.next())
				{	
                statement.execute(DELETE_JSON);

			    result.close();
			    statement.close();
				conn.close();
				
				return InsertValues(Json, name);
				}
			}
			
			else return null;
				
	    }
		

  catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
     
      
	return null;
	}
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////
	public String DeleteById(String name, String id)
	{
		Statement statement = null;
		Connection conn = null;
		ResultSet result =null;
		
		
		String IF_EXIST = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES where "
        		+ "TABLE_SCHEMA='assignmentExtra_congwen' and "
        		+ "TABLE_NAME='"+name+"' ;";
		
		String REC_EXIST = "select * from "+ name +" where id ="+id;
		String DELETE_JSON = "delete from "+ name +" where id="+id;
		
		System.out.println(REC_EXIST);
	    System.out.println(DELETE_JSON);
	    
	    
	    try {
			  
		    conn = MyConnection.getConnection(); 
			statement = conn.createStatement();
			result = statement.executeQuery(IF_EXIST);
			
			if(result.next())
			{
				
				result = statement.executeQuery(REC_EXIST);
				
				if(result.next())
				{	
                statement.execute(DELETE_JSON);
                
                result.close();
			    statement.close();
				conn.close();

				String status = "Delete successfully!";
				return status;
				}
			}
			else return null;
	    }
		

	    catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
		}
	
	
	
	
	/////////////////////////////////////////////////////////////
	public String TruncateTable(String name)
	{
		Statement statement = null;
		Connection conn = null;
		ResultSet result =null;
		
		
		String IF_EXIST = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES where "
        		+ "TABLE_SCHEMA='assignmentExtra_congwen' and "
        		+ "TABLE_NAME='"+name+"' ;";
		
		
		String TRUNCATE_JSON = "truncate table "+ name;
		
		
	    System.out.println(TRUNCATE_JSON);
	    
	    
	    try {
			  
		    conn = MyConnection.getConnection(); 
			statement = conn.createStatement();
			result = statement.executeQuery(IF_EXIST);
			
			if(result.next())
			{
				statement.execute(TRUNCATE_JSON);
				
                result.close();
			    statement.close();
				conn.close();

				String status = "Truncate table "+name+" successfully!";
				return status;
				
			}
			else return null;
	    }
		

	    catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
}
