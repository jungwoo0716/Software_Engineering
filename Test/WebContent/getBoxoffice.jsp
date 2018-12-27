<!-- ��ȭ��������ȸ API���� �Ϻ� �ڽ����ǽ��� ��ȭ������ ��������, DB�� �ִ� JSP. ���α׷� �߿��� �������� �ʴ´�. -->

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!-- �ʿ��� ���� �� ���� ������  -->
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
		// movieInit�� �Ϻ� �ڽ����ǽ��� �޾ƿ��� API�� �����ϴ� ����
		movieInit.connectApi();
		// �ڽ����ǽ� 1������ 6������ ������ String array�� ��´�.
		String[] boxOffice = movieInit.getResultAry();
%>
</body>
<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script>
	// ���̾�̽� ����
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
	
	// �ڽ����ǽ� ������ ���� ��ȭ �������� ���ϰ�, ���� �����͸� DB�� �ִ´�.
	<%
    for(int i=0; i < 6; i++)
    {
    	// boxOffice�� �ڽ����ǽ�����#����#������ �������� String �迭�� �ְ�
    	// #���� ���ø� �� ����� �������� ����Ѵ�.
    	String[] tmp = boxOffice[i].split("#");
    	// ��ȭ�������� �޾ƿ��� API�� ����� �������� �ִ´�.
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