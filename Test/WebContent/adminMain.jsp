<!-- 관리자 메인 페이지 JSP 회원관리와 상영관리로 갈 수 있음. -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>관리자 페이지</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<a class="navbar-brand" href="adminMain.jsp">관리자 페이지</a>
		</div>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="member_list.jsp">회원관리</a></li>
				<li><a href="movieAdminMain.jsp">상영관리</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">

	</div>
</body>
</html>