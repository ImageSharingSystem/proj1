<HTML>
<BODY>
<%@ page import="java.sql.*" %>
<% 
int photo_id = Integer.parseInt(request.getParameter("photo_id"));
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
Statement stmt = null;
ResultSet rset = null;
String sql = "delete from images where photo_id ="+photo_id;
try{
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
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
response.sendRedirect("main.jsp");
%>

</BODY>
</HTML>
