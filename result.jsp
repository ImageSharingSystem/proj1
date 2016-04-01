<html>
<head>
</head>
<body>

<%@ include file="connectdb.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%	
	String usr = request.getParameter("usr");
	String sub = request.getParameter("sub");
	String startD = request.getParameter("start");
	String endD = request.getParameter("end");
	String itv = request.getParameter("itv");
	String tall = request.getParameter("tall");
	java.sql.Date startT = null;
	java.sql.Date endT = null;
	String sql="";
	PreparedStatement s;
	ResultSet r = null;
	Statement stmt = conn.createStatement();
	ResultSet rset = null;
	int incre;
	
	s = conn.prepareStatement("select timing from tmpT order by timing asc");
	try{
	r = s.executeQuery(); }catch(SQLException e){   out.println("SQLException: " +
      e.getMessage());}
	if(r.next()){ startT = r.getDate(1); endT = startT;}
	while(r.next()){
		endT = r.getDate(1);
	}
	if(itv.equals("weekly")){incre =7;}
	else if(itv.equals("monthly")){incre =30;}
	else{incre =365;}
	if((startD.equals("")) && (endD.equals("")) && tall.equals("no")){
		// the period is not specified, itv will not be used
		if(usr.equals("ALL")){
			if(sub.equals("ALL")){sql = "select sum(imgNo), owner_name, subject from tmpT group by owner_name, subject";}
			else if(sub.equals("")){sql = "select sum(imgNo), owner_name from tmpT group by owner_name";}
			else{ sql = "select sum(imgNo), owner_name from tmpT where subject = '"+sub+"' group by owner_name";}
		//	out.println(sql);
			try{
				rset = stmt.executeQuery(sql);}catch(SQLException e){ out.println("SQLException: " +
     			 e.getMessage());}
			while(rset.next()){
				%></br><%
				if(sub.equals("ALL")){
					out.println("User         Subject            Count");
					%> </br> <%
					out.println(rset.getString(2) + ":   "+ rset.getString(3) + ":   " + rset.getInt(1) );}
				else{
					out.println("User         Count");
					%> </br> <%
					out.println(rset.getString(2) + ":   " + rset.getInt(1) );}
			}
		}else if(usr.equals("")){
			if(sub.equals("ALL")){sql = "select sum(imgNo), subject from tmpT group by subject";}
			else if(sub.equals("")){sql = "select sum(imgNo) from tmpT";}
			else{ sql = "select sum(imgNo) from tmpT where subject = '"+sub+"'";}
		//	out.println(sql);
			try{
				rset = stmt.executeQuery(sql);}catch(SQLException e){ out.println("SQLException: " +
     			 e.getMessage());}
			while(rset.next()){
				%></br><%
				if(sub.equals("ALL")){
					out.println("Subject            Count");
					%> </br> <%
					out.println(rset.getString(2) + ":   " + rset.getInt(1) );}
				else{
					out.println("Count");
					%> </br> <%
					out.println(rset.getInt(1));}
			}
		}else{
			if(sub.equals("ALL")){sql = "select sum(imgNo), subject from tmpT where owner_name = '"+usr+"' group by subject";}
			else if(sub.equals("")){sql = "select sum(imgNo) from tmpT where owner_name = '"+usr+"'";}
			else{ sql = "select sum(imgNo) from tmpT where owner_name = '"+usr+"' AND subject = '"+sub+"'";}
		//	out.println(sql);
			try{
				rset = stmt.executeQuery(sql);}catch(SQLException e){ out.println("SQLException: " +
     			 e.getMessage());}
			while(rset.next()){
				%></br><%
				if(sub.equals("ALL")){
					out.println("Subject            Count");
					%> </br> <%
					out.println(rset.getString(2) + ":   " + rset.getInt(1) );}
				else{
					out.println("Count");
					%> </br> <%
					out.println(rset.getInt(1) );}
			}
		}
		
	}else{
		// the period is specified 
		if(!tall.equals("ALL")){
			if(!startD.equals("")){
		      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	       	  java.util.Date parsed = format.parse(startD);
	       	  startT = new java.sql.Date(parsed.getTime());
	       	 // out.println(startD); 
			}
			if(!endD.equals("")){
  			  SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
	       	  java.util.Date parsed2 = format2.parse(endD);
	       	  endT = new java.sql.Date(parsed2.getTime());
			 // out.println(endD);
			}
		}
		java.sql.Date fromT = startT;
		Calendar c = Calendar.getInstance(); 
		Calendar d = Calendar.getInstance(); 
		c.setTime(fromT); 
		d.setTime(endT);
		c.add(Calendar.DATE, incre-1);
		d.add(Calendar.DATE, 1);
		java.sql.Date toT= new java.sql.Date(c.getTimeInMillis());
		endT= new java.sql.Date(d.getTimeInMillis());
		while(toT.before(endT)){
			out.println(fromT.toString());
			out.println(toT.toString());
			%> </br><%
			if(usr.equals("ALL")){
				if(sub.equals("ALL")){sql = "select sum(imgNo), owner_name, subject from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd') group by owner_name, subject";}
				else if(sub.equals("")){sql = "select sum(imgNo), owner_name from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd') group by owner_name";}
				else{ sql = "select sum(imgNo), owner_name from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd') AND subject = '"+sub+"' group by owner_name";}
	//			out.println(sql);
				try{
					rset = stmt.executeQuery(sql);}catch(SQLException e){ out.println("SQLException: " +
	     			 e.getMessage());}
				while(rset.next()){
					%></br><%
					if(sub.equals("ALL")){
						out.println("User         Subject            Count");
						%> </br> <%
						out.println(rset.getString(2) + ":   "+ rset.getString(3) + ":   " + rset.getInt(1) );}
					else{
						out.println("User         Count");
						%> </br> <%
						out.println(rset.getString(2) + ":   " + rset.getInt(1) );}
				}
			}else if(usr.equals("")){
				if(sub.equals("ALL")){sql = "select sum(imgNo), subject from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd') group by subject";}
				else if(sub.equals("")){sql = "select sum(imgNo) from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd')";}
				else{ sql = "select sum(imgNo) from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd') AND subject = '"+sub+"'";}
		//		out.println(sql);
				try{
					rset = stmt.executeQuery(sql);}catch(SQLException e){ out.println("SQLException: " +
	     			 e.getMessage());}
				while(rset.next()){
					%></br><%
					if(sub.equals("ALL")){
						out.println("Subject            Count");
						%> </br> <%
						out.println(rset.getString(2) + ":   " + rset.getInt(1) );}
					else{
						out.println("Count");
						%> </br> <%
						out.println(rset.getInt(1));}
						
				}
			}else{
				if(sub.equals("ALL")){sql = "select sum(imgNo), subject from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd') AND owner_name = '"+usr+"' group by subject";}
				else if(sub.equals("")){sql = "select sum(imgNo) from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd') AND owner_name = '"+usr+"'";}
				else{ sql = "select sum(imgNo) from tmpT where timing BETWEEN TO_DATE ('"+fromT+"', 'yyyy-mm-dd') AND TO_DATE ('"+toT+"', 'yyyy-mm-dd') AND owner_name = '"+usr+"' AND subject = '"+sub+"'";}
		//		out.println(sql);
				try{
					rset = stmt.executeQuery(sql);}catch(SQLException e){ out.println("SQLException: " +
	     			 e.getMessage());}
				while(rset.next()){
					%></br><%
					if(sub.equals("ALL")){
						out.println("Subject            Count");
						%> </br> <%
						out.println(rset.getString(2) + ":   " + rset.getInt(1) );}
					else{
						out.println("Count");
						%> </br> <%
						out.println(rset.getInt(1) );}
				}
			}
			//increment time
			c.add(Calendar.DATE, 1);
			fromT = new java.sql.Date(c.getTimeInMillis());
			c.add(Calendar.DATE, incre-1);
			toT = new java.sql.Date(c.getTimeInMillis());
			
		
			%> </br> </br><%
		}
	}
%>



</body>
<%@ include file="closedb.jsp" %>


</html>
