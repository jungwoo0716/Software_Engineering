<!-- 일별 박스오피스 표시 페이지. 포스터를 클릭하면 상세정보로 넘어간다. -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	session.setAttribute("account", request.getParameter("userid"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>영화 박스오피스 순위</title>
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<style>
p {
	text-align: center;
	font-size:3rem;
}
</style>
</head>

<body>
	<div class="container">
		<div class="jumbotron text-center">
			<h1>영화 박스 오피스 순위</h1>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="thumbnail">
					<img alt="포스터 정보가 없습니다"></img>
					<div class="caption">
						<p>1위 :</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="thumbnail">
					<img alt="포스터 정보가 없습니다"></img>
					<div class="caption">
						<p>2위 :</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="thumbnail">
					<img alt="포스터 정보가 없습니다"></img>
					<div class="caption">
						<p class="title" class="figure-caption">3위 :</p>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="thumbnail">
					<img alt="포스터 정보가 없습니다"></img>
					<div class="caption">
						<p>4위 :</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="thumbnail">
					<img alt="포스터 정보가 없습니다"></img>
					<div class="caption">
						<p>5위 :</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="thumbnail">
					<img alt="포스터 정보가 없습니다"></img>
					<div class="caption">
						<p>6위 :</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script>
	// 파이어베이스 선언
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

	// img 태그와 제목이 적힐 p태그를 querySelectorAll로 가져옴
	var img = document.querySelectorAll("img");
	var title = document.querySelectorAll("p");

	// moive 트리 아래있는 영화 정보를 rank 순으로 정렬해서 가져옴.
	var movieDB = database.ref("movie").orderByChild("rank");
	movieDB.once("value").then(
			function(snapshot) {
				var i = 0;
				// 제목과 포스터를 받아와서 화면에 표시한다.
				snapshot.forEach(function(childSnapshot) { 
					var key = childSnapshot.key;
					var rank = childSnapshot.val().rank;
					var poster = childSnapshot.val().poster;
					img[i].src = poster;
					title[i].innerHTML = (i + 1) + "위 : " + key;
					// 이미지 클릭시 영화 상세정보로 이동하며, GET방식으로 전달했다.
					img[i].addEventListener('click', function() {
						location.href = "./MovieDetail.jsp?title="
								+ encodeURI(key, "UTF-8");
					});
					i++;
				});
			});
</script>
</html>