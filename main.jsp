<div style="background-image:url('blue.jpg');width:100%;height:100%;solid black;">
<html>
<%@ page import="java.sql.*,java.util.*" %>
<%
//Check if login
String user_name = null;
if (session.getAttribute("user_name")==null){
	response.sendRedirect("login.html");
}else{
	user_name = session.getAttribute("user_name").toString();
} 
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
%>
<title> Main Page </title>
<div class="personal_info" align="right">
<p style="font-size:1.2em"> <font color = "white"> Name:<%=user_name%> </p>
<a href="address"><font color = "yellow">Logout</a>
</div>

<form method="post" action="a.jsp">
<div class="search_photo">
&ensp;&ensp;&ensp;<input type="text" name="search_photo" class="search" placeholder="Search photos.." />
<input type="submit" name="search_photo" value="Search Photos">
</div>
</form>

<div class="left_part" style="float:left">
&ensp;<h3> <font color = "white"> Groups </h3>
<form method="post" action="a.jsp">
<div style="width:300px;height:550px;line-height:3em;overflow:scroll;padding:5px;">
<div align="center">
<%
Statement stmt = null;
ResultSet rset = null;
String sql = "select group_name from groups where user_name = '"+user_name+"'";
try{
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
}
	
catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
%>
<form method="post" action="group.jsp">
<%
while(rset != null && rset.next()){
	out.println("<input type='submit' value='"+rset.getString(1).trim()+"'style='width:250px;height:50px;font-size:2em;text-align:center'>");
	out.println("<br>");
}
%>
</form>
</div>
</div>

<form method="post" action="group_add.jsp">
<input type="text" name="add" class="add" placeholder="Add Group.." />
&ensp;&ensp;<input type="submit" name="submit" value="Add" style="width:70px">
</form>
<from method="post" action="group_delete.jsp">
<input type="text" name="delete" class="delete" placeholder="Delete Group.." />
&ensp;&ensp;<input type="submit" name="delete" value="Delete" style="width:70px">
</form>
</div>



<div class="right_part"  style="width:1300px;
    height:auto;
    text-align:center;
    position:relative;float:right;">
<div align="center">
<h3> <font color ="white"> Personal Photos </h3>
<div style="width:1200px;height:600px;line-height:3em;overflow:scroll;padding:5px;">
<form action="demo_form.asp">
<input type="file" name="pic" accept="image/*">
<form method="post" action="a.jsp">
<input type="submit" value="Upload" style="height:50px; width:150px">
</form>
</div>
<div class="document" align="right">
<br><br>
<a href="address"><font color = "yellow">User Documentation</a><br>
</div>
</div>
</div>
<%
try{
	conn.close();
}
catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
%>

</html>

