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
String str1 = "<h3><input type='radio'  name='group' value=1 ";
String str2 = "<input type='radio' name='group' value=0 ";
String str3 = "<input type='radio'  name='group' value=-1 ";
String disable = " disabled='disabled' ";
if (permitted==1){
   str1+="checked ";
}
else 
{
if (permitted==0){
   str2+="checked ";
}else{
   str3+="checked ";
   disable = "" ;
}
}
%>
<%=str1%>onclick="option.disabled='true'">Private 
<%=str2%>onclick="option.disabled='true'"> Public
<%=str3%>onclick="option.removeAttribute('disabled')">Others</h3>

<div>
<select name="option" <%=disable%> onchange='this.value=this.options[this.selectedIndex].value;'>
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
	out.println("<option "+select+" value="+group_id+">"+group_name+"</option>");
}
%>
</select>
</div>


<br>
<input type="image" src="save.png"   width="100" height="60">
</form>
<form method="post" action="image_delete.jsp">
<input type="hidden" value=<%=photo_id%> name="photo_id"></input>
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
