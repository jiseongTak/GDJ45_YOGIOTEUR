<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>

	$(function(){
		fnReservationList();
	})
	
	function fnReservationList() {
		$.ajax({
			url: '${contextPath}/admin/memberReserList?memberNo=' + ${member.memberNo},
			type: 'GET',
			dataType: 'json',
			success: function(obj) {
				$('#items').empty();
				$.each(obj.reservation, function(i, reservation) {
					var tr = '<tr>';
					tr += '<td>' + reservation.reserNo + '</td>';
					tr += '<td>' + reservation.roomNo + '</td>';
					tr += '<td>' + reservation.reserCheckIn + '</td>';
					tr += '<td>' + reservation.reserCheckOut + '</td>';
					tr += '<td>' + reservation.reserPeople + '</td>';
					tr += '</tr>';
					$('#items').append(tr);
				})
			}
			
		})
	}
	
	// 타임스탬프 형식을 yyyy/MM/dd 로 반환
	function formatDate(date) {
	    var d = new Date(date),
	        month = '' + (d.getMonth() + 1),
	        day = '' + d.getDate(),
	        year = d.getFullYear();

	    if (month.length < 2) 
	        month = '0' + month;
	    if (day.length < 2) 
	        day = '0' + day;

	    return [year, month, day].join('/');
	}
	
</script>
<style type="text/css">
	table {
		margin: 0 auto;
	}
	.member {
		display: inline-block;
		box-sizing: border-box;
		margin: 0 auto;
	}
	ul {
	    display: flex;
	    align-content: flex-start;
	    flex-direction: column;
	    flex-wrap: wrap;
	    overflow: auto;
	}
	li {
		margin-bottom: 20px;
	}
</style>
<link rel="stylesheet" href="../resources/css/admin.css">
<link rel="stylesheet" href="../resources/css/header.css">
<link rel="stylesheet" href="../resources/css/footer.css">
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container">
		<jsp:include page="index.jsp"></jsp:include>
		
		<div class="grid_item member">
			<h3>회원상세</h3>
				<ul>
					<li>회원번호: ${member.memberNo}</li>
					<li>아이디: ${member.memberId}</li>
					<li>성명: ${member.memberName}</li>
					<li>이메일: ${member.memberEmail}</li>
					<li>연락처: ${member.memberPhone}</li>
					<li>주소: ${member.memberRoadAddr}</li>
					<li>가입일: ${member.signIn}</li>
				</ul>
			<hr><br>
			<table>
				<caption>예약 내역</caption>
				<thead>
					<tr>
						<td>예약번호</td>
						<td>객실번호</td>
						<td>체크인날짜</td>
						<td>체크아웃날짜</td>
						<td>인원수</td>
					</tr>
				</thead>
				<tbody id="items">
				</tbody>
			</table>
		</div>
		
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
	
</body>
</html>