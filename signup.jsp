<HTML>
<HEAD>


<TITLE>Your Signup Result</TITLE>
</HEAD>

<BODY>
<!-- This page gives the user to sign up for a user name -->
<%@ page import="java.sql.*,java.util.*" %>
<% 
        if(request.getParameter("submit") != null)
        {
	        //get the user info from the signup page
        	String user_name = (request.getParameter("user_name")).trim();
	        String psw = (request.getParameter("psw")).trim();
		String fname = (request.getParameter("fname")).trim();
		String lname = (request.getParameter("lname")).trim();
		String addr = (request.getParameter("addr")).trim();
		String email = (request.getParameter("email")).trim();
		String phone = (request.getParameter("phone")).trim();
	        //establish the connection to the underlying database
        	Connection conn = null;
	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
            	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
		//Error detection
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
	

		//insert new user into db
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql1 = "insert into users(user_name,password) values('"+user_name+"','"+psw+"')";
		String sql2 = "insert into persons values('"+user_name+"','"+fname+"','"+lname+"','"+addr+"','"+email+"','"+phone+"')";
        	int state = 1;
		try{
	        	stmt = conn.createStatement();
		        stmt.executeQuery(sql1);
			stmt.executeQuery(sql2);
        	}
	
	        catch(SQLException ex){
		        state = 0;
			if(ex.getErrorCode() == 1400){
			  out.println("<hr><b>User Name must not be empty!</b><hr>");
			} else if (ex.getErrorCode()==1){
			  out.println("<hr><b>User Name has been used!</b></hr>");
			
			} else { 
		          out.println("<hr>" + ex.getErrorCode() + "<hr>");
        		}
		}
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
                if(state == 1){
			out.println("<p><b>Your Signup is Successful! </b></p>");
                        session.setAttribute("user_name",user_name);
                        response.setHeader("REFRESH","2;url=main.jsp");
                } else {
                        response.setHeader("REFRESH","2;url=signup.html");
                }
                out.println("<p><b>redircting in 2 seconds</b><p>");
              
        }else
                response.sendRedirect("login.html");
%>



</BODY>
</HTML>
