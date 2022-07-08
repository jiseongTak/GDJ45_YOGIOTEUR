<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 정보</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

	$(function() {
		closeWindow();
		fnRemoveReser();
		
	})
	
	function closeWindow() {
		$('#close').on('click', function() {
			window.close();
		})
	}
	
	function fnRemoveReser() {
		$('#btnRemove').on('click', function() {
			if(confirm('선택하신 예약을 삭제하시겠습니까?')) {
				$.ajax({
					url: '${contextPath}/admin/removeReser',
					data: 'reserNo=' + ${reservation.reserNo},
					type: 'GET',
					dataType: 'json',
					success: function(obj) {
						if(obj.res == '1') {
							alert('예약이 삭제 되었습니다.');
							opener.parent.location.reload();
							window.close();
						} else if(obj.res == '0') {
							alert('예약이 삭제되지 않았습니다.');
						}
					}
				})
			}
		})
	}
	
</script>
<style type="text/css">
	.item {
		border: 1px solid;
		margin: 10% 15%;
		padding: 20px;
	}
	h3 {
		text-align: center;
	}
	.btn {
		text-align: center;
	}
</style>
</head>
<body>
	
   	<div class="item">
   		<h3>예약 내역</h3>
		예약번호: ${reservation.reserNo}<br><br>
		객실번호: ${room.roomNo}<br><br>
		체크인: ${reservation.reserCheckIn}<br><br>
		체크아웃: ${reservation.reserCheckOut}<br><br>
		예약자 이름: ${member.memberName}<br><br>
		예약자 아이디: ${member.memberId}<br><br>
		예약자 전화번호: ${member.memberPhone}<br><br>
		<div class="btn">
			<input type="button" id="btnRemove" value="예약 삭제">
			<input type="button" id="close" value="닫기">
		</div>
	</div>
		
</body>
</html>