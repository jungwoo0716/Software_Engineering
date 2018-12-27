<!-- 영화 상영정보를 추가하는 팝업 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>상영정보 등록창</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<form action="#">
				<table class="table"
					style="text-align: center; border: 1px solid #dddddd; margin-top: 30px;">
					<tbody>
						<tr>
							<th colspan="2"
								style="background-color: #99b3ff; text-align: center;">상영정보
								등록</th>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">상영일</th>
							<td><input id="date" type="date" value="movieDate"></td>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">상영작</th>
							<td><select id="browsers">

								</select></td>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">상영시간</th>
							<td><select id="time" class="custom-select" name="movieTime">
									<option selected>- - - - -상영시간- - - - -</option>
									<option value="8">8:00</option>
									<option value="10">10:00</option>
									<option value="12">12:00</option>
									<option value="14">14:00</option>
									<option value="16">16:00</option>
							</select></td>
						</tr>
					</tbody>
				</table>
				<div style="text-align: center;">
					<button type="submit" class="btn btn-primary"
						onclick="enrollConfirmbtn()">등록</button>
					<button type="button" class="btn btn-danger"
						onclick="enrollCancelbtn()">취소</button>
				</div>
			</form>
		</div>
	</div>

	
</body>
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

		// 상영정보를 추가할 영화를 DB에서 가져와 select의 옵선으로 추가한다.		
		var list = document.getElementById('browsers');
		var movieDB = database.ref("movie").orderByKey();
		movieDB.once("value").then(function(snapshot) {
			snapshot.forEach(function(childSnapshot) {
				var key = childSnapshot.key;
				var option = document.createElement('option');
				option.value = key;
				option.innerHTML = key;
				list.appendChild(option);
			});
		});
		
		// 확인 버튼을 선택시 DB에 저장하는 메소드.
		function enrollConfirmbtn() {
			var Date = document.getElementById("date").value + "";
			var Name = document.getElementById("browsers").value + "";
			var Time = document.getElementById("time");
			var selectTime = Time.options[Time.selectedIndex].value;
			
			database.ref("schedule").child(Date).push({
				time : selectTime,
				title : Name
			});
			alert("등록 되었습니다.");
			self.close();
		}
	</script>
</html>