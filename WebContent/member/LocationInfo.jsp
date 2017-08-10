<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/location.css">
<link rel="stylesheet" href="css/location2.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
	<center>
	
	<input type="hidden" value="${bean.l_address }" id="address">
	<input type="hidden" value="${bean.l_name }" id="name">
	<!-- 지도시작 -->
	<div class="boxStyle" margin-bottom="0px;">
		<div class="loctitle" align="left" >${bean.l_name }</div>
			
	<div id="map" style="width:900px;height:350px;margin-bottom:15px;margin-top: 15px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1df28531ff08168fada18465099a508e&libraries=services"></script>
<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();
// 주소로 좌표를 검색합니다
geocoder.addressSearch(document.getElementById('address').value, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new daum.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+document.getElementById('name').value+'</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
	<!-- 지도끝 -->
	
<!-- 	<form action="LocationMain.jsp?center=LocationMap.jsp" method="post"> -->
<!-- 		<table align="center" width="600px" border="0" style="margin-bottom:100px"> -->
<!-- 			<tr align="center"> -->

			<div class="detail" align="left" >상세주소</div>
			<div class="add" align="left">${bean.l_address }</div>
			
			<input style="font-family: 'Jeju Gothic', sans-serif" class="button" type="button" value="돌아가기" onclick="history.back(-1)">
			
			</div></center>
			
<!-- 				<th>주소</th> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td align="center" width="200"> -->
<%-- 					${bean.l_name} --%>
<!-- 				</td>  -->
<!-- 				<td align="center" width="200"> -->
<%-- 					${bean.l_address } --%>
<!-- 				</td> -->
<!-- 				</tr> -->
			
			
<!-- 			<tr> -->
<!-- 				<td align="center" width="200">대여금액</td> -->
<!-- 				<td align="center" width="200"> -->
<%-- 					${bean.carprice } --%>
<!-- 				</td> -->
<!-- 			</tr>			 -->
<!-- 			<tr> -->
<!-- 				<td align="center" width="200">제조회사</td> -->
<!-- 				<td align="center" width="200"> -->
<%-- 					${bean.carcompany } --%>
<!-- 				</td> -->
<!-- 			</tr>			 -->




<!-- 			<tr> -->
<!-- 				<td align="center" width="200"> -->
<%-- 					<input type="hidden" name="l_num" value="${bean.l_num}"> --%>
<%-- 					<input type="hidden" name="l_img" value="${bean.l_img }"> --%>
<%-- 					<input type="hidden" name="l_name" value="${bean.l_name }"> --%>
<!-- 				</td> -->
				
				
<!-- 			</tr>			 -->
<!-- 		</table> -->
<!-- 	</form>	 -->
	<p>


 
</body>
</html>



