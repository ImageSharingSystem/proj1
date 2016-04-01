<html>
<head>
</head>
<body>

<%@ include file="connectdb.jsp" %>
<%	
	Statement s1 = conn.createStatement();
	Statement s2 = conn.createStatement();
	String sql1 = "drop view tmpT";
	String sql2 = "create view tmpT as select owner_name, subject, date_upload, count(*) as imgNo from images group by owner_name, subject, date_upload";
	
	s1.executeQuery(sql1);
	s2.executeQuery(sql2);
%>

<div style="background-image:url('blue.jpg');width:100%;height:100%;solid black;">
<html>
<title> Admin Page </title>
<div class="personal_info" align="right">
<h5> <font color = "white"> Name: Admin </h5>
</div>

<div class="OLAP" align="center">
<br><br>
<h1> OLAP Report</h1>
<div align="center" style="padding:6px; color: black; background-color: white; border: black 2px solid; width:500px;height:450px;">
<br>
<form method="get" action="result.jsp" align="center">
User: <input name="usr" type="text"><br><br>
Subject: <input name="sub" type="text"><br><br>
Start Date: <input name="start" type="date"><br><br>
End Date:  <input name="end" type="date"><br><br>
<input type="radio" name="tall" value="interval" checked ="checked"> Above dates <br>
<input type="radio" name="tall" value="all"> All dates </br>
</br>Time Interval:</br><br>
<input type="radio" name="itv" value="weekly" checked="checked"> weekly <br>
<input type="radio" name="itv" value="monthly"> monthly <br>
<input type="radio" name="itv" value="yearly" > yearly <br><br>
<input type="submit" value="Search" style="width:100px; height:50px">
</form>
</div>

<br><br><br><br><br><br>
<form method="post" action="main.jsp" name="send">
<input type="submit" name="back" value = "back" style="width:200px; height:100px" onclick = "send.action='main.jsp'">
</form>

</div>
<%@ include file="closedb.jsp" %>
</body>


</html>
