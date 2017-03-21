<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="writeform.jsp">글 쓰기</a><br><br>
<%
	// 1. DB에서 select 해 온다.
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/mytestdb";
	Connection conn = DriverManager.getConnection(url, "root", "password");
	
	String sql = "select * from mytest order by no desc";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();
	
	//  2. 화면에 출력
	while(rs.next()) {
		out.println("<div>");
		out.println("<hr>");
		String name = rs.getString("name");
		String title = rs.getString("title");
		String content = rs.getString("content");
		out.println(name + " | " + title + " | " + content + "<br>");
		out.println("</div>");
	}
%>
</body>
</html>




