<!-- 영화를 선택한 후에 넘어오는 예매페이지로, 상영일정을 고르고 예매하는 페이지. -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>예매하기</title>
</head>
<body>
	<div class="jumbotron text-center">
		<h1>예매하기</h1>
	</div>
	<div class="container text-center">
		<h2 id="title"></h2>
	</div>
	<div class="container text-center">
		<h3 id="totalPrice"></h3>
	</div>
	<table class="table table-striped" id="mtable">
		<thead>
			<tr>
				<th>상영일</th>
				<th>상영시간</th>
				<th>선택</th>
			</tr>
		</thead>
	</table>


	<!-- 결제하기  -->
	<div class="container center" style="width: 100%; height: 100%">
		<button type="button" class="btn btn-secondary btn-lg" onclick="location.href='payment.jsp'">결제하기</button>
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
	
	// 선택한 영화 제목을 request로 가져온다.
	var title ="<%=request.getParameter("title")%>"
	document.getElementById("title").innerHTML = title;
	
	// 오늘 날짜를 yyyyDDmm 형식으로 변수 생성
	var d = new Date().toISOString().slice(0,10);
	
	// 오늘 날짜에 저장된 상영 일정을 모두 불러오고, 그 중 선택한 영화제목과 일치하는 상영정보를 가져와 addRow를 실행한다.
	var schDB = database.ref("schedule").child(d);
	schDB.once("value").then(function (snapshot) {
		snapshot.forEach(function(childSnapshot) {		
			if (childSnapshot.val().title == title) {
				var time = childSnapshot.val().time+"시";
				addRow(time, d);	
			}
		})
  	});

	// 상영정보를 table에 한 줄 씩 추가하는 메소드.
	function addRow (time, date) {

		var table = document.getElementById("mtable");

		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);

		var cell1 = row.insertCell(0);
		var element1 = document.createElement("td");
		element1.innerHTML = date;
		cell1.appendChild(element1);

		var cell2 = row.insertCell(1);
		var element2 = document.createElement("td");
		element2.innerHTML = time;
		cell2.appendChild(element2);
		
		var cell3 = row.insertCell(2);
        var element3 = document.createElement("input");
        element3.onclick = function(){goPayment(time, date)};
        element3.type = "radio"
        cell3.appendChild(element3);
        
	}
	
	// 상영 일정을 고르면 결제 페이지로 넘어가는 메소드. POST방식으로 시간, 날짜, 제목을 보낸다.
	function goPayment(time, date) {
		var form = document.createElement("form");

        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  //Post 방식
        form.setAttribute("action", "payment.jsp"); //요청 보낼 주소

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "time");
        hiddenField.setAttribute("value", time);
        form.appendChild(hiddenField);

        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "date");
        hiddenField.setAttribute("value", date);
        form.appendChild(hiddenField);
        
        hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "title");
        hiddenField.setAttribute("value", title);
        form.appendChild(hiddenField);

        document.body.appendChild(form);
        form.submit();
	}

</script>
</html>