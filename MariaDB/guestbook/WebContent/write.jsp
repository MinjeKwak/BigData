<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. 넘어오는 값들을 받는다.
	String name = request.getParameter("name");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 2. DB에 insert
	// JDBC 코딩 5단계 : 드라이버 로딩, 연결, 명령, 결과, 해제
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/mytestdb";
	Connection conn = DriverManager.getConnection(url, "root", "password");
	
	String sql = 
			"insert into mytest(name,title,content) values(?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, name);
	pstmt.setString(2, title);
	pstmt.setString(3, content);
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	// 3. list.jsp 로 이동
	response.sendRedirect("list.jsp");
%>



