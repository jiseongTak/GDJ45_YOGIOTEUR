<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	@font-face {
		font-family: 'MICEMyungjo';
		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
		font-weight: normal;
		font-style: normal;
	}
	.index > a, h3 {
		font-family: 'MICEMyungjo';
	}
</style>
<link rel="stylesheet" href="../resources/css/admin.css">
<link rel="stylesheet" href="../resources/css/header.css">
<link rel="stylesheet" href="../resources/css/footer.css">
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<div class="grid_item index">
			<h3>관리자 메뉴</h3><br>
			<a href="${contextPath}/admin/member">회원목록</a>
			<br><br><br><br><br>
			<a href="${contextPath}/admin/reservationList">예약목록</a>
			<br><br><br><br><br>
			<a href="${contextPath}/admin/room">객실목록</a><br><br><br>
			<a href="${contextPath}/admin/addRoomPage">객실등록</a><br><br><br>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	
</body>
</html>