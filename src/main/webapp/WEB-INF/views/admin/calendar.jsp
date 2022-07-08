<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
<!-- <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"> -->
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js" integrity="sha256-6XMVI0zB8cRzfZjqKcD01PBsAy3FlDASrlC8SxCpInY=" crossorigin="anonymous"></script>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<link rel="stylesheet" href="../resources/css/header.css">
<link rel="stylesheet" href="../resources/css/footer.css">
<style>

	.container {
		display: flex;
		margin-top: 50px;
		margin-left: 10%;
		margin-right: 10%;
		margin-bottom: 5%;
	}
	
	.grid_item {
		text-align: center;
		width: 80%;
	}
	
	.table {
		display: inline-block;
	}
	
	.grid_item.index {
		text-align: center;
		width: 15%;
		background-color: silver;
		margin-right: 40px;
		font-size: 18px;
	}
	
	h3 {
		margin-bottom: 5px;
	}
	
	#calendar a {
		color: black;
	}
	
</style>
<script>

	// 페이지 로드 이벤트
	$(function(){
		// calendar element 취득
		var calendarEl = $('#calendar')[0];
		// full-calendar 생성하기
		var calendar = new FullCalendar.Calendar(calendarEl, {
			height: 'auto', // calendar 높이 설정
			expandRows: true, // 화면에 맞게 높이 재설정
			// 해더에 표시할 툴바
			headerToolbar: {
				left: 'prev,next today',
				center: 'title',
				right: 'dayGridMonth listWeek'
			},
			initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
			//initialDate: '2022-06-29', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
			navLinks: false, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
			editable: true, // 수정 가능?
			selectable: true, // 달력 일자 드래그 설정가능
			nowIndicator: true, // 현재 시간 마크
			dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
			locale: 'ko', // 한국어 설정
			//timeZone: 'Asia/Seoul',
			eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
			  console.log(obj);
			},
			
			// DB에 저장된 예약 정보들을 조회후 달력에 표시
			events: function(info, successCallback, failureCallback) {
				$.ajax({
					url: '${contextPath}/admin/reserList',
					type: 'GET',
					dataType: 'json',
					success: function(obj) {
						let arr = [];
						$.each(obj.reservations, function(i, reservation) {
							var status = reservation.reserStatus;
							arr.push({
								title: reservation.room.roomNo + '번 객실 ' + reservation.room.roomName
								, start: replace(reservation.reserCheckIn)
								, end : formatDate(reservation.reserCheckOut)
								, extendedProps : {
									reserNo: reservation.reserNo
									, reserStatus: reservation.reserStatus
									, reserPeople: reservation.reserPeople
									, reserFood: reservation.reserFood
								}
								, allDay : true
								//, color: fnColor(status)
							})
						})
						successCallback(arr);
					}
				})
			},  //events
			eventClick: function(info) {
				$('#reserNo').val(info.event.extendedProps.reserNo);
	            openChild(info.event.extendedProps.reserNo);
			}
			
		}); //new FullCalendar.Calendar
		
		// 캘린더 랜더링
		calendar.render();
	
	}); //페이지로드이벤트
	
     let childWindow;
     const popupX = (window.screen.width / 2) - 640/2;
	 const popupY = (window.screen.height / 2) - 480/2;
     function openChild(reserNo){
         childWindow = open('${contextPath}/admin/reserDetail?reserNo=' + reserNo
        		 , '', 'width=640, height=480, top=' + popupY + ', left=' + popupX);
     }
     function sendData(){
         childWindow.onload = function(ev){
        	 childWindow.$('#receive_msg').text($('#reserNo').val());
         }
     }
     function fnColor(status) {
     	if(status == 1) {
 			return 'blue';
     	} else if(status == 0) {
     		return 'red';
     	}
 	}
     
 	function formatDate(date) {
 	    var d = new Date(date),
 	        month = '' + (d.getMonth() + 1),
 	        day = '' + (d.getDate() + 1), //체크아웃날짜까지 포함시켜서 표시(실제 DB는 안바뀜)
 	        year = d.getFullYear();

 	    if (month.length < 2) 
 	        month = '0' + month;
 	    if (day.length < 2) 
 	        day = '0' + day;

 	    return [year, month, day].join('-');
 	}
 	
 	function replace(date) {
 		date = date.replace(/[/]/g,'-')
 		return date;
	}
	
</script>
</head>

<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	<!-- calendar 태그 -->
	<div id="calendar-container" class="container">
		<jsp:include page="index.jsp"></jsp:include>
		<div id="calendar" class="grid_item"></div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
		
</body>
</html>