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
                        response.setHeader("REFRESH","2;url=main.jsp");
                } else {
                        response.setHeader("REFRESH","2;url=login.html");
                }
                out.println("<p><b>redircting in 2 seconds</b><p>");
              
        }else
                response.sendRedirect("login.html");    
%>



</BODY>
</HTML>

