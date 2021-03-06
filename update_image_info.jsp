<HTML>
<BODY>
<!-- import java class -->
<%@ page import="java.sql.*" %>
<% 

// get the user info from the session
String user_name = session.getAttribute("user_name").toString();
String subject = (request.getParameter("subject")).trim();
String place = (request.getParameter("place")).trim();
String description = (request.getParameter("description")).trim();
int group = Integer.parseInt(request.getParameter("group"));
int option = 0;//
int photo_id = Integer.parseInt(request.getParameter("photo_id"));

// change permission
int permitted;
if(group==-1){
  permitted = Integer.parseInt(request.getParameter("option"));
} else {
  permitted = group;
}

//establish the connection to the underlying database
Connection conn = null;
String driverName = "oracle.jdbc.driver.OracleDriver";
String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	

// error handling
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


// SQL statement to update image info
Statement stmt = null;
ResultSet rset = null;
String sql = "update images set subject='"+subject+"',place='"+place+"',description='"+description+"',permitted="+permitted+" where photo_id="+photo_id;
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
