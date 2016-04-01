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
String group_name = (request.getParameter("group_name")).trim();
int group_id = Integer.parseInt(request.getParameter("group_id"));
String friend_name = null;
if(request.getParameter("friend_name")!=null){
	friend_name = request.getParameter("friend_name").toString();
}
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
<title> Friend Page </title>
<div align="right">



<div class="left_part" style="float:left">
&ensp;<h3 style="color:white;font-size:2em"> <%=group_name%> </h3>
<div style="width:300px;height:605px;line-height:3em;overflow:scroll;padding:5px;">
<div align="center">
<%
Statement stmt = null;
ResultSet rset = null;
String sql = "select friend_name from group_lists where group_id ="+group_id;
try{
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
}
	
catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
%>
<form method="get" action="group.jsp">
<%
out.println("<input name='group_name' type='hidden' value='"+group_name+"'");
out.println("<input name='group_id' type='hidden' value='"+group_id+"'");
while(rset != null && rset.next()){
	out.println("<input type='submit' name='friend_name' value='"+rset.getString(1).trim()+"'style='width:250px;height:50px;font-size:2em;text-align:center'>");
	out.println("<br>");
}
%>
</form>
</div>
</div>

<form method="post" action="friend_add.jsp">
<input type="text"style="width:173px" name="add" placeholder="Add Friend.." />
&ensp;&ensp;<input type="submit" name="submit" value="Add" style="width:100px">
<input type="hidden" name="group_id" value=<%=group_id%>></input>
<input type="hidden" name="group_name" value=<%=group_name%>></input>
</form>
<form method="post" action="main.jsp">
<br>
<input type="image" src="back.jpg" style="padding-right:17em;width:5em" onclick="response.sendRedirct("main.jsp");"></input>
</form>
</div>
<div class="left_part" style="float:left">
<br><br>
<h1><font color = "white"> Friend </h1>
<div style="padding:6px; color: white; background-color: purple; border: yellow 2px solid; width:300px;height:600px">
<div style="text-align:left;font-size:1.5em">
First Name: <br><br>
Last Name: <br><br>
Phone:<br><br>
Email:<br><br>
</div>
<br><br><br>
<p style="padding:6px; color: black; background-color: lightblue; border: yellow 2px solid; width:200px;height:285px;padding-right:4em;padding-left:2em">
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;Group<br><br><br>

<select id="public">
<option value="" disabled="disabled" selected="selected">Please select one group</option>
<option name="choice1" value="default">   Default  </option>
<option name="choice2" value="family">  Family </option>
<option name="choice3" value="friends"> Friends </option>
<option name="choice4" value="lover"> Lover </option>
</select>
<br><br><br>
&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;<input type="submit" name="save" value="Save" style="height:50px; width:150px">
</form>
</div>
</div>

<h1 style=" color:white;padding-top:2em;padding-right:12em"> Friend's Photos </h1>


<div style="width:1000px;height:620px;line-height:3em;overflow:scroll;float:right">
<%
sql = "select photo_id from images where owner_name = '"+user_name+"'";
try{
	stmt = conn.createStatement();
	rset = stmt.executeQuery(sql);
}
	
catch(Exception ex){
	out.println("<hr>" + ex.getMessage() + "<hr>");
}
int pic_id;
out.println("<form method='get'  action=image.jsp>");
out.println("<input type='hidden' name='photo' value=0></input>");
while(rset != null && rset.next()){
	pic_id = rset.getInt(1);
%>
	<input type="image" src="GetOnePic?<%=pic_id%>" onclick="photo.value=<%=pic_id%>"style="height:220px;" ></a>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
<%
}
out.println("</form>");
%>
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

