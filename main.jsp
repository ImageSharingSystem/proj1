<%@ page import="java.sql.*"%>
<%
String user_name;
if (session.getAttribute("user_name")==null){
   //response.sendRedirect("login.html");
   user_name = "admin";
} else {
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
<div style="background-image:url('blue.jpg');width:100%;height:100%;solid black;">
<html>
<title> Main Page </title>
<div class="personal_info" align="right">
<h1> <font color = "white"> Name: <%=user_name%> </h1>
<a href="login.html"><font color = "yellow" onclick=<%session.removeAttribute("user_name");%>>Logout</a>
</div>

<form method="post" action="a.jsp">
<div class="search_photo">
&ensp;&ensp;&ensp;<input type="text" name="search_photo" class="search" placeholder="Search photos.." />
<input type="submit" name="search_photo" value="Search Photos">
</div>
</form>

<div class="left_part" style="float:left">
&ensp;<h3> <font color = "white"> Groups </h3>
<div style="width:300px;height:600px;line-height:3em;overflow:scroll;padding:5px;">
<div align="center">
<%
Statement stmt = null;
ResultSet rset = null;
String sql1 = "select count(*) from groups where user_name='"+user_name+"'";
String sql2 = "select group_name from groups where user_name = '"+user_name+"'";
try{
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql1);
}
	
catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
int length=0;
while(rset != null && rset.next()){
	length = (rset.getInt(1));
}

try{
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql2);
}
	
catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
out.println("<form method='get' action='groups.jsp'>");
String group_name = null;
for(int index = 0;index<length;++index){
	
	while(rset != null && rset.next()){
		   group_name = (rset.getString(index+1)).trim();
	}
	out.println("<input type='submit' value='"+group_name+"' name='"+group_name+"'style='width:250px;height:50px;font-size:1.5em'>");
	out.println("<br>");	
}
out.println("</form>");
	
%>
</div>
</div>

<form method="post" action="group_modify.jsp">
<input type="text" style="width:70px name="group_add" placeholder="Add Group.." />
&ensp;&ensp;<input type="submit" value="add" name="add"style="width:70px"/><br>
<br><input type="text" name="group_delete" placeholder="Delete Group.." />
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
