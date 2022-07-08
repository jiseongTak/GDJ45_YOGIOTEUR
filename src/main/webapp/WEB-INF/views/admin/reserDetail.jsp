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
	
</style>
</head>
<body>
	
    <form>
        예약번호: ${reservation.reserNo}<br>
        객실번호: ${room.roomNo}<br>
        체크인: ${reservation.reserCheckIn}<br>
        체크아웃: ${reservation.reserCheckOut}<br>
        예약자 이름: ${member.memberName}<br>
        예약자 아이디: ${member.memberId}<br>
        예약자 전화번호: ${member.memberPhone}<br>
        <input type="button" id="btnRemove" value="예약 내역 삭제">
        <input type="button" id="close" value="닫기">
    </form>
	
</body>
</html>