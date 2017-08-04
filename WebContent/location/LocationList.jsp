<%@page import="team.location.db.LocationListBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/location2.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1df28531ff08168fada18465099a508e&libraries=services"></script>
<script>

$(document).ready(function(){
	$("td[id^=loca]").data("flag","false");
});

function getcontents(con){
	var nid = con;
	//console.log(nid);
	var bflag = $("#loca"+nid).data("flag");
	//console.log(bflag);
	if(bflag == "false"){
		bflag = "true";
		
		jQuery.ajax({
			type: "POST",
			url: "./LocationInfoController.do", //맵주소부르기.do
			data : "l_num="+nid,
			dataType: "JSON",
			success: function(data){
				//console.log(data);
				var total = data.total;
				var str ="";
				if(total == 0){
					str ="<tr><td>NO DATA</td></tr>";
					$("#loca"+nid).after(str);
				}else{
					
					str="<tr id='loc"+nid+"' align='center'><td><div id='map"+nid+"' style='width:80%; height:350px; margin:15px'></div></td></tr>";
					$("#loca"+nid).parent().after(str);
					
					var mapContainer = document.getElementById('map'+nid), // 지도를 표시할 div 
				    mapOption = {
				        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  
	
					
					// 지도를 생성합니다    
					var map = new daum.maps.Map(mapContainer, mapOption); 
	
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new daum.maps.services.Geocoder();
					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(document.getElementById('address'+nid).value, function(result, status) {
				
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
					            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+document.getElementById('name'+nid).value+'</div>'
					        });
					        infowindow.open(map, marker);
		
					        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					        map.setCenter(coords);
					        //지도를 나타내자
					        
					    } 
					});    
					
				}
			} ,
			error:  function(){
				window.alert("에러");
			}
		});
	}else{
		bflag = "false";
		$("#loca"+nid).parent().next().remove();
	};
	$("#loca"+nid).data("flag",bflag);
	//console.log($("#loca"+nid).data("flag",bflag));
			};

// function doAjax(url, keyword){
// 	jQuery.ajax({
// 		type:"POST",
// 		url: url,
// 		data: "keyword="+keyword,
// 		dataType: "JSON",
// 		success: function(data){
// 			console.log("Function Start");
// 			console.log(data);
// 			notice.empty();
// 			console.log(data);
// 			var total = data.total;
// 			var str ="";
// 			if(total == 0){
// 				str ="<tr><td colspan='2'>NO DATA</td></tr>";
// 				notice.append(str);
// 			}else{
// 				$.each(data.noticeMap, function(key, value){
// 					var con = value.l_num;
// 					var nid = "#nid"+value.l_num;
// 					console.log(nid+"들어갈 아이디");
// 					console.log(key+" : "+value)
// 					str+="<td class='' id='nid"+value.l_num+"'>"+
// 					"<a href='javascript:void(0)' class='map_open'>"+
// 					value.l_name+"</a></td>";
// 				});
// 				notice.append(str).trigger("create");
// 				$("td[id^=nid]").data("flag","false");
// 				console.log($("#nid0").data("flag"));
// 				$("#nid0").data("flag");
// 			}
// 		},
// 		error : function(xhr, status, error) {
// 			console.log("error")
// 		    alert("에러발생");
// 		}
// 	});
// }

// $(document).ready(function(){
// 	notice = $("#notice");
// });
// window.onload = doAjax("./LocationListController.do","");
</script>
</head>
<body>
	<center>
	<div id="mid">
		<h1>위치찾기</h1>
		</div>
		
		<form action="LocationcategoryController.do" method="post">
			<div class="search">
				<table align="center">
					<tr>
						<td colspan="4" align="center"><select style="font-family:'Jeju Gothic',sans-serif; color:#3a3a3a" class="category"
							name="l_category">
								<option  value="">지역</option>
								<option value="su">서울</option>
								<option value="kk">경기</option>
								<option value="ic">인천</option>
								<option value="cc">충청</option>
								<option value="dj">대전</option>
								<option value="jr">전라</option>
								<option value="kj">광주</option>
								<option value="kb">경북</option>
								<option value="tk">대구</option>
								<option value="kn">경남</option>
								<option value="bs">부산</option>
								<option value="us">울산</option>
								<option value="ks">경상</option>
								<option value="kw">강원</option>
								<option value="jj">제주</option>
						</select> <select style="font-family:'Jeju Gothic',sans-serif; color:#3a3a3a" class="category" name="l_category2">
								<option value="">장소</option>
								<option value="lc">롯데시네마</option>
								<option value="mg">메가박스</option>
								<option value="cg">CGV</option>
								<option value="ad">공연장</option>
						</select> &nbsp;&nbsp;&nbsp; <input style="font-family:'Jeju Gothic',sans-serif" class="button" type="submit" value="검색">
						</td>
					</tr>
				</table>
			</div>
		</form>
<hr>
<form method="post">
		<div class="boxStyle">
			<table id="notice" class="tableStyle" width="600" height="300"
				style="margin-bottom: 100px">

				<c:set var="j" value="0" />
				<c:forEach var="v" items="${v}">
						<tr id="lo${v.l_num }" align="center">
					<!-- 						<td> -->
					<%-- 							<a href="LocationInfoController.do?l_num=${v.l_num}"> --%>
					<%-- 								<img alt="" src="../img/${v.l_img}" width="200" height="180"> --%>
					<!-- 							</a> -->
					<!-- 							</td> -->
					<td  id="loca${v.l_num }" >
						<!-- 							원래a태그 --> 
<%-- 					<a href="LocationInfoController.do?l_num=${v.l_num}">${v.l_name }</a> --%>
						<a href="javascript:void(0)" onclick="getcontents(${v.l_num })">${v.l_name }</a>
					
					</td>

					
					</tr>
					
					
					
					
					
					
					
					
					
					
					

					<input type="hidden" value="${v.l_address }" id="address${v.l_num }">
					<input type="hidden" value="${v.l_name }" id="name${v.l_num }">
					<c:set var="j" value="${j+1 }" />
				</c:forEach>
				
			</table>
		</div>
		</form>
		</div>
	</center>
</body>
</html>









