<!-- ���α׷��� ȸ�������ϴ� ������ -->

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>ȸ������</title>
</head>
<body>
	<div class="container">
		<div class="col-xl-4">
			<div class="jumbotron" style="margin-top: 20px; padding-top: 20px;">
				<div class="form-group">
	<form>
		���̵�  <input class="form-control" type="text" id="userid" name="userid" size=10> <br>
		�н����� <input class="form-control" type="password" id="passwd" name="passwd" size=10> <br>
		�н����� Ȯ�� <input class="form-control" type="password" id="passwdchk"name="passwdchk" size=10> <br> 
		��ȭ��ȣ <input class="form-control" type="tel" id="phone" name="phone" size=10> <br>
		�̸�  <input class="form-control" type="text" id="username" name="username" size=10> <br> 
		<input class="form-control" type="button" name="login" value="ȸ������" onclick="makeNewAcc();">
		<input class="form-control" type="button" onclick="goReplace('./Login.jsp')" value="���"/>
	</form>
	</div>
	</div>
	</div>
	</div>
	
</body>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script>
	// �����ͺ��̽� ����
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
	
	// ȸ������ ��ư Ŭ���� �����ϴ� �޼ҵ�
	function makeNewAcc() {
		var id = document.getElementById("userid").value;
		var pw = document.getElementById("passwd").value;
		var pwChk = document.getElementById("passwdchk").value;
		var pNum = document.getElementById("phone").value;
		var name = document.getElementById("username").value;
		
		// ��� ������ �Է� �Ǿ����� Ȯ���Ѵ�.
		if (id == "" || pw == "" || pwChk == "" || pNum == "" || name == "") {
			alert("�ʿ��� ������ ��� �Է��� �ּ���!!")
			return;
		}
		
		// ��й�ȣ�� ��й�ȣ Ȯ���� ��ġ�ϴ��� Ȯ���Ѵ�.
		if (!(pw == pwChk)) {
			alert("��й�ȣȭ ��й�ȣ Ȯ���� �ٸ��ϴ�.")
			return;
		}
		
		var accountDB = database.ref("account/"+id);
		accountDB.once("value").then(function (snapshot) {
			// DB�� ������ ���̵� �����ϴ��� Ȯ���Ѵ�.
			if (snapshot.hasChild("password") == true) {
				alert("�̹� �����ϴ� ���̵� �Դϴ�.");
				return;
			} else {
				// ��ġ�ϴ� ���̵� ������ ȸ�������� �Ϸ��ϰ� �α��� �������� ���ư���.
				database.ref("account/"+id).set({
					password : pw,
					phonenumber : pNum,
					name : name
				});
				alert("ȸ�������� �Ϸ� �Ǿ����ϴ�.");
				goReplace('./Login.jsp');
			}
		});	
	}
	
	// �α��� �������� ���ư��� �޼ҵ�.
	function goReplace(str) {
		location.replace(str);
	}

</script>
</html>