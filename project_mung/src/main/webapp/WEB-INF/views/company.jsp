<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음.
fmt : formatter 형식 맞춰서 표시 -->

<%@ include file="includes/header.jsp"%>
<!-- Main -->
<div class="container">
	<div class="row gtr-200">
		<div>
			<img src="resources/images/회사소개.png" width=100%;>
			<div id="content"">
				<h3
					style="color: black; font-family: Black Han Sans; font-size: 40pt;">유기견을
					돌보는 이유</h3>
				<img src="resources/images/회사소개내용.png" width=30%;
					style="float: left;">
				<object type="text/html" width="70%" height="500"
					data="//youtube.com/embed/3AV35NdBZOI" allowfullscreen=""></object>
			</div>
		</div>


		<div style="float: left; display:inline-block;">
			<h3
				style="color: black; font-family: Black Han Sans; font-size: 40pt;">
				찾아오시는 길</h3>
			<div id="map" style="width: 500px; height: 400px;"></div>
			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=72d7ece09bcb47ee4290f90b8bce22ce&libraries=services">
			</script>
			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption);

				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				// 주소로 좌표를 검색합니다
				geocoder
						.addressSearch(
								'인천 미추홀구 매소홀로488번길 6-32 태승빌딩 4층',
								function(result, status) {

									// 정상적으로 검색이 완료됐으면 
									if (status === kakao.maps.services.Status.OK) {

										var coords = new kakao.maps.LatLng(
												result[0].y, result[0].x);

										// 결과값으로 받은 위치를 마커로 표시합니다
										var marker = new kakao.maps.Marker({
											map : map,
											position : coords
										});

										// 인포윈도우로 장소에 대한 설명을 표시합니다
										var infowindow = new kakao.maps.InfoWindow(
												{
													content : '<div style="width:150px;text-align:center;padding:6px 0;">멍품천국</div>'
												});
										infowindow.open(map, marker);

										// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
										map.setCenter(coords);
									}
								});
			</script>
		</div>
			<img src="resources/images/주소버스.png" style="width:50%; float:right;">
	</div>
</div>

<%@ include file="includes/footer.jsp"%>