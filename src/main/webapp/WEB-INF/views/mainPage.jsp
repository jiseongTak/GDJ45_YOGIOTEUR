<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/148c1051b1.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link href="https://fonts.googleapis.com/css2?family=Charis+SIL:wght@700&family=Kdam+Thmor+Pro&display=swap" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="${contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${contextPath}/resources/css/header.css">
</head>
<style type="text/css">
	
	
	body{
			margin: 0;
			font-family: 'Kdam Thmor Pro', sans-serif;
		}
		
	
	a{
		text-decoration: none;
		color: white;
	}
	
	form{
		
		background: silver;
		
	
	}
	
	.slick-prev, .slick-next {
    font-size: 0;
    position: absolute;
    bottom: 20px;
    color: #fff;;
    border: 0;
    background: none;
    z-index: 1;
    top: 20px;
    cursor: pointer;
	
	}
	 
	.slick-prev {
	    left: 20px;
	}
	 
	.slick-prev:after {
	      content: "\f104";
	    font: 40px/1 'FontAwesome';
	}
	 
	.slick-next {
	    right: 20px;
	    text-align: right;
	}
	 
	.slick-next:after {
	       content: "\f105";
	     font: 40px/1 'FontAwesome';
	}
	 
	.slick-prev:hover:after,
	.slick-next:hover:after {
	    color: #7e7e7e;
	}
	 
	
	.post{
		
		width: 100%;
		height: 850px;
		
	}
	
	.searchBar{
		display: flex;
		align-items: center;
		background-color: silver;
	    height: 80px;
		font-size: 25px;
		padding-left: 300px;
		color: white;
		
	}
	
	
	
	.weather_api{
		
		display: flex;
		width: 1300px;
		height: 500px;
		
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<script type="text/javascript">
	
	var aa = jQuery.noConflict();
	//페이지 로드 이벤트
	aa(function(){
		
		
		 aa("#roomCheckIn").datepicker({
			 dateFormat: 'yy/mm/dd'
		    });
		    
		 aa("#roomCheckOut").datepicker({
			 dateFormat: 'yy/mm/dd'
		    });
		 
		 fnDate();
		 
		 
		//폼의 서브밋 이벤트
		aa('#f').on('submit', (ev)=>{
			
			if(aa('#roomCheckIn').val() == '' || aa('#roomCheckOut').val() == ''){
				alert('날짜를 선택하세요.');
				ev.preventDefault();
				return false;
			}
			var date1 = new Date(aa('#roomCheckIn').datepicker('getDate'));
			var date2 = new Date(aa('#roomCheckOut').datepicker('getDate'));
			if(date2 - date1 < 0){
				alert('날짜를 확인해주세요.');
				return false;
			}
			
			return true;
			
		})
		
		fnTour();
	
	})
	
	document.oncontextmenu = function(){return false;}
	
	 function fnDate(){
			
		 aa('#roomCheckIn').datepicker('option', 'minDate','0');//오늘부터 선택가능
		 aa('#roomCheckOut').datepicker('option', 'minDate','+1');//다음날부터 선택가능 특정날짜 키워드로 찾아보기
		
	} 
</script>
<script>	
  //함수
  
	function fnTour(){
		$.ajax({
			url: '${contextPath}/admin/tour',
			type: 'get',
			dataType: 'json',
			success: function(responseText){
				//var items = responseText.response.body.items.item;
				//$('#items').empty();
				var html = '';
				console.log(responseText);
				$.each(responseText, function(i, item){
					html += '<td>' + item.tm + '</td>';
					html += '<td>' + item.spotName + '</td>';
					var sky;
					switch(item.sky){
					case 1: sky = '맑음'; break;
					case 2: sky = '구름조금'; break;
					case 3: sky = '구름많음'; break;
					case 4: sky = '흐림'; break;
					case 5: sky = '비'; break;
					case 6: sky = '비눈'; break;
					case 7: sky = '눈비'; break;
					case 8: sky = '눈'; break;
					default: sky = '모름';
					}
					html += '<td>' + sky + '</td>';
					html += '<td>' + item.th3 + '</td>';
					html += '<td>' + item.rhm + '%</td>';
					html += '<td>' + item.pop + '%</td>';
					$('.index'+i).append(html);
					html = '';
				})
			}
		})
	}
  

	
</script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
	
	var bb = jQuery.noConflict();
	bb(function(){
	 bb('.mainImg').slick({
		 autoplay: true,
		 autoplaySpeed: 2000
		
		}); 
	})
</script>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">

	
	<jsp:include page="layout/header.jsp"></jsp:include>
	
	<div class="mainImg">
			<div><img class="post" src="resources/image/hotel.jpg" alt="main" ></div>
			<div><img class="post" src="resources/image/rounge.jpg" alt="main"></div>
			<div><img class="post" src="resources/image/pool.png" alt="main" ></div>
			<div><img class="post" src="resources/image/restaurant.jpg" alt="main" ></div>
	</div>
	
	<div class="center">
		
		<form id="f" action="${contextPath}/room/roomList" method="post">
		
		<div class="searchBar">
			
			<div id="checkInOut" style= "padding-left: 200px;">
			CHECK IN/OUT
			<input type="text" id="roomCheckIn" name="roomCheckIn" style="padding-top: 8px;" autocomplete="off">
			~
			<input type="text" id="roomCheckOut" name="roomCheckOut" style="padding-top: 8px;" autocomplete="off">
			</div>	
			&nbsp;&nbsp;	
			<button class="custom-btn btn-13" >검색</button>
			<button class="custom-btn btn-14" type="reset" id="reset">초기화</button>
		</div>
		
		</form>
		
	</div>
	
	<div class="weather_api">
		
		<table>
			<tbody>
				<tr>
					<td><img src="resources/image/mainPageImage1.jpg" alt="image1" width="90%" height="300px"></td>
					<td><img src="resources/image/mainPageImage2.jpg" alt="image2" width="90%" height="300px"></td>
					<td><img src="resources/image/mainPageImage3.jpg" alt="image3" width="90%" height="300px"></td>
				</tr>
				<tr id="items">
					<td class="index0"></td>
					<td class="index1"></td>
					<td class="index2"></td>
				</tr>
			</tbody>
		</table>
		<!-- 		<td>예보시각</td>
					<td>관광지명</td>
					<td>날씨</td>
					<td>기온</td>
					<td>습도</td>
					<td>강수확률</td> -->
	</div>

	<jsp:include page="layout/footer.jsp"></jsp:include>
</body>
</html>