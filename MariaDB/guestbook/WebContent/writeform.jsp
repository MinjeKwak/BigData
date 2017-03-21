<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>방명록 쓰기</h1>
<form action="write.jsp" method="post">
<table width="600" border="1">
<tr>
	<th>이름</th>
	<td><input type="text" name="name"></td>
</tr>
<tr>
	<th>제목</th>
	<td><input type="text" name="title"></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea name="content" rows="5" cols="30"></textarea></td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="저장">
		<input type="reset" value="취소">
	</td>
</tr>
</table>
</form>
</body>
</html>



