<!-- Template referenced from http://luscar.cs.ualberta.ca:8080/yuan/ 
/***
 *  Copyright 2016 COMPUT 391, CS, UofA                             
 *  Author:  Liyan Yuan
 *                                                                  
 *  Licensed under the Apache License, Version 2.0 (the "License");         
 *  you may not use this file except in compliance with the License.        
 *  You may obtain a copy of the License at                                 
 *      http://www.apache.org/licenses/LICENSE-2.0                          
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  
 ***/
-->

<HTML>
<HEAD>


<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>
<!--A simple example to demonstrate how to use JSP to 
    connect and query a database. 
    @author  Hong-Yu Zhang, University of Alberta
 -->
<%@ page import="java.sql.*" %>
<% 

        if(request.getParameter("submit") != null)
        {

	        //get the user input from the login page
        	String user_name = (request.getParameter("user_name")).trim();
	        String psw = (request.getParameter("psw")).trim();

	        //establish the connection to the underlying database
        	Connection conn = null;
	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
            	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
	        try{
		        //load and register the driver
        		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
        	}
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
	
	        }
	
        	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"dingkai","az11kt133");
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	

	        //select the user table from the underlying db and validate the user name and password
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql = "select password from users where user_name = '"+user_name+"'";
        	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}

	        String truepsw = null;
	
        	while(rset != null && rset.next())
	        	truepsw = (rset.getString(1)).trim();
	
        	//display the result
                int state = 0;
	        if(psw.equals(truepsw)){
		        out.println("<p><b>Your Login is Successful!</b></p>");
                        state = 1;
                }
        	else
	        	out.println("<p><b>Either your userName or Your password is inValid!</b></p>");

                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
                if(state == 1){
                        session.setAttribute("user_name",user_name);
                        if(user_name.equals("admin")){
                             response.setHeader("REFRESH","2;url=admin.jsp");
                        } else {
                             response.setHeader("REFRESH","2;url=main.jsp");
                        }
                } else {
                        response.setHeader("REFRESH","2;url=login.html");
                }
                out.println("<p><b>redirecting in 2 seconds</b><p>");
              
        }else
                response.sendRedirect("login.html");    
%>



</BODY>
</HTML>

