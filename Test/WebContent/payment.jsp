<!-- 영화 결제 페이지. 선택한 영화를 확인하고 신용카드 결제로 넘어갈 수 있다. -->

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
<title>결제 페이지</title>
</head>
<body>
	<div class="jumbotron text-center">
		<h1>결제하기</h1>
	</div>

	<div class="container text-center">
		<h2>결제수단선택</h2>
		<h2>영화 : <%=request.getParameter("title")%></h2>
		<h2>상영일 : <%=request.getParameter("date")%></h2>
		<h2>상영시간 : <%=request.getParameter("time")%></h2>
		<h2>가격 : 10,000원</h2>
	</div>
	<!--결제 수단 선택-->
	<div class="container mt-3">
		<div class="custom-control custom-checkbox mb-3">
			<input type="checkbox" class="custom-control-input" id="customCheck" onclick="goCredit()"
				name="example1"> <label class="custom-control-label"
				for="customCheck">일반 신용카드</label>
		</div>
		</div>
	</div>

	<button type="button" class="btn btn-secondary btn-lg"
		onclick="location.href='Boxoffice.jsp'">취소하기</button>
</body>
<script>

	var title = "<%=request.getParameter("title")%>";
	var date = "<%=request.getParameter("date")%>";
	var time = "<%=request.getParameter("time")%>";
	
	// 신용카드 결제를 선택하면 선택한 영화의 저목, 날짜, 시간을 POST로 신용카드 결제 페이지에 넘긴다.
	function goCredit() {
		var form = document.createElement("form");

        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");  
        form.setAttribute("action", "creditPayment.jsp"); 

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