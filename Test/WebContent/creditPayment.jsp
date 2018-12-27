<!-- 카드 결제 페이지. -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<title>신용카드결제 페이</title>
</head>
<body>
	<div class="container">
		<div class="col-xl-4"></div>
		<div class="col-xl-4">
			<div class="jumbotron" style="margin-top: 20px; padding-top: 20px;">
				<form method="post" action="">
					<h3 style="text-align: center;">신용카드</h3>
					<div class="form-group">
						<label for="cardnumber"> 카드번호 </label> <input type="text"
							class="form-control" placeholder="카드번호" name="cardnumber"
							maxlength='20'>
					</div>
					<div class="form-group">
						<label for="validate"> 유효기간 </label> <input type="text"
							class="form-control" placeholder="유효기간" name="validate"
							maxlength='20'>
					</div>
					<div class="form-group">
						<label for="password"> 비밀번호 </label> <input type="password"
							class="form-control" placeholder="비밀번호" name="password"
							maxlength='20'>
					</div>
					<div class="form-group">
						<label for="birthday"> 생년월일 </label> <input type="text"
							class="form-control" placeholder="생년월일" name="birthday"
							maxlength='20'>
					</div>
					<div>
						<button type="button" class="btn btn=primary form-control"
							onclick="payComplete()">결제하기</button>
						<button type="button" class="btn btn=primary form-control"
							onclick="location.href='Boxoffice.jsp'">취소</button>
					</div>
				</form>
			</div>
		</div>
		<div class="col-xl-4"></div>
	</div>
</body>
<script>
	
	// 입력한 값을 따로 확인 없이 POST로 예매 확인 페이지에게 넘긴다
	var title = "<%=request.getParameter("title")%>";
	var date = "<%=request.getParameter("date")%>";
	var time = "<%=request.getParameter("time")%>";
	
	function payComplete() {
		var form = document.createElement("form");

        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  
        form.setAttribute("action", "ticketingDetail.jsp"); 

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
