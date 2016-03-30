<HTML>
<HEAD>


<TITLE>Group Modify</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,java.util.*" %>
<% 
        if(request.getParameter("add") != null || request.getParameter("delete") != null )
        {

	        String user_name = "admin";//session.getAttribute("user_name").toString();
		session.setAttribute("user_name",user_name);
        	String group_add = (request.getParameter("group_add")).trim();
	        String group_delete = (request.getParameter("group_delete")).trim();

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
	

	        //insert new user into db
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql1 = "insert into groups(user_name,group_name) values('"+user_name+"','"+group_add+"')";
		String sql2 = "delete from groups where user_name='"+user_name+"' and group_name='"+group_delete+"'";
		try{
	        	stmt = conn.createStatement();
			if (request.getParameter("add") != null){
		           stmt.executeQuery(sql1);
			} else {
			  stmt.executeQuery(sql2);
        		}
		}
	
	        catch(SQLException ex){
			if(ex.getErrorCode() == 1400){
			  out.println("<hr><b>User Name must not be empty!</b><hr>");
			} else if (ex.getErrorCode()==1){
			  out.println("<hr><b>User Name has been used!</b></hr>");
			
			} else { 
		          out.println("<hr>" + ex.getErrorCode() + "<hr>");
        		}
		}	

                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
	} else {
	       response.sendRedirect("main.jsp");
	}
%>



</BODY>
</HTML>

