<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

	<div class="head">
	
		<div class="header">
				<a href="${contextPath}/review/reviewList">REVIEW</a>
				<a href="${contextPath}/faq/faqList">FAQ</a>
		</div>
		
		<div class="title">
			<a href="http://localhost:9090/yogioteur/">YOGIOTEUR</a>
		</div>
		 
		<div class="header2">
			<!-- 로그인 이전 -->
			<c:if test="${loginMember eq null}">
				<a href ="${contextPath}/member/loginPage">로그인</a>
				<a href ="${contextPath}/member/agreePage">회원가입</a>	
			</c:if>
		
			<!-- 로그인 이후 -->
			<c:if test="${loginMember ne null}">
				${loginMember.memberName}님
				<a href ="${contextPath}/member/logout">로그아웃</a>
				<a href ="${contextPath}/member/memberPage">마이페이지</a>		
			</c:if>
			
			<c:if test="${loginMember ne null and loginMember.memberId eq 'admin12'}">
				<a href="${contextPath}/admin/adminPage">관리자페이지</a>
			</c:if>
		</div>
		
	</div>

</body>