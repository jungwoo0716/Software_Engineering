<!-- 프로그램 로그인 페이지 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>로그인</title>
</head>
<body>
	<div class="container">
		<div class="col-xl-4">
			<div class="jumbotron" style="margin-top: 20px; padding-top: 20px;">
				<div class="form-group">
					<form>
					
						아이디  <input class="form-control" type="text" id="userid" name="userid" size=10>
						<br> 패스워드 <input class="form-control" type="password" id="passwd" name="passwd"
							size=10> <br> <input class="form-control" type="button" name="login"
							value="로그인" onclick="loginChk();"> <input class="form-control" type="button"
							name="newaccount" value="회원가입"
							onclick="goReplace('./NewAccount.jsp')">
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
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

	// 로그인 메소드. 입력값이 모두 있는지, 비밀번호는 일치하는지 확인한다.
	function loginChk() {
		var id = document.getElementById("userid").value;
		var pw = document.getElementById("passwd").value;
		console.log(pw);

		if (id == "" || pw == "") {
			alert("아이디와 비밀번호를 모두 입력해주세요!!");
			return;
		}

		var accountDB = database.ref("account/" + id);
		accountDB.once("value").then(function(snapshot) {
			console.log(snapshot.val().password);
			var tmp = snapshot.val().password
			if (pw == tmp) {
				alert("로그인 성공");
				if (id == "admin") { // 관리자인지 체크. 아이디는 admin, 비밀번호는 12345로 설정했음.
					location.href='adminMain.jsp';
				} else {
					doPost(id);	
				}
			} else {
				alert("로그인 실패");
			}
		});
	}

	// 로그인 정보를 POST로 박스오피스 페이지에게 보내는 메소드.
	function doPost(id) {
		var form = document.createElement("form");

		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "Post"); //Post 방식
		form.setAttribute("action", "Boxoffice.jsp"); //요청 보낼 주소

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "userid");
		hiddenField.setAttribute("value", id);
		form.appendChild(hiddenField);

		document.body.appendChild(form);
		form.submit();
	}

	// 회원가입으로 이동하는 메소드.
	function goReplace(str) {
		location.replace(str);
	}
</script>
</html>