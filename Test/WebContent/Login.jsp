<!-- ���α׷� �α��� ������ -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>�α���</title>
</head>
<body>
	<div class="container">
		<div class="col-xl-4">
			<div class="jumbotron" style="margin-top: 20px; padding-top: 20px;">
				<div class="form-group">
					<form>
					
						���̵�  <input class="form-control" type="text" id="userid" name="userid" size=10>
						<br> �н����� <input class="form-control" type="password" id="passwd" name="passwd"
							size=10> <br> <input class="form-control" type="button" name="login"
							value="�α���" onclick="loginChk();"> <input class="form-control" type="button"
							name="newaccount" value="ȸ������"
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

	// �α��� �޼ҵ�. �Է°��� ��� �ִ���, ��й�ȣ�� ��ġ�ϴ��� Ȯ���Ѵ�.
	function loginChk() {
		var id = document.getElementById("userid").value;
		var pw = document.getElementById("passwd").value;
		console.log(pw);

		if (id == "" || pw == "") {
			alert("���̵�� ��й�ȣ�� ��� �Է����ּ���!!");
			return;
		}

		var accountDB = database.ref("account/" + id);
		accountDB.once("value").then(function(snapshot) {
			console.log(snapshot.val().password);
			var tmp = snapshot.val().password
			if (pw == tmp) {
				alert("�α��� ����");
				if (id == "admin") { // ���������� üũ. ���̵�� admin, ��й�ȣ�� 12345�� ��������.
					location.href='adminMain.jsp';
				} else {
					doPost(id);	
				}
			} else {
				alert("�α��� ����");
			}
		});
	}

	// �α��� ������ POST�� �ڽ����ǽ� ���������� ������ �޼ҵ�.
	function doPost(id) {
		var form = document.createElement("form");

		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "Post"); //Post ���
		form.setAttribute("action", "Boxoffice.jsp"); //��û ���� �ּ�

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "userid");
		hiddenField.setAttribute("value", id);
		form.appendChild(hiddenField);

		document.body.appendChild(form);
		form.submit();
	}

	// ȸ���������� �̵��ϴ� �޼ҵ�.
	function goReplace(str) {
		location.replace(str);
	}
</script>
</html>