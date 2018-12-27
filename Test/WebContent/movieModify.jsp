<!-- 미구현한 영화 상영 정보 팝업 -->

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
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #66cc66; text-align: center;">상영정보
								수정</th>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">상영일</th>
							<td><input type="date" value="movieDate"></td>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">상영작</th>
							<td><select class="custom-select" name="movieTitle">
									<option selected>수정선택영화제목</option>
									<option value="movie1">영화1</option>
									<option value="movie2">영화2</option>
									<option value="movie3">영화3</option>
							</select></td>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">상영시간</th>
							<td><select class="custom-select" name="movieTime">
									<option selected>수정선택상영시간</option>
									<option value="time1">8:00~10:30</option>
									<option value="time2">11:00~13:30</option>
									<option value="time3">14:00~16:30</option>
									<option value="time4">17:00~19:30</option>
									<option value="time5">20:00~22:30</option>
							</select></td>
						</tr>
					</thead>
				</table>
				<div style="text-align: center;">
					<button type="submit" class="btn btn-success"
						onclick="modifyConfirmbtn()">수정</button>
					<button type="button" class="btn btn-danger"
						onclick="modifyCancelbtn()">취소</button>
				</div>
			</form>
		</div>
	</div>
	<script
		src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
	<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
	<script>
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

		function enrollConfirmbtn() {
			var Date = document.getElementById("date").value + "";
			var Name = document.getElementById("browsers").value + "";
			var Time = document.getElementById("time");
			var selectTime = Time.options[Time.selectedIndex].value;
			
			database.ref("schedule").child(Date).push({
				time : selectTime,
				title : Name
			});
			alert("수정되었습니다.");
			self.close();
		}
		function modifyCancelbtn() {
			self.close();
		}
	</script>
</body>
</html>