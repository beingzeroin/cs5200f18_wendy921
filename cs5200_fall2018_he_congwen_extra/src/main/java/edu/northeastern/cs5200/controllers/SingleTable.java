package edu.northeastern.cs5200.controllers;



import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import edu.northeastern.cs5200.daos.MySQLDao;

@RestController
public class SingleTable {
	
	@RequestMapping(value= "/api/{table}",method = RequestMethod.POST)
	public String CreateTable(@PathVariable("table") String name, @RequestBody String Json)
	{
		MySQLDao mySQL = MySQLDao.getInstance();
		mySQL.CreateTable(Json, name);
		return mySQL.InsertValues(Json, name);
		}
	
	
	
	@RequestMapping(value= "/api/{table}",method = RequestMethod.GET)
	public String FindAllData(@PathVariable("table") String name)
			
	{
		MySQLDao mySQL = MySQLDao.getInstance();
		return mySQL.FindAll(name);
		
	}
	
	@RequestMapping(value= "/api/find/{table}?{predicates}",method = RequestMethod.GET)
	public String FindByCondition(@PathVariable("table") String name, HttpServletRequest req)
	{
		MySQLDao mySQL = MySQLDao.getInstance();
		Enumeration em = req.getParameterNames();
		StringBuilder sb = new StringBuilder();
		if(!em.hasMoreElements()) {
			return mySQL.FindAll(name);
		}else {
			while (em.hasMoreElements()) {
				String name1 = (String) em.nextElement();
				String value = req.getParameter(name1);
				sb.append(name1+"="+value+"&");
			}
			sb.deleteCharAt(sb.length() - 1);
		}
		return mySQL.FindByCondition(name, sb.toString());
		
	}
	
	@RequestMapping(value= "/api/{table}/{id}",method = RequestMethod.GET)
	public String FindById(@PathVariable("table") String name,
			@PathVariable("id") String id)
			
	{
		MySQLDao mySQL = MySQLDao.getInstance();
		return mySQL.FindById(name, id);
		
	}
	
	@RequestMapping(value= "/api/{table}/{id}",method = RequestMethod.PUT)
	public String UpdateDataById(@PathVariable("table") String name, 
			@PathVariable("id") String id, @RequestBody String Json)
	{
		MySQLDao mySQL = MySQLDao.getInstance();
		mySQL.CreateTable(Json, name);
		return mySQL.UpdateById(name, id, Json);
		
	}

	
	@RequestMapping(value= "/api/{table}/{id}",method = RequestMethod.DELETE)
	public String DeleteDataById(@PathVariable("table") String name, 
			@PathVariable("id") String id)
	{
		MySQLDao mySQL = MySQLDao.getInstance();
		return mySQL.DeleteById(name, id);
		
	}
	
	
	@RequestMapping(value= "/api/{table}",method = RequestMethod.DELETE)
	public String TruncateTable(@PathVariable("table") String name)
	{
		MySQLDao mySQL = MySQLDao.getInstance();
		return mySQL.TruncateTable(name);
		
	}
    
}
