<!-- 영화 상영관리 페이지. 당일 상영정보 조회, 추가와 삭제를 할 수 있다. -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>상영관리 페이지</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<a class="navbar-brand" href="adminMain.jsp">관리자 페이지</a>
		</div>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="member_list.jsp">회원관리</a></li>
				<li class="active"><a href="movieAdminMain.jsp">상영관리</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table id="mtable" class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">상영일</th>
						<th style="background-color: #eeeeee; text-align: center;">영화</th>
						<th style="background-color: #eeeeee; text-align: center;">상영시간</th>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;"></th>
					</tr>
				</thead>
			</table>
			<button type="button" class="btn btn-primary btn-lg btn-block" onclick="movieEnrollBtn()">등록</button>
		</div>
	</div>
	
</body>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
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
	
	// 오늘 날짜를 yyyyDDmm 형식으로 받아온다
	var today = new Date().toISOString().slice(0,10);
	
	// DB에서 오늘 날짜 기준 상영정보를 조회하고, addRow 메소드를 실행한다.
	var schDB = database.ref("schedule/"+today).orderByKey();
	schDB.once("value").then(function (snapshot) {
  		snapshot.forEach(function(childSnapshot) {
  			var key = childSnapshot.key;
			var time = childSnapshot.val().time+"시";
			var title = childSnapshot.val().title;
			var date = today;
			addRow(time, title, date, key);
    	});
  	});
	
	// DB에서 받아온 영화제목, 상영시간, 상영일을 table에 한 줄씩 넣는다.
	// 키 값은 DB에 키로 저장되는 값으로 삭제에 사용한다.
	function addRow(time, title, date, key) {

		var table = document.getElementById("mtable");

		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);

		var cell1 = row.insertCell(0);
		var element1 = document.createElement("td");
		element1.innerHTML = date;
		cell1.appendChild(element1);

		var cell2 = row.insertCell(1);
		var element2 = document.createElement("td");
		element2.innerHTML = title;
		cell2.appendChild(element2);
		
		var cell3 = row.insertCell(2);
		var element3 = document.createElement("td");
		element3.innerHTML = time;
		cell3.appendChild(element3);
		
		var cell4 = row.insertCell(3);
		var element4 = document.createElement("button");
		element4.className = "btn btn-danger";
		element4.id = key;
		element4.onclick = function(){movieDeleteBtn(this.id)};
		element4.innerHTML = "삭제";
		cell4.appendChild(element4);
		
		var cell5 = row.insertCell(4);
		var element5 = document.createElement("button");
		element5.className = "btn btn-success";
		element4.id = key;
		element5.onclick = function(){movieModifyBtn(this.id)};
		element5.innerHTML = "수정";
		cell5.appendChild(element5);
	}
	
	// 선택한 상영정보를 삭제하는 메소드.
	function movieDeleteBtn(id) {
		var chk = confirm("삭제하시겠습니까?");
		if(chk) {
			database.ref("schedule/"+today).child(id).remove();
			alert('삭제되었습니다.');
			location.reload();
		} else {
			alert('취소되었습니다.');
		}
	}
		
	// 상영 정보 추가창을 띄우는 메소드
	function movieEnrollBtn() {
		window.open("movieEnroll.jsp", "상영정보 등록", "width=900, height=250, left=300, top=300");
	}
	
	// 수정은 구현하지 못했습니다.
	function movieModifyBtn(id) {
		alert('수정은 불가합니다...');
	}
	
</script>
</html>