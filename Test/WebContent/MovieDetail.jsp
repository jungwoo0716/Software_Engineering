<!-- 영화 상세정보를 조회하는 페이지. 예매페이지로 넘어갈 수 있다. -->

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>영화 상세 정보</title>
<script>
	// 무슨 영화를 선택했는지 request로 변수 선언한다.
	var titleKey = "<%=request.getParameter("title")%>";
</script>
</head>
<body>

  <header class="container">
    <div class="row">
      <div class="col-md-10 col-md-offset-1">
<h1 id="title"></h1>
</div>
</div>
</header>
  <div class="container">
    <div class="row">
    <div class="col-xs-12 col-md-4 col-md-offset-1">
감독 : <p id="director"></p>
배우 : <p id="actor"></p>
줄거리 : <p id="plot"></p>
    </div>
    <div class="col-xs-12 col-md-6">
<img id="poster" alt="포스터 정보가 없습니다."></img>
</div>
    </div>
    </div>

<button onclick="goTicket(titleKey)">영화 예매</button>
<button onclick="goReplace('./Boxoffice.jsp')">뒤로가기</button>

<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
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
	
	var poster = document.getElementById("poster");
	var title = document.getElementById("title");
	var director = document.getElementById("director");
	var actor = document.getElementById("actor");
	var plot = document.getElementById("plot");

	// DB에서 영화정보를 영화 제목을 통해 조회한다.
	var accountDB = database.ref("movie/"+titleKey);
    accountDB.once("value").then(function (snapshot) {
       title.innerHTML = titleKey;
       poster.src = snapshot.val().poster;
   	   director.innerHTML = snapshot.val().director;
   	   actor.innerHTML = snapshot.val().actor;
   	   plot.innerHTML = snapshot.val().plot;
    });
    
    // 예매하기 선택시 선택한 영화를 POST로 정보를 보낸다.
    function goTicket(titleKey) {

		var form = document.createElement("form");

        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  //Post 방식
        form.setAttribute("action", "ticketing.jsp"); //요청 보낼 주소

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "title");
        hiddenField.setAttribute("value", titleKey);
        form.appendChild(hiddenField);

        document.body.appendChild(form);
        form.submit();
	}
    
    // 박스오피스로 돌아가는 메소드.
    function goReplace(str) {
		location.replace(str);
	}
</script>
</body>
</html>