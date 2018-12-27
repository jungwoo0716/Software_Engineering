<!-- 회원 상세정보를 조회하는 페이지. 이름을 클릭하면 회원 상세정보 페이지로 넘어감 -->

<%@ page contentType="text/html;charset=utf-8"%>
<%
	request.getParameter("name");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<title>회원 상세 정보</title>
</head>
<body>

	<h2 align="center">[회원관리]-회원관리페이지</h2>
	<div class="card text-center">
		<div class="card-header">
			<ul class="nav nav-tabs card-header-tabs">
				<li class="nav-item">
					<a class="nav-link active" href="member_list.jsp">회원관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="movieAdminMain.jsp">상영관리</a>
				</li>
			</ul>
		</div>
	</div>

	<br>
	<br>

	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">회원정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">아이디</th>
					<td><%=request.getParameter("userid")%></td>
				</tr>
				<tr>
					<th scope="row">비밀번호</th>
					<td id="pw">잘못된 접근입니다.</td>
				</tr>
				<tr>
					<th scope="row">전화번호</th>
					<td id="pnum">잘못된 접근입니다.</td>
				</tr>
				<tr>
					<th scope="row">이름</th>
					<td id="uname">잘못된 접근입니다.</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script>
	// 데이터베이스 선언
	var config = {
		apiKey : "AIzaSyAb_FNQhZ6z9J07-S2r8_laDmAJn1Sxvs8",
		authDomain : "webtest-7943e.firebaseapp.com",
		databaseURL : "https://webtest-7943e.firebaseio.com",
		projectId : "webtest-7943e",
		storageBucket : "webtest-7943e.appspot.com",
		messagingSenderId : "374624484303"
	};
	
	firebase.initializeApp(config);
	var database = firebase.database();
	
	// 방금 선택한 아이디를 POST 방식으로 받아옴
	var id = "<%=request.getParameter("userid")%>";
	
	// DB에 아이디를 키로 사용해 사용자 정보를 받아오고 화면에 표시하는 메소드.
	var accountDB = database.ref("account/"+id);
	accountDB.once("value").then(function (snapshot) {
		var pw = document.getElementById("pw");
		var pnum = document.getElementById("pnum");
		var uname = document.getElementById("uname");
		pw.innerHTML = snapshot.val().password;
		pnum.innerHTML = snapshot.val().phonenumber;
		uname.innerHTML = snapshot.val().name;
  	});
</script>
</html>
