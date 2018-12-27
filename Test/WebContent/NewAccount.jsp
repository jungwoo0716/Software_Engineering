<!-- 프로그램에 회원가입하는 페이지 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>회원가입</title>
</head>
<body>
	<div class="container">
		<div class="col-xl-4">
			<div class="jumbotron" style="margin-top: 20px; padding-top: 20px;">
				<div class="form-group">
	<form>
		아이디  <input class="form-control" type="text" id="userid" name="userid" size=10> <br>
		패스워드 <input class="form-control" type="password" id="passwd" name="passwd" size=10> <br>
		패스워드 확인 <input class="form-control" type="password" id="passwdchk"name="passwdchk" size=10> <br> 
		전화번호 <input class="form-control" type="tel" id="phone" name="phone" size=10> <br>
		이름  <input class="form-control" type="text" id="username" name="username" size=10> <br> 
		<input class="form-control" type="button" name="login" value="회원가입" onclick="makeNewAcc();">
		<input class="form-control" type="button" onclick="goReplace('./Login.jsp')" value="취소"/>
	</form>
	</div>
	</div>
	</div>
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
	
	// 회원가입 버튼 클릭시 실행하는 메소드
	function makeNewAcc() {
		var id = document.getElementById("userid").value;
		var pw = document.getElementById("passwd").value;
		var pwChk = document.getElementById("passwdchk").value;
		var pNum = document.getElementById("phone").value;
		var name = document.getElementById("username").value;
		
		// 모든 정보가 입력 되었는지 확인한다.
		if (id == "" || pw == "" || pwChk == "" || pNum == "" || name == "") {
			alert("필요한 정보를 모두 입력해 주세요!!")
			return;
		}
		
		// 비밀번호와 비밀번호 확인이 일치하는지 확인한다.
		if (!(pw == pwChk)) {
			alert("비밀번호화 비밀번호 확인이 다릅니다.")
			return;
		}
		
		var accountDB = database.ref("account/"+id);
		accountDB.once("value").then(function (snapshot) {
			// DB에 동일한 아이디가 존재하는지 확인한다.
			if (snapshot.hasChild("password") == true) {
				alert("이미 존재하는 아이디 입니다.");
				return;
			} else {
				// 일치하는 아이디가 없으면 회원가입을 완료하고 로그인 페이지로 돌아간다.
				database.ref("account/"+id).set({
					password : pw,
					phonenumber : pNum,
					name : name
				});
				alert("회원가입이 완료 되었습니다.");
				goReplace('./Login.jsp');
			}
		});	
	}
	
	// 로그인 페이지로 돌아가는 메소드.
	function goReplace(str) {
		location.replace(str);
	}

</script>
</html>