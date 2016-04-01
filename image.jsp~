<html>
<title> Image Information </title>
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
int photo_id = Integer.parseInt(request.getParameter("photo"));
Statement stmt = null;
ResultSet rset = null;
String sql = "select * from images where photo_id = "+photo_id;
try{
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
}
catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
	

int permitted = -1;
java.util.Date time = null;
String subject = null;
String place = null;
String description = null;
if(rset != null && rset.next()){
	permitted = rset.getInt("permitted");
	time = rset.getDate("date_upload");
	subject = rset.getString("subject");
	place = rset.getString("place");
	description = rset.getString("description");
}


%>
<div style="background-image:url('GetOnePic?big<%=photo_id%>');background-position:center;background-repeat:no-repeat;width:100%;height:100%;solid black;">
<div class="image" align="center" style="padding-top:200px">

<form method="post" action="update_image_info.jsp">
<input type="hidden" name="photo_id" value=<%=photo_id%>></input>
<div class="image_info" align="center">
<h2>Subject &emsp;&emsp;&emsp;<input type="text" name="subject" value=<%=subject%>></h2>
<h2>Place &emsp;&emsp;&emsp;&emsp;<input type="text" name="place" value=<%=place%>></h2>
<h2>Time &emsp;&emsp;&emsp;&emsp;&emsp;<%=time.toString()%></h2>
<h2>Description &emsp;<input type="text" name="description" value=<%=description%>></h2><br>
<%
String str1 = "<h3><input type='radio'  name='group' value=0 ";
String str2 = "<input type='radio' name='group' value=1 ";
String str3 = "<input type='radio'  name='group' value=-1 ";
if (permitted==1){
   str1+="checked";
}
else if (permitted==0){
   str2+="checked";
}else{
   str3+="checked";
}
out.println(str1+">Private");
out.println(str2+">Public");
out.println(str3+">Others</h3>");
%>

<div>
<select name="option" onchange='this.value=this.options[this.selectedIndex].value;'>
<%
sql = "select * from groups where user_name = '"+user_name+"'";
try{
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
}
	
catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
String select = "";
String group_name = null;
Integer group_id = null;
while(rset != null && rset.next()){
	group_name = rset.getString("group_name");
	group_id = rset.getInt("group_id");
	if (group_id == permitted){
	  select = "selected = 'selected'";
	} else {
	  select = "";
	}
	out.println("<option"+select+" value="+group_id+">"+group_name+"</option>");
}
%>
</select>
</div>


<br>
<input type="image" src="save.png"   width="100" height="60">
</form>
<form method="post" action="a.jsp">
<input type="image" src="delete.png"  width="100" height="60">
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
