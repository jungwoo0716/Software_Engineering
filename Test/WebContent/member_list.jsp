<!-- 회원 목록을 조회하는 페이지 -->

<%@ page contentType="text/html;charset=utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원 관리</title>
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
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

		<table class="table table-hover" id="atable">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">아이디</th>
					<th scope="col"></th>
				</tr>
			</thead>		
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

	// DB에서 저장된 회원 목록을 받아오고, addRow 메소드를 실행한다.
	var accountDB = database.ref("account").orderByKey();
	accountDB.once("value").then(function (snapshot) {
		var i = 1;
  		snapshot.forEach(function(childSnapshot) {
  			var id = childSnapshot.key;
			addRow(id, i);
			i++;
    	});
  	});
	
	// DB에서 저장된 아이디를 table에 한 줄씩 넣으면서 화면에 표시하는 메소드.
	function addRow (id, number) {

		var table = document.getElementById("atable");

		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);

		var cell1 = row.insertCell(0);
		var element1 = document.createElement("td");
		element1.innerHTML = number;
		cell1.appendChild(element1);

		var cell2 = row.insertCell(1);
		var element2 = document.createElement("td");
		element2.id = id;
		element2.innerHTML = id;
		element2.onclick = function(){getDetail(this.id)};
		cell2.appendChild(element2);
		
		var cell3 = row.insertCell(2);
		var element3 = document.createElement("button");
		element3.className = "btn btn-danger";
		element3.id = id;
		element3.onclick = function(){deleteBtn(this.id)};
		element3.innerHTML = "삭제";
		cell3.appendChild(element3);
	}
	
	// 삭제 버튼 클릭시, DB에서 삭제하고 화면을 새로고침 한다.
	function deleteBtn(id) {
		var chk = confirm("삭제하시겠습니까?");
		if(chk) {
			database.ref("account").child(id).remove();
			alert('삭제되었습니다.');
			location.reload();
		} else {
			alert('취소되었습니다.');
		}
	}
	
	// 아이디 클릭시 회원 상세페이지로 이동한다. 이동하면서 선택한 아이디를 POST로 전달한다.
	function getDetail(id) {

		var form = document.createElement("form");

        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post"); 
        form.setAttribute("action", "member_detail.jsp"); 

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "userid");
        hiddenField.setAttribute("value", id);
        form.appendChild(hiddenField);

        document.body.appendChild(form);
        form.submit();
	}
</script>
</html>
