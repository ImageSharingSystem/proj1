<%
	try{
        conn.close();
    }
    catch(Exception ex){
    	out.println("<hr>" + ex.getMessage() + "<hr>");
    }
%>