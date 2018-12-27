<!-- 결제 완료 후, 다시 한 번 예매내역을 확인시켜주고 취소할 수 있는 예매확인 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>예매내역</title>
</head>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase.js"></script>
<body>
	<div class="jumbotron text-center">
		<h1>예매내역</h1>
	</div>

	<div class="container text-center">
		<h2>영화 : <%=request.getParameter("title")%></h2>
		<h2>상영일 : <%=request.getParameter("date")%></h2>
		<h2>상영시간 : <%=request.getParameter("time")%></h2>
		<h2>가격 : 10,000원</h2>
	</div>
		<button type="button" class="btn btn-secondary btn-lg"
		onclick="paySave()">확인</button>
		<!-- 취소 버튼 선택시 박스오피스로 돌아감 -->
			<button type="button" class="btn btn-secondary btn-lg"
		onclick="location.href='Boxoffice.jsp'">취소</button>
</body>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script>

	// 접속한 계정을 session으로 가져옴
	var account = "<%=session.getAttribute("account")%>";

	var title = "<%=request.getParameter("title")%>";
	var date = "<%=request.getParameter("date")%>";
	var time = "<%=request.getParameter("time")%>";

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
	
	// 확인버튼을 누르면 DB에 예매 내역을 저장하고, 박스오피스로 돌아간다.
	function paySave() {
		database.ref("payment/"+account).push({
	         title : title,
	         date : date,
	         time : time
	    });
		location.href="Boxoffice.jsp";
	}
</script>
</html>