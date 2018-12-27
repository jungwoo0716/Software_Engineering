<!-- 영화진흥위원회 API에서 일별 박스오피스와 영화정보를 가져오고, DB에 넣는 JSP. 프로그램 중에는 실행하지 않는다. -->

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!-- 필요한 빈즈 두 개를 선언함  -->
<jsp:useBean id="movieInit" class="bean.MovieInit" scope="page"/>
<jsp:useBean id="movieDetail" class="bean.getMovieDetail" scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% 
		// movieInit은 일별 박스오피스를 받아오는 API를 실행하는 빈즈
		movieInit.connectApi();
		// 박스오피스 1위부터 6위까지 정보를 String array에 담는다.
		String[] boxOffice = movieInit.getResultAry();
%>
</body>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script>
	// 파이어베이스 선언
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
	var clearMovieDB = database.ref("movie");
	clearMovieDB.remove();
	
	// 박스오피스 정보를 통해 영화 상세정보를 구하고, 구한 데이터를 DB에 넣는다.
	<%
    for(int i=0; i < 6; i++)
    {
    	// boxOffice엔 박스오피스순위#제목#개봉일 형식으로 String 배열이 있고
    	// #으로 스플릿 해 제목과 개봉일을 사용한다.
    	String[] tmp = boxOffice[i].split("#");
    	// 영화상세정보를 받아오는 API에 제목과 개봉일을 넣는다.
		movieDetail.connectApi(tmp[1], tmp[2]);
		%>
		alert("<%=tmp[1]%>");
		database.ref("movie/"+"<%=tmp[1]%>").set({
			rank : <%=i+1%>,
			poster : "<%=movieDetail.getPoster()%>",
			director : "<%=movieDetail.getDirector()%>",
			actor : "<%=movieDetail.getActor()%>",
			plot : "<%=movieDetail.getPlot()%>",
	        price : 10000
	    });
		<%
    }
    %>
	
</script>
</html>