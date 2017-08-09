/*===================================================
 * 브라우저 종료시 선택한 좌석이 있는 상태인 경우 application 영역에서 삭제해주기


var Browser = {
	     chk : navigator.userAgent.toLowerCase()
	 }
	Browser = {
	    ie : Browser.chk.indexOf('msie') != -1,
	    ie6 : Browser.chk.indexOf('msie 6') != -1,
	    ie7 : Browser.chk.indexOf('msie 7') != -1,
	    ie8 : Browser.chk.indexOf('msie 8') != -1,
	    ie9 : Browser.chk.indexOf('msie 9') != -1,
	    ie10 : Browser.chk.indexOf('msie 10') != -1,
	    opera : !!window.opera,
	    safari : Browser.chk.indexOf('safari') != -1,
	    safari3 : Browser.chk.indexOf('applewebkir/5') != -1,
	    mac : Browser.chk.indexOf('mac') != -1,
	    chrome : Browser.chk.indexOf('chrome') != -1,
	    firefox : Browser.chk.indexOf('firefox') != -1
	}
	// 크롬브라우저
	if(Browser.chrome) {
	 $(window).bind("beforeunload", function() {
		 
		 //현재 단계를 확인
		 //step3 이상이면 함수 호출
		var step = $(".tnb").attr("class");
		
		var step1 = step.match(/step1/g);
		var step3 = step.match(/step3/g);
		var step4 = step.match(/step4/g);
		
		if(step3 != null || step4 != null){
			return removeLocalInfo();
		}
	
	 });
	} 

//application 영역의 선택된 좌석 제거
function removeLocalInfo(){
	
	var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
	var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
	var screen_name = $(".info.theater .row.screen .data").text();
	var viewdate = $(".day.selected").attr("date") + $(".time-list li.selected").attr("play_start_tm");
	var seat = $(".info.seat .row.seat_no .data").text();
	
	jQuery.ajax({
        type:"POST",
        url:"./deleteCheckedSeatInfo.rs",
        data:"pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+"&viewdate="+viewdate+"&seat="+seat,
        dataType:"JSON",
        success : function(data) {
        },
        complete : function(data) {
        },
        error : function(xhr, status, error) {
              alert("에러발생");
        }
 	 });
}
 */

/*===================================================
 * 페이지 로딩이 완료되면 동작
 */
$(document).ready(function(){
	
	//아래 배너의 모든 요소 none
	$(".info div").css("display", "none");
	//영화 포스터 none
	$("span[class='movie_poster']").css("display", "none");
	//영화선택, 극장선택, 좌석선택 글씨 block
	$("div[class='placeholder'] ").css("display","block");
	$(".info.path, .info.path > div").css("display","block");
	
	//요일에 따른 클래스 추가
	$(".dayweek").each(function(i){
		if($(this).text() == '토'){
			$(this).parent().parent().addClass('day-sat');
		}else if($(this).text() == '일'){
			$(this).parent().parent().addClass('day-sun');
		}
	});
	
	//팝업창을 호출한 위치에 따라서 초기 선택값 설정
	var flag = $("#preFlag").val();
	var val = $("#preVal").val();
	
	if(flag == "movie"){
		//영화 상세정보 페이지에서 호출 한 경우
		
		//select설정
		$(".movie-list li[movie_num='"+val+"']").addClass("selected");
		
		//해당하는 상영관 p_code 목록 받아오기, 지역 목록 set
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingPcode.rs",
	        data:"val="+val+"&flag="+"movie",
	        dataType:"JSON",
	        success : function(data) {
	
		    		//해당하는 pcodelist를 받아오면
		    		//전체 상영관 중 pcode에 해당하지 않는 상영관 li에 dimmed 추가
		    		//총 상영관 갯수 (p_code 갯수) 나중에 수정 할 것
		    		//$(".area_theater_list > ul > li").length
		    		var pcount = $(".area_theater_list > ul > li").length;
	        		
	        		//현재 페이지에 있는 pcode 배열로 저장
					var p= [];
					$(".area_theater_list > ul > li").each(function(i) {
						  p[i] = $(this).attr('p_code');
					});
					
					
					//모든 상영관에 추가 후 검색하여 없애기
					//다른 방법이 있나 찾아보자
					$(".area_theater_list > ul > li").addClass("dimmed");
		    				 
		   			 $.each(data.pcodeList, function(key, value){
						if($("li[p_code="+value.p_code+"]").hasClass("dimmed")){
							$("li[p_code="+value.p_code+"]").removeClass("dimmed");
						}else{
	
						}
	                });
	
		    		//총 카운트 지정하기
		    		var cnt= [];
		    		for(var j=1; j<=9; j++){
		    			//지역이름에 해당하는 요소 지정하기
		    			var parUl =  $("li[areaindex ="+j+"][class!='dimmed']").parent();
		    			var pcode = "";
		    			//예매 가능한 상영관의 갯수를 찾아서 배열에 저장
		    		 	cnt[j] = $("li[areaindex ="+j+"][class!='dimmed']").length;
		    		 	//예매 가능한 상영관을 위쪽으로 배치
		    		 	$("li[areaindex ="+j+"][class!='dimmed']").each(function(i){
		    		 		pcode = $(this).attr("p_code");
		    		 		
		    		 		parUl.prepend($("li[p_code="+pcode+"]"));
		    		 	});
		    		 	$(".theater-area-list > ul > li[areaindex ="+j+"] > a > span").text(cnt[j]);
		    		}
		    		
		    		$(".theater-area-list > ul > li > a > span").each(function(i) {
						  $(this).text(cnt[i+1]);
					});
		    		
					$(".area_theater_list > ul > li.selected").removeClass("selected");
					$(".theater-area-list > ul > li.selected").removeClass("selected");
	        },
	        complete : function(data) {
	              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
		
	    //글자없애고 포스터 띄우기
	    $("div[class='placeholder'][title='영화선택'] ").css("display","none");
	    $("span[class='movie_poster']").css("display", "inline");
	    
		//해당 영화에 대한 정보 받아오기 (마지막 날짜 포함)
		jQuery.ajax({
	        type:"POST",
	        url:"./getPlayingMV.rs",
	        data:"mo_num="+val,
	        dataType:"JSON",
	        success : function(data) {
	        	 
	        	//아래 배너의 모든 요소 block
	        	$(".info.movie div").css("display", "block");
	        	//영화선택 글씨 none
	        	$("div[class='placeholder'][title='영화선택'] ").css("display","none");
	        	
	        	
	        	//포스터 지정
	        	$("img[alt='영화 포스터']").attr("src","MovieImage/"+ data.movieInfo.image);
	        	//이름 지정
	        	//a태그 추가해서 상세정보 화면으로 넘어가도록 수정할것
	        	$(".movie_title > span").css("display", "block").text(data.movieInfo.name);
	        	
	        	//등급지정
	        	var age = "";
	        	if(data.movieInfo.age == 'all'){
	        		age = "전체관람가";
	        	}else if(data.movieInfo.age == '18'){
	        		age = "청소년 관람불가";
	        	}else{
	        		age = data.movieInfo.age + "세 관람가";
	        	}
	        	$(".movie_rating > span").text(age).css("display", "block");
	        	
	        	//날짜 지정
	        	var duration = data.duration;
	        	var sindex = $(".date-list > ul > div > li[date="+duration[0].replace(/-/g, '')+"]").attr("data-index");
	        	var eindex = $(".date-list > ul > div > li[date="+duration[1].replace(/-/g, '')+"]").attr("data-index");
	        	
	        	//시작일자가 오늘 날짜보다 이전이면 
	        	if(typeof sindex=="undefined"){
	        		sindex = 0;
	        	}
	        	
	    		//전체날짜를 dimmed하고
	    		$(".date-list > ul > div > li").addClass("dimmed");
	    		
	    		//해당하는 인덱스사이의 값은 dimmed 제거
	    		for(var d=sindex; d<=eindex; d++){
	    			$(".date-list > ul > div > li[data-index="+d+"]").removeClass("dimmed");
	    		}
	        },
	        complete : function(data) {
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
	}else if(flag == "location"){
		//상영관 검색에서 호출 한 경우
	}
	
});

//TODO
/**
 * 첫 선택 : 영화, 극장, 날짜 완료
 * 두번째 선택 :
 * 	영화 > (선택시 날짜, 상영관 모두 세팅. 상영하는 날짜가 모두 같아서 수정 할 필요 없음)
 * 	상영관 > (선택시 날짜, 영화 모두 세팅) 다음 영화 눌렀을 때 날짜 설정 완료 / 다음 날짜 눌렀을 때 설정 완료
 * 	날짜 > (선택시 날짜, 영화 모두 세팅) 다음 영화 눌렀을 때 날짜 
 * 
 * dimmed랑 disabled 클릭을 좀 막자
 */

/*===================================================
 * 극장 지역 선택
 */
function theaterAreaClickListener(event){
	
	//.theater-area-list > ul > li.selected > div
	
	//var id = String(event);
	//$("#"+id).css("display", "block");

//	console.log(event.relatedTarget.tagName);
	$(".theater-area-list > ul > li.selected").removeClass("selected");
	$(".area_theater_list > ul > li.selected").removeClass("selected");
	
	$("#"+event.target.id).parent().addClass("selected");
	 
}

/*===================================================
 * 극장 선택
 */
function theaterListClickListener(event){
	//event가 li 밑에 a태그에 걸려있음
	//선택하지않은 극장들 클래스 제거
	$(".area_theater_list > ul > li.selected").removeClass("selected");
	
	//선택한 극장 상위 태그(li) 
	if(!$("#"+event.target.id).parent().hasClass("dimmed")){
		$("#"+event.target.id).parent().addClass("selected");
	
	
		//극장 글자 block, 극장이름 띄우기
		$(".theater > div").css("display", "block");
		//극장선택 글씨 none
		$("div[class='placeholder'][title='극장선택'] ").css("display","none");
		//극장이름 띄우기
		$(".theater .ellipsis-line1").text($("#"+event.target.id).text());
		
		var pcode = $("#"+event.target.id).parent().attr("p_code");
		
		// 상영관 선택시 그 상영관에서 상영하는 영화가 있는 날만 띄우기
		// 상영관 기준으로 날짜 가져오기
		// 영화, 날짜 아무것도 선택되지 않았을 때
		
		//앞의 영화, 상영관이 선택되었는지 여부 selected된 li가 있으면 ture 반환
		var isSelectedMovie = false;
		var isSelectedDate = false ; 
		
			
		$(".date-list > ul > div > li").each(function(i){
			if($(this).hasClass("selected"))
				isSelectedDate = true;
		});
		
		$(".movie-list > ul > li").each(function(i){
			if($(this).hasClass("selected"))
				isSelectedMovie = true;
		});
		
		//영화, 날짜가 선택되지 않았으면
		if(!isSelectedMovie && !isSelectedDate){
			
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingDate.rs",
		        data:"val="+pcode+"&flag="+"theater",
		        dataType:"JSON",
		        success : function(data) {
		        	
		        	//날짜 지정
		        	var duration = data.duration;
		        	
		        	if(duration[0] == "n"){
		        		//상영 일자가 존재하지 않을 경우 모든 날짜에 dimmed 추가
		        		$(".date-list > ul > div > li").addClass("dimmed");
		        	}else{
			        	var sindex = $(".date-list > ul > div > li[date="+duration[0].replace(/-/g, '')+"]").attr("data-index");
			        	var eindex = $(".date-list > ul > div > li[date="+duration[1].replace(/-/g, '')+"]").attr("data-index");
			        	
			        	//시작일자가 오늘 날짜보다 이전이면 
			        	if(typeof sindex=="undefined"){
			        		sindex = 0;
			        	}
			        	
			    		//전체날짜를 dimmed하고
			    		$(".date-list > ul > div > li").addClass("dimmed");
			    		
			    		//해당하는 인덱스사이의 값은 dimmed 제거
			    		for(var d=sindex; d<=eindex; d++){
			    			$(".date-list > ul > div > li[data-index="+d+"]").removeClass("dimmed");
			    		}
		        	}
		        	
		        },
		        complete : function(data) {
		        },
		        error : function(xhr, status, error) {
		              alert("에러발생");
		        }
		 	 });
			
			//해당 상영관 기준으로 영화 목록 가져오기
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingMonum.rs",
		        async : false,
		        data:"val="+pcode+"&flag="+"theater",
		        dataType:"JSON",
		        success : function(mdata) {
		        	//해당 날짜에 상영하는 영화 번호 리스트를 받아오면
		    		//전체 영화 중 해당하지 않는 영화 li에 dimmed 추가
			    	var mocount = $(".movie-list > ul > li").length;
			    	
			    	//현재 존재하는 movie_num 배열로 저장
			    	var m = [];
			    	$(".movie-list > ul > li").each(function(i) {
						  m[i] = $(this).attr('movie_num');
					});
			    	//모든 영화를 비활성화 시킨 후
			    	$(".movie-list > ul > li").addClass("dimmed");
			    	
			    	
			    	$.each(mdata.monumList, function(key, value){
			    		if($("li[movie_num="+value.movie_num+"]").hasClass("dimmed")){
			    			$("li[movie_num="+value.movie_num+"]").removeClass("dimmed");
			    			console.log("if");
						}else{
							//$("li[movie_num="+value.movie_num+"]").addClass("dimmed");
						}
			    	});
			    	
			    	
			    	//순서 재정리하기
			    	for(var j=0; j<=mocount; j++){
		    			var moUl =  $(".movie-list > ul");
		    			var movie_num = "";
		    			$(".movie-list > ul > li[class!='dimmed']").each(function(i){
		    		 		movie_num = $(this).attr("movie_num");
		    		 		moUl.prepend($("li[movie_num="+movie_num+"]"));
		    		 	});		    	
			    	}
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("getPlayingMonum date 에러발생");
		        }
		 	 });
			}else if(!isSelectedMovie && isSelectedDate){
				//날짜만 선택되어있을 때
				//극장 선택하면 해당 극장, 날짜에 상영하는 영화 목록 고치기
				//해당 상영관 기준으로 영화 목록 가져오기
				jQuery.ajax({
			        type:"POST",
			        url:"./getPlayingMonum.rs",
			        async : false,
			        data:"val="+pcode+"&flag="+"theater",
			        dataType:"JSON",
			        success : function(mdata) {
			        	//해당 날짜에 상영하는 영화 번호 리스트를 받아오면
			    		//전체 영화 중 해당하지 않는 영화 li에 dimmed 추가
				    	var mocount = $(".movie-list > ul > li").length;
				    	
				    	//현재 존재하는 movie_num 배열로 저장
				    	var m = [];
				    	$(".movie-list > ul > li").each(function(i) {
							  m[i] = $(this).attr('movie_num');
						});
				    	//모든 영화를 비활성화 시킨 후
				    	$(".movie-list > ul > li").addClass("dimmed");
				    	
				    	$.each(mdata.monumList, function(key, value){
				    		if($("li[movie_num="+value.movie_num+"]").hasClass("dimmed")){
				    			$("li[movie_num="+value.movie_num+"]").removeClass("dimmed");
				    			console.log("if");
							}else{
								//$("li[movie_num="+value.movie_num+"]").addClass("dimmed");
							}
				    	});
				    	
				    	
				    	//순서 재정리하기
				    	for(var j=0; j<=mocount; j++){
			    			var moUl =  $(".movie-list > ul");
			    			var movie_num = "";
			    			$(".movie-list > ul > li[class!='dimmed']").each(function(i){
			    		 		movie_num = $(this).attr("movie_num");
			    		 		moUl.prepend($("li[movie_num="+movie_num+"]"));
			    		 	});		    	
				    	}
			        },
			        complete : function(data) {
			              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
			        },
			        error : function(xhr, status, error) {
			              alert("getPlayingMonum date 에러발생");
			        }
			 	 });
				
			}else if(isSelectedMovie && isSelectedDate){
				setTime();
			}
	}
}


/*===================================================
 * 특정 영화 선택
 */

$(document).on("click",".movie-list > ul > li > a", function(){
	
	//선택하지 않은 영화들 클래스 제거
	$(".movie-list > ul > li.selected").removeClass("selected");
	
	if(!$(this).parent().hasClass("dimmed")){
		//선택한 영화 클래스 추가
		$(this).parent().addClass("selected");
		
		var movie_num = $(".movie-list > ul > li.selected").attr("movie_num");
		
		//앞의 영화, 상영관이 선택되었는지 여부 selected된 li가 있으면 ture 반환
		var isSelectedDate = false;
		var isSelectedTheater = false ; 
		
			
		$(".area_theater_list > ul > li").each(function(i){
			if($(this).hasClass("selected")){
				isSelectedTheater = true;
				return true;
			}
			console.log(isSelectedTheater);
		});
		
		$(".date-list > ul > div > li").each(function(i){
			if($(this).hasClass("selected"))
				isSelectedDate = true;
		});
		
		
		//날짜, 상영관이 선택되지 않았으면
		if(!isSelectedDate && !isSelectedTheater){
		
			//해당하는 상영관 p_code 목록 받아오기, 지역 목록 set
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingPcode.rs",
		        data:"val="+movie_num+"&flag="+"movie",
		        dataType:"JSON",
		        success : function(data) {
		
			    		//해당하는 pcodelist를 받아오면
			    		//전체 상영관 중 pcode에 해당하지 않는 상영관 li에 dimmed 추가
			    		//총 상영관 갯수 (p_code 갯수) 나중에 수정 할 것
			    		//$(".area_theater_list > ul > li").length
			    		var pcount = $(".area_theater_list > ul > li").length;
		        		
		        		//현재 페이지에 있는 pcode 배열로 저장
						var p= [];
						$(".area_theater_list > ul > li").each(function(i) {
							  p[i] = $(this).attr('p_code');
						});
						
						
						//모든 상영관에 추가 후 검색하여 없애기
						//다른 방법이 있나 찾아보자
						$(".area_theater_list > ul > li").addClass("dimmed");
			    				 
			   			 $.each(data.pcodeList, function(key, value){
							if($("li[p_code="+value.p_code+"]").hasClass("dimmed")){
								$("li[p_code="+value.p_code+"]").removeClass("dimmed");
							}else{
		
							}
		                });
		
			    		//총 카운트 지정하기
			    		var cnt= [];
			    		for(var j=1; j<=9; j++){
			    			//지역이름에 해당하는 요소 지정하기
			    			var parUl =  $("li[areaindex ="+j+"][class!='dimmed']").parent();
			    			var pcode = "";
			    			//예매 가능한 상영관의 갯수를 찾아서 배열에 저장
			    		 	cnt[j] = $("li[areaindex ="+j+"][class!='dimmed']").length;
			    		 	//예매 가능한 상영관을 위쪽으로 배치
			    		 	$("li[areaindex ="+j+"][class!='dimmed']").each(function(i){
			    		 		pcode = $(this).attr("p_code");
			    		 		
			    		 		parUl.prepend($("li[p_code="+pcode+"]"));
			    		 	});
			    		 	$(".theater-area-list > ul > li[areaindex ="+j+"] > a > span").text(cnt[j]);
			    		}
			    		
			    		$(".theater-area-list > ul > li > a > span").each(function(i) {
							  $(this).text(cnt[i+1]);
						});
			    		
			    	//	
			    		
			    		
						$(".area_theater_list > ul > li.selected").removeClass("selected");
						$(".theater-area-list > ul > li.selected").removeClass("selected");
			    		
			    		
			    		
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("에러발생");
		        }
		 	 });
			
		    //글자없애고 포스터 띄우기
		    $("div[class='placeholder'][title='영화선택'] ").css("display","none");
		    $("span[class='movie_poster']").css("display", "inline");
		    
			//해당 영화에 대한 정보 받아오기 (마지막 날짜 포함)
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingMV.rs",
		        data:"mo_num="+movie_num,
		        dataType:"JSON",
		        success : function(data) {
		        	 
		        	//아래 배너의 모든 요소 block
		        	$(".info.movie div").css("display", "block");
		        	//영화선택 글씨 none
		        	$("div[class='placeholder'][title='영화선택'] ").css("display","none");
		        	
		        	
		        	//포스터 지정
		        	$("img[alt='영화 포스터']").attr("src","MovieImage/"+ data.movieInfo.image);
		        	//이름 지정
		        	//a태그 추가해서 상세정보 화면으로 넘어가도록 수정할것
		        	$(".movie_title > span").css("display", "block").text(data.movieInfo.name);
		        	
		        	//등급지정
		        	var age = "";
		        	if(data.movieInfo.age == 'all'){
		        		age = "전체관람가";
		        	}else if(data.movieInfo.age == '18'){
		        		age = "청소년 관람불가";
		        	}else{
		        		age = data.movieInfo.age + "세 관람가";
		        	}
		        	$(".movie_rating > span").text(age).css("display", "block");
		        	
		        	//날짜 지정
		        	var duration = data.duration;
		        	var sindex = $(".date-list > ul > div > li[date="+duration[0].replace(/-/g, '')+"]").attr("data-index");
		        	var eindex = $(".date-list > ul > div > li[date="+duration[1].replace(/-/g, '')+"]").attr("data-index");
		        	
		        	//시작일자가 오늘 날짜보다 이전이면 
		        	if(typeof sindex=="undefined"){
		        		sindex = 0;
		        	}
		        	
		    		//전체날짜를 dimmed하고
		    		$(".date-list > ul > div > li").addClass("dimmed");
		    		
		    		//해당하는 인덱스사이의 값은 dimmed 제거
		    		for(var d=sindex; d<=eindex; d++){
		    			$(".date-list > ul > div > li[data-index="+d+"]").removeClass("dimmed");
		    		}
		        },
		        complete : function(data) {
		        },
		        error : function(xhr, status, error) {
		              alert("에러발생");
		        }
		 	 });
		}else if(!isSelectedTheater && isSelectedDate){
			//날짜만 선택되어 있을 때 해당하는 날에 상영하는 영화가 있는 상영관 지정
			
			var playday = $(".date-list > ul > div > li[class*='selected']").attr("date");
			
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingPcode.rs",
		        data:"val="+movie_num+playday+"&flag="+"all",
		        dataType:"JSON",
		        success : function(data) {
		
			    		//해당하는 pcodelist를 받아오면
			    		//전체 상영관 중 pcode에 해당하지 않는 상영관 li에 dimmed 추가
			    		//총 상영관 갯수 (p_code 갯수) 나중에 수정 할 것
			    		//$(".area_theater_list > ul > li").length
			    		var pcount = $(".area_theater_list > ul > li").length;
		        		
		        		//현재 페이지에 있는 pcode 배열로 저장
						var p= [];
						$(".area_theater_list > ul > li").each(function(i) {
							  p[i] = $(this).attr('p_code');
						});
						
						
						//모든 상영관에 추가 후 검색하여 없애기
						//다른 방법이 있나 찾아보자
						$(".area_theater_list > ul > li").addClass("dimmed");
			    				 
			   			 $.each(data.pcodeList, function(key, value){
							if($("li[p_code="+value.p_code+"]").hasClass("dimmed")){
								$("li[p_code="+value.p_code+"]").removeClass("dimmed");
							}else{
		
							}
		                });
		
			    		//총 카운트 지정하기
			    		var cnt= [];
			    		for(var j=1; j<=9; j++){
			    			//지역이름에 해당하는 요소 지정하기
			    			var parUl =  $("li[areaindex ="+j+"][class!='dimmed']").parent();
			    			var pcode = "";
			    			//예매 가능한 상영관의 갯수를 찾아서 배열에 저장
			    		 	cnt[j] = $("li[areaindex ="+j+"][class!='dimmed']").length;
			    		 	//예매 가능한 상영관을 위쪽으로 배치
			    		 	$("li[areaindex ="+j+"][class!='dimmed']").each(function(i){
			    		 		pcode = $(this).attr("p_code");
			    		 		
			    		 		parUl.prepend($("li[p_code="+pcode+"]"));
			    		 	});
			    		 	$(".theater-area-list > ul > li[areaindex ="+j+"] > a > span").text(cnt[j]);
			    		}
			    		
			    		$(".theater-area-list > ul > li > a > span").each(function(i) {
							  $(this).text(cnt[i+1]);
						});
			    		
			    	//	
			    		
			    		
						$(".area_theater_list > ul > li.selected").removeClass("selected");
						$(".theater-area-list > ul > li.selected").removeClass("selected");
			    		
			    		
			    		
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("에러발생");
		        }
		 	 });
			
		}else if(isSelectedTheater && !isSelectedDate){
	
			//상영관만 선택되어 있을 때  해당하는 관에서 해당하는 영화상영하는 날짜 지정
			var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingDate.rs",
		        data:"val="+pcode+movie_num+"&flag="+"all",
		        dataType:"JSON",
		        success : function(data) {
		        	
		        	//날짜 지정
		        	var duration = data.duration;
		        	
		        	if(duration[0] == "n"){
		        		//상영 일자가 존재하지 않을 경우 모든 날짜에 dimmed 추가
		        		$(".date-list > ul > div > li").addClass("dimmed");
		        	}else{
			        	var sindex = $(".date-list > ul > div > li[date="+duration[0].replace(/-/g, '')+"]").attr("data-index");
			        	var eindex = $(".date-list > ul > div > li[date="+duration[1].replace(/-/g, '')+"]").attr("data-index");
			        	
			        	//시작일자가 오늘 날짜보다 이전이면 
			        	if(typeof sindex=="undefined"){
			        		sindex = 0;
			        	}
			        	
			    		//전체날짜를 dimmed하고
			    		$(".date-list > ul > div > li").addClass("dimmed");
			    		
			    		//해당하는 인덱스사이의 값은 dimmed 제거
			    		for(var d=sindex; d<=eindex; d++){
			    			$(".date-list > ul > div > li[data-index="+d+"]").removeClass("dimmed");
			    		}
		        	}
		        	
		        },
		        complete : function(data) {
		        },
		        error : function(xhr, status, error) {
		              alert("에러발생");
		        }
		 	 });
		}else if(isSelectedTheater && isSelectedDate){
			setTime();
		}
	}
});

/*===================================================
 * 특정 날짜 선택
 */

$(document).on("click",".date-list > ul > div > li > a ", function(){
	//선택하지 않은 날짜들 클래스 제거
	$(".date-list > ul > div > li.selected").removeClass("selected");

	
	if(!$(this).parent().hasClass("dimmed")){
		
		//선택한 날짜 클래스 추가
		$(this).parent().addClass("selected");
		
		var pdate = $(".date-list > ul > div > li.selected").attr("date");
		
		var vdate = pdate.substring(0,4)+"년 "+pdate.substring(4,6)+"월 "+pdate.substring(6)+"일";
		
		//header 글씨 띄우기
		$(".theater div").css("display", "block");
		//극장선택 글씨 none
		$("div[class='placeholder'][title='극장선택'] ").css("display","none");
	
		//bottom bar 날짜 지정
		$(".row.date span[class='data']").text(vdate);
	
		
		//앞의 영화, 상영관이 선택되었는지 여부 selected된 li가 있으면 ture 반환
		var isSelectedMovie = false;
		var isSelectedTheater = false ; 
		
			
		$(".area_theater_list > ul > li").each(function(i){
			if($(this).hasClass("selected")){
				isSelectedTheater = true;
				return true;
			}
			console.log(isSelectedTheater);
		});
		
		$(".movie-list > ul > li").each(function(i){
			if($(this).hasClass("selected"))
				isSelectedMovie = true;
			console.log(isSelectedTheater);
		});
		
		
		//영화, 상영관이 선택되지 않았으면
		if(!isSelectedMovie && !isSelectedTheater){
			
			//해당하는 날짜에 상영하는 영화가 있는 상영관만 표시
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingPcode.rs",
		        data:"val="+pdate+"&flag="+"date",
		        async : false,
		        dataType:"JSON",
		        success : function(data) {
			    		//해당하는 pcodelist를 받아오면
			    		//전체 상영관 중 pcode에 해당하지 않는 상영관 li에 dimmed 추가
			    		//총 상영관 갯수 (p_code 갯수) 나중에 수정 할 것
			    		//$(".area_theater_list > ul > li").length
			    		var pcount = $(".area_theater_list > ul > li").length;
		        		
		        		//현재 페이지에 있는 pcode 배열로 저장
						var p= [];
						$(".area_theater_list > ul > li").each(function(i) {
							  p[i] = $(this).attr('p_code');
						});
						
						
						//모든 상영관에 추가 후 검색하여 없애기
						//다른 방법이 있나 찾아보자
						$(".area_theater_list > ul > li").addClass("dimmed");
			    				 
			   			 $.each(data.pcodeList, function(key, value){
							if($("li[p_code="+value.p_code+"]").hasClass("dimmed")){
								$("li[p_code="+value.p_code+"]").removeClass("dimmed");
							}else {
					    		$(".theater-area-list > ul > li.selected").removeClass("selected");
					    		$(".area_theater_list > ul > li.selected").removeClass("selected");
							}
		                });
		
			    		//지역(총 카운트) 지정하기
			    		var cnt= [];
			    		for(var j=1; j<=9; j++){
			    			var parUl =  $("li[areaindex ="+j+"][class!='dimmed']").parent();
			    			var pcode = "";
			    		 	cnt[j] = $("li[areaindex ="+j+"][class!='dimmed']").length;
			    		 	$("li[areaindex ="+j+"][class!='dimmed']").each(function(i){
			    		 		pcode = $(this).attr("p_code");
			    		 		
			    		 		parUl.prepend($("li[p_code="+pcode+"]"));
			    		 	});
			    		 	$(".theater-area-list > ul > li[areaindex ="+j+"] > a > span").text(cnt[j]);
			    		}
			    		
			    		$(".theater-area-list > ul > li > a > span").each(function(i) {
							  $(this).text(cnt[i+1]);
						});
			    		
			    		//여기 동작이 안되는거같은데 dimmed된 클래스 selected 제거하기
			    		$(".theater-area-list > ul > li[class='dimmed']").each(function(i){
			    			if($(this).hasClass("selected"))
			    				$(this).removeClass("selected");
			    		});
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("getPlayingPcode date 에러발생");
		        }
		 	 });
			
			// 
			
	
			//해당하는 날짜에 상영하는 영화만 표시
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingMonum.rs",
		        async : false,
		        data:"val="+pdate+"&flag="+"date",
		        dataType:"JSON",
		        success : function(mdata) {
		        	//해당 날짜에 상영하는 영화 번호 리스트를 받아오면
		    		//전체 영화 중 해당하지 않는 영화 li에 dimmed 추가
			    	var mocount = $(".movie-list > ul > li").length;
			    	
			    	//현재 존재하는 movie_num 배열로 저장
			    	var m = [];
			    	$(".movie-list > ul > li").each(function(i) {
						  m[i] = $(this).attr('movie_num');
					});
			    	//모든 영화를 비활성화 시킨 후
			    	$(".movie-list > ul > li").addClass("dimmed");
			    	
			    	
			    	$.each(mdata.monumList, function(key, value){
			    		if($("li[movie_num="+value.movie_num+"]").hasClass("dimmed")){
			    			$("li[movie_num="+value.movie_num+"]").removeClass("dimmed");
			    			console.log("if");
						}else{
							//$("li[movie_num="+value.movie_num+"]").addClass("dimmed");
						}
			    	});
			    	
			    	
			    	//순서 재정리하기
			    	for(var j=0; j<=mocount; j++){
		    			var moUl =  $(".movie-list > ul");
		    			var movie_num = "";
		    			$(".movie-list > ul > li[class!='dimmed']").each(function(i){
		    		 		movie_num = $(this).attr("movie_num");
		    		 		moUl.prepend($("li[movie_num="+movie_num+"]"));
		    		 	});		    	
			    	}
	    		 		
	    		 		
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("getPlayingMonum date 에러발생");
		        }
		 	 });
		 	 
		 	 
		}else if(isSelectedMovie && !isSelectedTheater){
			//상영관 선택 없이 영화만 선택되어있으면
			//영화 선택시 날짜와 상영관이 셋팅되기 때문에 따로 수정 할 내용 없음.
			//(모든 상영관이 상영하는 날짜가 같다고 설정해놔서, 이 부분을 	변경하면 수정 할 것)
		}else if(!isSelectedMovie && isSelectedTheater){
			//영화 선택 없이 상영관만 선택되어있으면
			//해당하는 일자에 해당하는 상영관에서 상영하는 영화 설정하기
			var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
			
			jQuery.ajax({
		        type:"POST",
		        url:"./getPlayingMonum.rs",
		        async : false,
		        data:"val="+pcode+pdate+"&flag="+"all",
		        dataType:"JSON",
		        success : function(mdata) {
		        	//해당 날짜에 상영하는 영화 번호 리스트를 받아오면
		    		//전체 영화 중 해당하지 않는 영화 li에 dimmed 추가
			    	var mocount = $(".movie-list > ul > li").length;
			    	
			    	//현재 존재하는 movie_num 배열로 저장
			    	var m = [];
			    	$(".movie-list > ul > li").each(function(i) {
						  m[i] = $(this).attr('movie_num');
					});
			    	//모든 영화를 비활성화 시킨 후
			    	$(".movie-list > ul > li").addClass("dimmed");
			    	
			    	$.each(mdata.monumList, function(key, value){
			    		if($("li[movie_num="+value.movie_num+"]").hasClass("dimmed")){
			    			$("li[movie_num="+value.movie_num+"]").removeClass("dimmed");
			    			console.log("if");
						}else{
							//$("li[movie_num="+value.movie_num+"]").addClass("dimmed");
						}
			    	});
			    	
			    	
			    	//순서 재정리하기
			    	for(var j=0; j<=mocount; j++){
		    			var moUl =  $(".movie-list > ul");
		    			var movie_num = "";
		    			$(".movie-list > ul > li[class!='dimmed']").each(function(i){
		    		 		movie_num = $(this).attr("movie_num");
		    		 		moUl.prepend($("li[movie_num="+movie_num+"]"));
		    		 	});		    	
			    	}
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("getPlayingMonum date 에러발생");
		        }
		 	 });
			
		}else if(isSelectedMovie && isSelectedTheater){
			setTime();
		}
	}
});

/*=========================================================================
 * 시간표 불러오기
 */
//TODO 관이 10개 이상이면 정렬했을떄 두자리수가 먼저 나와버린당.. 나중에 고칠 것
function setTime(){	
	
	var playday = $(".date-list > ul > div > li[class*='selected']").attr("date");
	var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
	var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
	
	jQuery.ajax({
        type:"POST",
        url:"./getPlayingTime.rs",
        async : false,
        data:"pcode="+pcode+"&playday="+playday+"&mo_num="+mo_num,
        dataType:"JSON",
        success : function(data) {
        	//TimeInfoList 가져와썽
        	
        	
        	
        	if(data.TimeInfoList.length == 0){
        		var re = false;
        		re = window.confirm("선택한 날짜에 상영하는 영화가 없습니다. 다시 선택하시겠어요?");
        		
        		if(re){
        			ResetAllSelect();
        		}else{
        			//선택한 날짜 되돌리기
        			$(".date-list > ul > div > li.selected").removeClass("selected");
        		}
        	}else{
	        	//선택하라는 div none
	    		$(".section-time > .col-body > .placeholder").css("display", "none");
	    		
	        	var addList = $(".time-list > div");
	        	var screenStr = "";
	        	var timeStr = "";
	        	var preScreen = "";
	        	var i = 0;
	        	var playnum = 1;
	        	var str = "";
	        	
	        	//이전에 선택해서 나온 값이 있으면 지우기
	        	addList.empty();
	        	
	        	$.each(data.TimeInfoList, function(key, value){
	        		
	        		//이전에 저장된 관 이름과 현재 관 이름이 다를 때만
	        		if(value.screen_name != preScreen){
	        			if(screenStr != "")
	        				str += screenStr + "<ul>" + timeStr + "</ul></div>";
	        			screenStr ="";
	        			timeStr = "";
	        			playnum=1;
	        			
		        		screenStr = "<div  class='theater' screen_code='"+value.screen_name + "' movie_num='"+mo_num +"' style='border: none;'>" +
		        				"<span class = 'title'>"+
		        					"<span class='name'>2D</span>"+
		        					"<span class='floor'>"+value.screen_name+"</span>"+
		        					"<span class='seatcount'>(총"+value.capacity+"석)</span>"+
		        				"</span>";
		        		
		        		preScreen=value.screen_name;
		        		
		        		timeStr = "<li data-index='"+i+"' data-remain_seat='"+value.capacity+"' play_start_tm='"+value.ptime.replace(':','')+
						"' screen='"+value.screen_name + "'play_num='"+playnum+"' class >"+
							"<a class='button' href='#' onclick='screenTimeClickListener(event);return false;'>"+
								"<span class='time'><span>"+value.ptime+"</span></span>"+
								"<span class='count'>"+value.capacity+"석</span>"+
								"<div class='sreader'>종료시간</div>"+
								"<span class='sreader mod'></span>"+
							"</a>"+
						"</li>";
			playnum++;
			i++;
	        		}else {
	        			timeStr += "<li data-index='"+i+"' data-remain_seat='"+value.capacity+"' play_start_tm='"+value.ptime.replace(':','')+
		        					"' screen='"+value.screen_name + "'play_num='"+playnum+"' class >"+
		        						"<a class='button' href='#' onclick='screenTimeClickListener(event);return false;'>"+
		        							"<span class='time'><span>"+value.ptime+"</span></span>"+
		        							"<span class='count'>"+value.capacity+"석</span>"+
		        							"<div class='sreader'>종료시간</div>"+
		        							"<span class='sreader mod'></span>"+
		        						"</a>"+
		        					"</li>";
	        			playnum++;
	        			i++;
	        		}
	        	});
	        	addList.append(str);
	        	
	        	//오늘 상영 중 시간대가 현재 시간보다 이전이면 dimmed 클래스 추가하기
	        	
	            //선택된 date가 오늘일때만
	            var today = $(".date-list > ul > div > li[data-index='1']").attr("date");
	                  
	               var gettime = new Date();
	               var now = gettime.getHours().toString()+gettime.getMinutes().toString();
	               $(".time-list .theater > ul > li").each(function(i){
	                  var time = $(this).attr("play_start_tm");
	                  if(playday == today){
	                  if(now.localeCompare(time)==1){
	                     $(this).addClass("disabled");
	                                   }
	                  }
	                  if(Number(time.substring(0,2))>21){
	                     $(this).addClass("night");
	                  }
	                  if(Number(time.substring(0,2))<9){
	                     $(this).addClass("morning");
	                  }
	                  
	               });
        	}
         },
        complete : function(data) {
        },
        error : function(xhr, status, error) {
              alert("getPlayingMonum date 에러발생");
        }
 	 });
}


/*====================================================================
 * 시간 선택
 */
function screenTimeClickListener(event){
	
	$(".time-list > div > div > ul > li.selected").removeClass("selected");
	
	if(!$(event.currentTarget).parent().hasClass("disabled")){
		$(event.currentTarget).parent().addClass("selected");
		var index = $(".time-list > div > div > ul > li.selected").attr("data-index");
		
		//상영시간 변경하기 popup
		$(".time-list > div > div > ul > li[data-index='"+index+"']").addClass("selected");
		
		//bottom bar 추가
		$(".row.screen span[class='data']").text($(event.currentTarget).parent().attr("screen"));
		
		//버튼 활성화
		$("#tnb_step_btn_right").addClass("on");
	}
}

//시간 변경 취소
$(document).on("click", ".btn_cancel", function(){
	$("#section_time_popup").css("display", "none");
});

//시간 변경 확인
$(document).on("click", ".btn_ok", function(){
	$("#section_time_popup").css("display", "none");
	
	//좌석표 다시 부르기
	var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code"); 
	getSeatMap(pcode);
	
	//시간 다시표시
	var dateInfo = "<b>"+$(".row.date > span.data").text() + "</b> <b class='exe'>("+$(".date-list > ul > div > li.selected > a > span.dayweek").text()
	+")</b><b> "+$(".time-list .theater > ul > li.selected > a > span.time > span:eq(0)").text() + "</b>";
		$(".playYMD-info").empty();
		$(".playYMD-info").append(dateInfo);
		
	//상영관 다시 표시
	$(".theater-info > .screen").text($(".time-list .theater > ul > li.selected").attr("screen"));
	
});

/*====================================================================
 * step2 상영시간 재선택
 */
function ticketStep2TimeSelectPopupShow(){
	$("#section_time_popup").css("display", "block");
	
	//이전 선택 시간 저장해두기
	var preindex = $(".time-list > div > div > ul > li.selected").attr("data-index");
	
}

/*====================================================================
 * 이전단계 버튼
 */
function OnTnbLeftClick(){
	
	var step = $(".tnb").attr("class");
	
	//넘어가기 버튼을 누른 페이지
	var step2 = step.match(/step2/g);
	var step3 = step.match(/step3/g);
	
	if(step2 != null){
		//레이어 옮기기, bottom bar 수정, 버튼 on 제거
		$(".step.step2").css("display", "none");
		$(".tnb.step2").removeClass("step2").addClass("step1");
		$(".step1").css("display", "block");
		$("#tnb_step_btn_right").addClass("on")
		
		//사람 수 선택 제거
		$(".group.adult > ul > li ").removeClass("selected");
		//좌석 선택 제거
		$(".seat_group > div > .seat").removeClass("selected");
	}else if(step3 != null){
		removeLocalInfo();
		
		//레이어 옮기기, bottom bar 수정, 버튼 on 제거
		$(".step.step3").css("display", "none");
		$(".tnb.step3").removeClass("step3").addClass("step2");
		$(".step2").css("display", "block");
		$("#tnb_step_btn_right").addClass("on")
		
	}
}
/*====================================================================
 * 다음단계 버튼
 */

function OnTnbRightClick(){
	//우선 앞의 모든 항목들이 체크되어 있는지 확인 필요
	//단계에 따라서 눌렀을 때 확인이 필요해
	var step = $(".tnb").attr("class");
	
	window.alert(step);
	
	//넘어가기 버튼을 누른 페이지
	
	if(step1 != null){
		if(!$("#tnb_step_btn_right").hasClass("on")){
			//모든 요소가 선택되어 on 클래스를 가지고 있는게 아니라면
			window.alert("영화, 상영관, 날짜, 시간을 선택해주세요");
			//나중에 세부 요소 알림창 띄우기로 수정 할 것
		}else{
			//원래는 여기서 로그인 확인해야함
			//TODO
			
			//레이어 옮기기, bottom bar 수정, 버튼 on 제거
			$(".step.step1").css("display", "none");
			$(".tnb.step1").removeClass("step1").addClass("step2");
			$(".step2").css("display", "block");
			$("#tnb_step_btn_right").removeClass("on")
			
			//step2 정보 띄우기
			$(".theater-info > .site").text($(".area_theater_list > ul > li.selected > a").text());
			$(".theater-info > .screen").text($(".time-list .theater > ul > li.selected").attr("screen"));
			$(".theater-info > .seatNum > .restNum").text($(".time-list .theater > ul > li.selected > a > span.count:eq(0)").text());
			$(".theater-info > .seatNum > .totalNum").text($(".time-list .theater > ul > li.selected").attr("data-remain_seat"));
			
			var dateInfo = "<b>"+$(".row.date > span.data").text() + "</b> <b class='exe'>("+$(".date-list > ul > div > li.selected > a > span.dayweek").text()
							+")</b><b> "+$(".time-list .theater > ul > li.selected > a > span.time > span:eq(0)").text() + "</b>";
			$(".playYMD-info").empty();
			$(".playYMD-info").append(dateInfo);
			
			//인원 선택 전 좌석표에 dimmed 추가
			$(".section-seat").addClass("dimmed");
			
			//좌석표 뿌리기
			var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
			getSeatMap(pcode);
		}
	}else if(step2 != null){
		
		if(!$("#tnb_step_btn_right").hasClass("on")){
			//모든 요소가 선택되어 on 클래스를 가지고 있는게 아니라면
			window.alert("인원수에 맞는 좌석을 선택해주세요");
			//나중에 세부 요소 알림창 띄우기로 수정 할 것
		}else{
		
			var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
			var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
			var screen_name = $(".info.theater .row.screen .data").text();
			var viewdate = $(".day.selected").attr("date") + $(".time-list li.selected").attr("play_start_tm");
			var seat = $(".info.seat .row.seat_no .data").text();
	
			
			//선택한 좌석이 이미 선택된 좌석인지 확인하기
			jQuery.ajax({
		        type:"POST",
		        url:"./checkedSeat.rs",
		        async : false,
		        data:"pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+"&viewdate="+viewdate+"&seat="+seat,
		        dataType:"JSON",
		        success : function(data) {
		        	//data.checkFlag == n 이면 통과 아니면 다시 선택
		        	
		        	if(data.checkedFlag == "y"){
		        		window.alert("이미 선택된 좌석입니다.");
		        		//$(".seat_group > div > .seat").removeClass("selected");
		        		
		        		//좌석표를 다시 불러오는게 어떨까
		        		//아냐 코드가 너무 길어!
		        		
		        		$.each(data.checkedSeats, function(key, value){
		            		var seat_fl = value.seat_fl;
		            		var seat_no = value.seat_no;
		            		$(".seats > .rows .row").find(".label").each(function(i){
		            			if($(this).text() == seat_fl){
		            				//예약되어있는 열의 class를 가져와서 rating관련 클래스 빼주고
		            				var c = $(this).parent().find(".seat[data-index="+seat_no+"]").attr("class");
		            				if(c.search("vip")>0){
		            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_vip");
		            				}else if(c.search("r")>0){
		            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_r");
		            				}else if(c.search("s")>0){
		            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_s");
		            				}
		            				//reserved 클래스 추가
		            				$(this).parent().find(".seat[data-index="+seat_no+"]").addClass("reserved");
		            				$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("selected");
		            			}
		            		});
		            	});
		            	
		        	}else if(data.checkedFlag == "n"){
		        		//레이어 옮기기, bottom bar 수정, 버튼 on 제거
		        		$(".step.step2").css("display", "none");
		        		$(".tnb.step2").removeClass("step2").addClass("step3");
		        		$(".step3").css("display", "block");
		        		$("#tnb_step_btn_right").removeClass("on");
		        		
		        		$("#summary_total_amount").text($(".row.payment-final > span.data > span.price").text());
		        		$("#summary_payment_total").text($(".row.payment-final > span.data > span.price").text());
		        	}
		        	
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("checkedSeat date 에러발생");
		        }
		 	 });
			
			var mnum = $(".mnum").val();
			//member_num으로 포인트 가져오기
			jQuery.ajax({
		        type:"POST",
		        url:"./getMemberPoint.me",
		        async : false,
		        data:"member_num="+mnum,
		        dataType:"JSON",
		        success : function(data) {
		        	$("#ticketlion_point_have").text(data.point);
		        },
		        complete : function(data) {
		              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
		        },
		        error : function(xhr, status, error) {
		              alert("getMemberPoint 에러발생");
		        }
		 	 });
		}
		
	}else if(step3 != null){
		
		var check = checkPaymentInfo();
		
		if(check){
			//내역 확인 팝업창 띄우기
			$(".ft_layer_popup.popup_reservation_check").css("display", "block");
			
			//창 맨위로 스크롤 옮기기
			jQuery('html, body').animate( { 'scrollTop': 0 }, 'slow' );
			
			//팝업창 안에 필요한 정보들 입력
			$(".article.reservation_info .poster img").attr("src",$(".info.movie .movie_poster img").attr("src"));
			$(".article.reservation_info tr.movie_name > td").text($(".info.movie .row.movie_title span").text());
			$(".article.reservation_info tr.theater > td").text($(".info.theater .row.name .data").text());
			$(".article.reservation_info tr.screen > td").text($(".info.theater .row.screen .data").text());
			$(".article.reservation_info tr.movie_date > td").text($(".info.theater .row.date .data").text());
			$(".article.reservation_info tr.people > td").text($(".info.theater .row.number .data").text());
			$(".article.reservation_info tr.seat > td").text($(".info.seat .row.seat_no .data").text());
			
			$(".article.payment_info tr.payment_price > td .price").text($("#summary_payment_total").text());
			$(".article.payment_info .payment_methods .price").text($("#summary_payment_list dt:eq(0)").text());
		}
	}
}

/*=======================================================================
 * 인원선택
 * 
 */

//일반 그룹
$(document).on("click",".group.adult > ul > li ", function(){
	//다른 사람그룹(? 이 추가되면 전체 목록에서 remove selected 하도록 수정
	$(".group.adult > ul > li ").removeClass("selected");
	$(this).addClass("selected");
	
	//bottom bar 인원 나타내기
	$(".row.number > span.data").text("일반 "+$(this).attr("data-count")+"명");
	
	$(".section-seat").removeClass("dimmed");
});

/*========================================================================
 * 좌석표 구성하기
 */
//한 종류 영화관에 관 좌석 수가 같아서 일단 pcode만 받기
function getSeatMap(pcode){
	
	var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
	var screen_name = $(".info.theater .row.screen .data").text();
	var viewdate = $(".day.selected").attr("date") + $(".time-list li.selected").attr("play_start_tm");
	// 좌석표 뿌려주기
	
	$("#seats_list > div").empty();
	
	jQuery.ajax({
        type:"POST",
        url:"./getSeatMap.rs",
        data:"pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+"&viewdate="+viewdate,
        dataType:"JSON",
        success : function(data) {
        	//좌석표 정보를 전달받으면
        	
        	var TotalRowCount = data.seatMap.totalrowcount;
        	var RowGroupCount = data.seatMap.rowgroupcount;
        	//각 열의 구분은 _ 열안의 값 구분은 , 지금은 모든 열의 갯수가 같아서 나중에 수정 할 것
        	//(_기준으로 나눈 후에) 잘라서 배열의 한 열에 넣을 것
        	var temp = (data.seatMap.rowgroupseatcount.toString()).split("_");
        	var RowGroupSeatCount = new Array();
	        	for(var a=0; a<TotalRowCount; a++){
	        		RowGroupSeatCount[a] = temp.toString().split(",");
	        	}
        	var ColGroupCount = data.seatMap.colgroupcount;
        	var ColGroupRowCount = (data.seatMap.colgrouprowcount.toString()).split(",");
        	
        	//vipscope
        	var vipScope = new Array();
        	temp = (data.seatMap.vipscope.toString()).split("_");
        		for(var v =0; v<temp.length; v++){
        			vipScope[v] = temp[v].toString().split(",");
        		}
        		
	    	//rscope
	    	var rScope = new Array();
	    	temp = (data.seatMap.rscope.toString()).split("_");
	    		for(var r =0; r<temp.length; r++){
	    			rScope[r] = temp[r].toString().split(",");
	    		}
	    		
	    	//sscope
	    	var sScope = new Array();
	    	temp = (data.seatMap.sscope.toString()).split("_");
	    		for(var s =0; s<temp.length; s++){
	    			sScope[s] = temp[s].toString().split(",");
	    		}
	    		
	    	var vacantSeats = new Array();
	    	temp = (data.seatMap.vacantseat.toString()).split("_");
		    	for(var vas =0; vas<temp.length; vas++){
		    		vacantSeats[vas] = temp[vas].toString().split(",");
	    		}
        	
        	//열 이름 배열
        	var RowNames = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "N", "M", "O", "P", "Q", "R", "S", "T", "U"];
        	//열 이름 배열 인덱스
        	var RowNameIndex = 0;
        	//하나의 열 결과 텍스트
        	var RowStr = "";
        	//하나의 열에 속한 좌석 결과 텍스트
        	var RowSeatsStr = "";
        	//열 간격 top px값
        	var pxTop=0;
        	//행 간격 data-left px값
        	var pxLeft=0;
        	//열 간격
        	var top=16;
        	//행 간격
        	var left=16;
        	

        	//하나의 열에 총 좌석 갯수
        	
        	var RowSeatCount=0;
        	
        	var rindex = 0;
        	
        	//열 시작 div
        	var startDiv="";
        	//열 끝 div
        	var endDiv="";
        	
        	var isFirstCol = true;
        	var sindex = 0;
        	var rowRe = "";
        	//총 열의 갯수동안
        	for(var r=0 ; r<TotalRowCount; r++){
        		var isFirstCol = true;
        		RowSeatCount=0;
        		//가로그룹 갯수만큼 반복하면서 한 열의 총 좌석 수 구하기
        		for(var sc=0; sc < RowGroupCount; sc++){
        			RowSeatCount += RowGroupSeatCount[r][sc];
        		}
        		
        		pxLeft=0;
        		//열
        		RowStr = "<div class='row' style='top:"+pxTop+"px'>"+
        					"<div class='label'>"+RowNames[RowNameIndex]+"</div>";
        		pxLeft = pxLeft + left; 
        		//가로그룹이 두개라면 첫번째 가로그룹의 좌석을 붙인 후 (RowGroupSeatCount의 두번째 값)
        		//pxLeft값을 한번 더 더해주기
        		pxTop = pxTop + top;
        		RowNameIndex++;
        		RowSeatsStr="";
        		
        		var colSeats = new Array();
        		var i=1;
        		for(sc=0; sc < RowGroupCount; sc++){
        			//첫번째 가로그룹엔 left 클래스 추가
        				if(isFirstCol){
        					startDiv = "<div class='seat_group left'><div class='group'>";
        				}else{
        					startDiv = "<div class='seat_group'><div class='group'>";
        				}
        				sindex=0;
        				while( sindex < parseInt(RowGroupSeatCount[r][sc]) ){
        					RowSeatsStr += "<div class='seat' style='left:"+pxLeft+"px' data-left='"+pxLeft+"' data-index='"+i+"'>"+
        					"<a href='#' onclick='return false;'>"+
        						"<span class='no'></span>"+
        						"<span class='sreader'></span>"+
        						"<span class='sreader mod'></span>"+
        					"</a>"+
        					"</div>";
        					pxLeft = pxLeft + left;
        					sindex ++;
        					i++;
        				}
        				//하나의 가로그룹 좌석 열이 다 붙으면
        				rowRe += startDiv + RowSeatsStr+"</div></div>";
        				isFirstCol = false;
        				RowSeatsStr = "";
        				pxLeft = pxLeft + left;
        		}
        		$("#seats_list > .rows").append(RowStr +rowRe +"</div></div>");
        		rowRe = "";
        		i=1;
        		
        	}
        	
        	
        	//좌석을 다 붙이고나면  세로그룹 대로 재배치
        	//세로그룹 나누기
        	var findr = false;
        	var firstrow = 0;
        	var col = 0;
        	 for(var cgc=0; cgc<ColGroupCount; cgc++){
        		 col += ColGroupRowCount[cgc]*1;
        		$("#seats_list div .row .label").each(function(){
        				
        	
        				 if($(this).text() == RowNames[col]){
        		
        					 findr = true;
        					 firstrow = top*col + (cgc*16);
        					 
        				 }
        				 
        				 if(findr){
        					 firstrow = firstrow + top;
        					 $(this).parent().css("top", firstrow);
        				 }
        			 
        		});
        		firstrow += 16;
        		findr=false;
        	 }
        	 
        	//좌석 위치 배정 후 감싸고있는 div 크기 정해주기(가운데 정렬)
        	//지금은 가로로 좌석 갯수가 같아서 쓰던걸 가져왔는데 나중에 달라지면 max값으로 가져오기
        	$("#seats_list").css("width", RowSeatCount*(left-1)+(RowGroupCount-1)*(left-1));
        	
        	//등급 나누기
        	for(var ri=0; ri<rScope.length; ri++){
        		for(var rs=0; rs<rScope[ri].length; rs++){
        			//첫번째 인수는 열 번호
        			var rownum = rScope[ri][0]-1;
        			
        			
        			if(rScope[ri].length > 1){
	        			//시작 좌석 번호
	        			var s = rScope[ri][1]-1;
	        			//끝 좌석 번호
	        			var e = rScope[ri][2]-1;
	        			
	        			$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(i){
	        				if(s<=i && i<=e){
	        					$(this).addClass("rating_r");
	        					$(this).find(".sreader").not(".sreader.mod").text("R");
	        				}
	        			});
	    			}else {
	    				//없으면 열  전체
	    				$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(){
	        					$(this).addClass("rating_r");
	        					$(this).find(".sreader").not(".sreader.mod").text("R");
	        			});
	    			}
        		}
        	}
        	for(var si=0; si<sScope.length; si++){
        		for(var ss=0; ss<sScope[si].length; ss++){
        			//첫번째 인수는 열 번호
        			var rownum = sScope[si][0]-1;
        			
        			if(sScope[si].length > 1){
	        			//시작 좌석 번호
	        			var s = sScope[si][1]-1;
	        			//끝 좌석 번호
	        			var e = sScope[si][2]-1;
	        			
	        			$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(i){
	        				if(s<=i && i<=e){
	        					$(this).addClass("rating_s");
	        					$(this).find(".sreader").not(".sreader.mod").text("S");
	        				}
	        			});
	    			}else {
	    				//없으면 열  전체
	    				$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(){
	        					$(this).addClass("rating_s");
	        					$(this).find(".sreader").not(".sreader.mod").text("S");
	        			});
	    			}
        		}
        	}
        	for(var vi=0; vi<vipScope.length; vi++){
        		for(var vs=0; vs<vipScope[vi].length; vs++){
        			//첫번째 인수는 열 번호
        			var rownum = vipScope[vi][0]-1;
        			
        			if(vipScope[vi].length > 1){
        				//시작, 끝 번호가 있을때만
        				
	        			//시작 좌석 번호
	        			var s = vipScope[vi][1]-1;
	        			//끝 좌석 번호
	        			var e = vipScope[vi][2]-1;
	        			
	        			$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(i){
	        				if(s<=i && i<=e){
	        					$(this).addClass("rating_vip");
	        					$(this).find(".sreader").not(".sreader.mod").text("VIP");
	        				}
	        			});
        			}else {
        				//없으면 열  전체
        				$("#seats_list > .rows > .row:eq("+rownum+") .seat").each(function(){
	        					$(this).addClass("rating_vip");
	        					$(this).find(".sreader").not(".sreader.mod").text("VIP");
	        			});
        			}
        		}
        	}	
        	
        	//예약된 좌석에 reserved 클래스 추가
        	$.each(data.reservedSeats, function(key, value){
        		var seat_fl = value.seat_fl;
        		var seat_no = value.seat_no;
        		$(".seats > .rows .row").find(".label").each(function(i){
        			if($(this).text() == seat_fl){
        				//예약되어있는 열의 class를 가져와서 rating관련 클래스 빼주고
        				var c = $(this).parent().find(".seat[data-index="+seat_no+"]").attr("class");
        				if(c.search("vip")>0){
        					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_vip");
        				}else if(c.search("r")>0){
        					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_r");
        				}else if(c.search("s")>0){
        					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_s");
        				}
        				//reserved 클래스 추가
        				$(this).parent().find(".seat[data-index="+seat_no+"]").addClass("reserved");
        			}
        		});
        	});
        	
        	//선택중인 좌석 비활성화
    		var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
    		var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
    		var screen_name = $(".info.theater .row.screen .data").text();
    		var viewdate = $(".day.selected").attr("date") + $(".time-list li.selected").attr("play_start_tm");
        	
        	jQuery.ajax({
    	        type:"POST",
    	        url:"./checkedSeat.rs",
    	        async : false,
    	        data:"pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+"&viewdate="+viewdate+"&seat="+"0",
    	        dataType:"JSON",
    	        success : function(data) {
    	        	//data.checkFlag == n 이면 통과 아니면 다시 선택
    	        		
	        		$.each(data.checkedSeats, function(key, value){
	            		var seat_fl = value.seat_fl;
	            		var seat_no = value.seat_no;
	            		$(".seats > .rows .row").find(".label").each(function(i){
	            			if($(this).text() == seat_fl){
	            				//예약되어있는 열의 class를 가져와서 rating관련 클래스 빼주고
	            				var c = $(this).parent().find(".seat[data-index="+seat_no+"]").attr("class");
	            				if(c.search("vip")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_vip");
	            				}else if(c.search("r")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_r");
	            				}else if(c.search("s")>0){
	            					$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("rating_s");
	            				}
	            				//reserved 클래스 추가
	            				$(this).parent().find(".seat[data-index="+seat_no+"]").addClass("reserved");
	            				$(this).parent().find(".seat[data-index="+seat_no+"]").removeClass("selected");
	            			}
	            		});
	            	});
    	        	
    	        },
    	        complete : function(data) {
    	        },
    	        error : function(xhr, status, error) {
    	              alert("checkedSeat2 에러발생");
    	        }
    	 	 });
        	
        },
        complete : function(data) {
              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error : function(xhr, status, error) {
              alert("에러발생");
        }
 	 });
}

/*======================================================================
 * 좌석 선택
 */
$(document).on("click",".seat_group > div > .seat > a", function(i){
	
	var num = $(".numberofpeople-select ul li.selected").attr("data-count");
	//선택하지 않은 좌석들 클래스 제거
	
	if($(".seat_group > div > .seat").hasClass("selected")){
		//다음 요소부터 num개만큼 선택을 위해서 하나 뒤로
		var selectLi = $(this).parent();
		var re = window.confirm("이미 선택된 좌석이 있습니다. 변경하시겠습니까?");
		
		if(re){
			$(".seat_group > div > .seat").removeClass("selected");
			
			for(var n=0; n<num; n++){
				if(n==0)
					$(this).parent().addClass("selected");
				else
					$(this).parent().next().addClass("selected");
			}
		}
	}else{
		for(var n=0; n<num; n++){
			
			if(n==0)
				$(this).parent().addClass("selected");
			else
				$(this).parent().next().addClass("selected");
		
		}
	}
	//bottom bar 설정하기
	//글씨 모두 살리기
	$(".info.seat div").css("display", "block");
	$(".row.payment-adult").css("display", "block");
	
	//좌석 선택 글씨 none
	$("div[class='placeholder'][title='좌석선택'] ").css("display","none");
	
	var selectedGrade = $("#seats_list > .rows > .row .seat.selected" ).find(".sreader").text();
	var grade = new Array();
	
	//좌석이름지정
	$(".info.seat > .row.seat_name > .data").text($("#seats_list > .rows > .row .seat.selected:eq(0)" ).find(".sreader").text());
	var seats = "";
	//좌석 지정
	$(".seat_group > div > .seat.selected").each(function(i){
		seats += $(this).parents(".row").find(".label").text()+ $(this).attr("data-index")+ " ";
	});
	$(".info.seat > .row.seat_no > .data").text(seats);
	
	//가격 지정
	var price = new Array();
	var vip = selectedGrade.match(/VIP/g);
	var r = selectedGrade.match(/R/g);
	var s = selectedGrade.match(/S/g);
	
	var status="day";
	   //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	   if($(".movie-select .movie-list > ul > li.selected > a > span").hasClass("sum")){status="sum";}
	   else if($(".time-list .theater > ul > li.selected").hasClass("night")){status = "night";}
	   else if($(".time-list .theater > ul > li.selected").hasClass("morning")){status = "morning";}
	   
	   if(vip != null){
	      price += vip.length * 10000;
	   if(status=="sum"){price-= vip.length*5000}   
	   if(status=="night"){price-= vip.length*3000}
	   if(status=="morning"){price-= vip.length*5000}
	   }else if( r != null){
	      price += r.length * 9000;
	   if(status=="sum"){price-= r.length*5000}   
	   if(status=="night"){price-= r.length*3000}
	   if(status=="morning"){price-= r.length*5000}
	   }else if(s != null){
	      price += s.length * 8000;
	   if(status=="sum"){price-= s.length*5000}   
	   if(status=="night"){price-= s.length*3000}
	   if(status=="morning"){price-= s.length*5000}
	   }
	//현재는 어른일경우에만 적용
	$(".row.payment-adult > span.data > span.price").text(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	
	//총 금액
	$(".row.payment-final").css("display", "block");
	$(".row.payment-final > span.data > span.price").text(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	
	//버튼 활성화
	$("#tnb_step_btn_right").addClass("on");
});

/*-===================================================================
 * step1 다시하기
 */
function ResetAllSelect(){
	
	$(".date-list > ul > div > li.selected").removeClass("selected");
	$(".movie-list > ul > li.selected").removeClass("selected");
	$(".area_theater_list > ul > li.selected").removeClass("selected");
	
}

/*-===================================================================
 * step2 다시하기
 */
function ftResetAllSeats(){
	
	$(".group.adult > ul > li ").removeClass("selected");
	$(".seat_group > div > .seat").removeClass("selected");
	
	//bottombar
	$(".info.seat div").css("display", "none");
	$(".row.payment-adult").css("display", "none");
	$("div[class='placeholder'][title='좌석선택'] ").css("display","block");
	$(".row.payment-final").css("display", "none");
	$(".row.number > span.data").text('');
	
	//인원선택
	$(".group.adult > ul > li ").removeClass("selected");
	$(".section-seat").addClass("dimmed");
	
}
/*-===================================================================
 * 결제창 할인수단 reset
 */
function ticketStep3Step1Reset(){
	
	
}

/*-===================================================================
 * step3 step1 펼치기, 닫기
 */
$(document).on("click",".tpm_header", function(event){
	//펼치기 부분 이벤트 전파하여 전체 바 클릭시 opened 클래스 추가 할 것
	 event.stopPropagation();
	//현재 클래스가 opened를 가지고있으면(열려있는 상태라면)
	if($(this).parent().hasClass("opened")){
		$(this).parent().removeClass("opened")
		//span의 글자를 펼치기로 바꾸기
		$(this).find("tpmh_btn").text("펼치기");
	}else{
		$(this).parent().addClass("opened")
		//span의 글자를 펼치기로 바꾸기
		$(this).find("tpmh_btn").text("닫기");
	}
	
	//summary_discount_total 최종 할인금액
});


/*-===================================================================
 * step3 step2 결제수단 정하기
 */
$(document).on("click","input[name='last_pay_radio']", function(event){
	var payment = $("input[name='last_pay_radio']:checked").attr("value");
	
	if(payment=="0"){
		//신용카드
		//payment_card
		$(".payment_input").css("display", "none");
		$(".payment_input.payment_card").css("display", "block");
	}else if(payment == "1"){
		$(".payment_input").css("display", "none");
		$(".payment_input.payment_phone").css("display", "block");
		//payment_phone
	}else if(payment == "2"){
		//payment_transfer
		$(".payment_input").css("display", "none");
		$(".payment_input.payment_transfer").css("display", "block");
	}

});

/*-===================================================================
 * step3 내역확인 팝업창 닫기
 */
$(document).on("click",".layer_close", function(event){
	$(".ft_layer_popup.popup_reservation_check").css("display", "none");
});


/*-===================================================================
 * step3 약관 모두 동의(팝업)
 */
$(document).on("click","#resvConfirm", function(event){
	if($("#resvConfirm").is(":checked")){
		$("#resvConfirm").attr("checked", true);
	}else{
		$("#resvConfirm").attr("checked", false);
	}
});


/*-===================================================================
 * step3 예매 결제하기(팝업)
 */
$(document).on("click",".ft a.reservation", function(event){
	
	var agree = true;
	
	//약관에 모두 동의했는지 확인 필요
	if(!$("#resvConfirm").is(":checked")){
		window.alert("약관에 동의해주세요.")
		agree = false;
	}
	
	if(agree){
		//팝업창 닫기
		$(".ft_layer_popup.popup_reservation_check").css("display", "none");
		
		//정보를 다른 방식으로 다룰 방법이 없을까
		var mnum=$(".mnum").val();
		var viewdate = $(".day.selected").attr("date");
		var mo_num = $(".movie-list > ul > li[class*='selected']").attr("movie_num");
		var pcode = $(".area_theater_list > ul > li[class*='selected']").attr("p_code");
		var screen_name = $(".info.theater .row.screen .data").text();
		var seat_no = $(".info.theater .row.number .data").text();
		var usepoint = uncomma($("#ticketlion_point_use").val());
		var price = $("#summary_payment_total").text();
		var seat = $(".info.seat .row.seat_no .data").text();
		var time = $(".time-list li.selected").attr("play_start_tm");
		var payinfo = $("#paymentinfo").val();
		//예매내역 테이블로 넣기
		jQuery.ajax({
	        type:"POST",
	        url:"./makeReservation.rs",
	        async : false,
	        data:"mnum="+mnum+"&pcode="+pcode+"&mo_num="+mo_num+"&screen_name="+screen_name+"&usepoint="+usepoint+
    			"&viewdate="+viewdate+"&seat_no="+seat_no+"&price="+price+"&seat="+seat+"&time="+time+"&payinfo="+payinfo,
	        dataType:"JSON",
	        success : function(data) {
	        	//예매 정보 받아오기 data.resultRsb
	        	
	        	$(".ticket_summary > .poster > img ").attr("src",$(".info.movie .movie_poster img").attr("src"));
	        	$(".ticket_summary .ticket_no .red").text(data.resultRsb.r_num);
	        	$(".ticket_summary .movie_name em").text($(".info.movie .movie_title .data").text());
	        	$(".ticket_summary .theater .theater_name").text($(".theater .ellipsis-line1").text());
	        	$(".ticket_summary .theater .theater_loc").text($(".info.theater .row.screen .data").text());
	        	$(".ticket_summary .movie_date em").text($(".info.theater .row.date .data").text());
	        	$(".ticket_summary .people em").text($(".info.theater .row.number .data").text());
	        	$(".ticket_summary .seat em").text($(".info.seat .row.seat_name .data").text() + " " + $(".info.seat .row.seat_no .data").text());
	        	$(".ticket_summary .payment_price .price").text($(".article.payment_info .payment_price .price").text());
	        	$(".ticket_summary .payment_method .title em").text($(".article.payment_info .payment_methods .price").text());
	        },
	        complete : function(data) {
	        },
	        error : function(xhr, status, error) {
	              alert("makeReservation date 에러발생");
	        }
	 	 });
		$(".step.step3").css("display", "none");
		$(".tnb.step3").removeClass("step3").addClass("step4");
		$(".step4").css("display", "block");
		$(".tnb_container").css("display", "none");
	}
	
});

/*-===================================================================
 * step3 포인트 모두사용
 */

$(document).on("click","#ticketlion_point_all", function(){
	var point = $("#ticketlion_point_have").text()*1;
	var price = uncomma($("#summary_total_amount").text())*1;
	var reprice = price - point;
	
	if($(this).is(":checked")){
		$(this).prop("checked", true);
		
		if(price<point){
			$("#ticketlion_point_use").val(comma(price));
			$("#summary_discount_total").text(comma(price));
			$("#summary_payment_total").text('0');
			$("#summary_payment_list dd").text('0');
		}else{
			$("#ticketlion_point_use").val(comma(point));
			$("#summary_discount_total").text(comma(point));
			$("#summary_payment_total").text(comma(reprice));
			$("#summary_payment_list dd").text(comma(reprice));
		}
	}else{
		$(this).prop("checked", false);
		$("#ticketlion_point_use").val('0');
		$("#summary_discount_total").text('0');
		$("#summary_payment_total").text(comma(price));
		$("#summary_payment_list dd").text(comma(price)+"원");
	}
});


/*-===================================================================
 * step3 포인트 사용
 */

$(document).on("keyup","#ticketlion_point_use", function(){
	//키보드를 눌렀다가 뗄 때 마다 쓰인 값을 가져와서 할인에 적용하기
	var use = $(this).val()*1;
	var point = $("#ticketlion_point_have").text()*1;
	var price = uncomma($("#summary_total_amount").text())*1;
	var reprice = price - use;
	//할인 금액에 적용
	
	if(use >point ){
		use = point;
		$(this).val(use);
		reprice = price - point
	}else if(use>price && use<point){
		use = price;
		$(this).val(use);
	}
	$("#summary_discount_total").text(comma(use));
	//최종 금액에 적용
	if(reprice>0){
		$("#summary_payment_total").text(comma(reprice));
		$("#summary_payment_list dd").text(comma(reprice));
	}else{
		$("#summary_payment_total").text('0');
		$("#summary_payment_list dd").text("0원");
	}
});

/*-===================================================================
 * 금액 콤마 관련
 */

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
 
//콤마풀기
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
 
//값 입력시 콤마찍기
function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

/*-===================================================================
 *  결제창 유효성 검사
 */

$(document).on("change", "input[name = 'last_pay_radio']", function(){
	var payment = $("input[name = 'last_pay_radio']:checked").val();
	
	if(payment == 0){
		$("#summary_payment_list dt").text("신용카드");
	}else if(payment == 1){
		$("#summary_payment_list dt").text("휴대폰");
	}else if(payment == 2){
		$("#summary_payment_list dt").text("계좌이체");
	}
});

function checkPaymentInfo(){
	
	//결제방법 선택
	
	var payment = $("input[name = 'last_pay_radio']:checked").val();
	
	if(payment == 0){
		$("#summary_payment_list dt").text("신용카드");
		
		//카드선택
		var card = $("#lp_card_type option:selected").attr("card_code");
		var cardnum = $("#lp_card_no1").val() + $("#lp_card_no2").val() 
						+ $("#lp_card_no3").val() + $("#lp_card_no4").val();
		var cardpw = $("#lp_card_pw").val();
		var cardex = $("#lp_card_year").val() + $("#lp_card_month").val();
		var cardssn = $("#lp_card_ssn").val();
		
		var paymentinfo = "card_"+card+"_"+cardnum+"_"+cardpw+"_"+cardex+"_"+cardssn;
		
		if(card==null || cardnum==null || cardpw==null || cardex==null || cardssn==null){
			window.alert("카드 정보를 정확하게 입력해주세요.");
			return false;
		}else{
			$("#paymentinfo").val(paymentinfo);
			return true;
		}
	}else if(payment == 1){
		$("#summary_payment_list dt").text("휴대폰");
		var name = $("#lp_phone_name").val();
		var phonepd = $("#lp_phone_pd_type option:selected").attr("pd_code");
		var phonenum = $("#lp_phone_no1").val() + $("#lp_phone_no2").val() + $("#lp_phone_no3").val();
		var phonessn = $("#lp_phone_ssn").val();
		
		var paymentinfo = "phone"+name+"_"+phonepd+"_"+phonenum+"_"+phonessn;
		
		if(name==null || phonepd==null || phonenum==null || phonessn==null){
			window.alert("휴대폰 정보를 정확하게 입력해주세요.");
			return false;
		}else{
			$("#paymentinfo").val(paymentinfo);
			return true;
		}
	}else if(payment ==2){
		$("#summary_payment_list dt").text("계좌이체");
		var account = $("#lp_account_no1").val();
		var accountpw = $("#lp_account_pw").val();
		var accountssn = $("#lp_account_ssn").val();
		
		var paymentinfo = "transfer_"+account+"_"+accountpw+"_"+accountssn;
		
		if(account==null || accountpw==null || accountssn==null){
			window.alert("계좌 정보를 정확하게 입력해주세요.");
			return false;
		}else{
			$("#paymentinfo").val(paymentinfo);
			return true;
		}
	}

}


/*
 * =====================================================================
	뮤지컬 예매 관련
 */

/*===============================================================
 * 페이지 로딩이 완료되면
 */
 
$(document).ready(function(){
	
	//달력 구현하기
	calendars();
	
	var selectdate = "";
	
	//공연이 있는 날짜만큼 클래스 처리하기
	$(".dcursor").each(function(i){
		var day = new Date($(this).attr("id"));
		
		var sday = new Date($("#sday").val());
		var eday = new Date($("#eday").val());
		var today = new Date();
		
		if(sday <= day && eday >= day && day >= today){
			$(this).parent().addClass("select");
			$(this).attr("title", $(this).attr("id"));
			//선택 가능한 클래스를 추가 한 후 좌석 선택 상단바의 select box 목록에 추가
			selectdate += "<option value='"+$(this).attr("id")+"'>"+$(this).attr("id") +" "+ getInputDayLabel($(this).attr("id"))+"</option>";
		}
		
		//오늘 이전날짜 클래스 제거
		//후에 시간대 확인까지 고려 할 것 수정
		if(day < today){
			$(this).parent().removeClass("select")
		}
	});
	
	$("#selFlashDateAll").append(selectdate);
});


//특정 날짜 요일 구하기
function getInputDayLabel(date) { 
	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'); 
	var today = new Date(date).getDay(); 
	var todayLabel = week[today]; 
	return todayLabel; 
}

	
/*===================================================================
 * 날짜 선택
 */
var timeseat ;
var ping_num =0;

function selectDay(event){
	
	//이미 뿌려진 좌석등급, 잔여석 제거
	$("#ulSeatSpace").empty();
	
	//해당 날짜가 예매 가능한 날짜이면 term 클래스 추가하기
	if($(event.currentTarget).parent().hasClass("select")){
		//이미 선택된 날짜의 클래스를 제거하고
		$(".dcursor").parent().removeClass("term");
		$(event.currentTarget).parent().addClass("term");
	
	//회차 선택의 선택 날짜 띄우기
	$(".select_day > .tit").next().text(event.currentTarget.id);
	
	//선택 내역의 선택 날짜 띄우기
	$("#tk_day").text(event.currentTarget.id);
	
	//해당하는 날짜 좌석 상단바 select box 지정하기
	$("#selFlashDateAll > option[value = '"+event.currentTarget.id+"']").attr("selected", "true");
	
	
	//회차 선택의 회차 띄우기
	//해당 날짜, 뮤지컬 번호
	// TODO
	var round = "";
	var munum = $("#munum").val();
	var date = event.currentTarget.id;
	var classOn = "";
	var i=1;
	var seats = "";
	var ptime;
	var selectround = "";
	
	jQuery.ajax({
        type:"POST",
        url:"./getTimeSeat.rs",
        async : false,
        data:"munum="+munum+"&date="+date,
        dataType:"JSON",
        success : function(data) {
        	//data.timeseatList
        	
        	//회차 띄우기
        	timeseat = data.timeseatList;
        	
        	var rcount = 1;
    		$.each(data.timeseatList, function(key, value){
    			ping_num = value.ping_num;
    			ptime = value.ptime;
    			
            	if(data.timeseatList.length/3 == 1){
            		classOn = "on";
            	}else{
            		classOn = "";
            	}
            	
            	seats += "<li><strng>"+value.seatclass+"석 </strong>"+comma(value.price)+"원 (잔여:<span class='red'>"+value.remained+"석</span>)</li>";
    			//새로운 회차일 때 마다 추가하기
    			if(i%3 == 0){
    			round += "<li id=round"+rcount+" timeoption=''"+" idhall=''"+" seatviewmode=''"+" saleclose='"+date
    				+"' cancelclose='"+event.currentTarget.id+" "+value.ptime+"' limitcussalecnt= ''"
    				+" limittimesalecnt=''"+" timeinfo='"+value.ptime+"' class='"+classOn+"'>["+rcount+"회] "+value.ptime+"</li>";
    			selectround += "<option id=rounds"+rcount+" timeoption=''"+" idhall=''"+" seatviewmode=''"+" saleclose='"+date
				+"' cancelclose='"+event.currentTarget.id+" "+value.ptime+"' limitcussalecnt= ''"
				+" limittimesalecnt=''"+" timeinfo='"+value.ptime+"' class='"+classOn+"'>["+rcount+"회] "+value.ptime+"</option>";
    			rcount++;
    			}
    			i++;
    		});
    		//좌석선택 상단바에 select box 회차 추가
        	$("#selFlashTime").append(selectround);
        	
    		if(data.timeseatList.length/3 == 1){
            	//잔여석
            	$("#ulSeatSpace").empty();
            	$("#ulSeatSpace").append(seats);
            	
            	$("#rounds1").attr("selected", "true");
            	$("#tk_time").html(ptime);
        	}
        	
    		//회차
    		$("#ulTime").empty();
        	$("#ulTime").append(round);
        	
        },
        complete : function(data) {
        },
        error : function(xhr, status, error) {
              alert("selectDay 회차, 잔여석 가져오기 에러발생");
        }
 	 });
	}
}

$(document).on("click","#resvConfirm", function(event){
	if($("#resvConfirm").is(":checked")){
		$("#resvConfirm").attr("checked", true);
	}else{
		$("#resvConfirm").attr("checked", false);
	}
});


/*====================================================================
 * 달력 구현
 */
function calendars(){
	
	//일 수 붙일 tbody 
	var addDays = $("#addCalendar");
	
	 
	 var nowDate = new Date();               //오늘 날짜 객체 선언  
	    var nYear = nowDate.getFullYear();      //오늘의 년도  
	    var nMonth = nowDate.getMonth() ;       //오늘의 월 ※ 0월부터 시작  
	    var nDate = nowDate.getDate();           //오늘의 날  
	    var nNumday = nowDate.getDay();         //오늘의 요일 0=일요일...6=토요일  
	    var endDay=new Array(31,28,31,30,31,30,31,31,30,31,30,31);      //각달의 마지막 날짜  
	    var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수  
	    var col=0;  //요일을 이용해서 나중에 앞뒤 빈 날짜칸 계산   
	    eDate= new Date(nYear,nMonth,1);       // 1일의 숫자 요일을 구하기 위해서날짜 객체 선언  
	    var fNumday=eDate.getDay();    // 이번달 1일의 숫자 요일  
	    var lastDay=endDay[nMonth]; //이번달의 마지막 날짜  
	    var calendarStr="";
		  var day = "";
		  var month = "";
	        if ((eDate.getMonth()==1)&&(((eDate.getYear()%4==0)&&(eDate.getYear() %100 !=0))||eDate.getYear() % 400 ==0 ))  
	        {lastDay=29;} // 0월 부터 시작하므로 1는 2월임. 윤달 계산 4년마다 29일 , 100년는 28일, 400년 째는 29일  
	  
	        calendarStr +="<tr>";  
	  
	        for (i=0;i<fNumday;i++){          // 첫번째 날짜의 숫자 요일을 구해서 그전까지는 빈칸 처리  
	            calendarStr +="<td>&nbsp;</td>";   
	            col++;                       
	        }
	  
	        for ( i=1; i<=lastDay; i++){       // 해당 월의 달력
	        	
	        	if(nMonth*1+1 < 10)
	        		month = "0"+(nMonth*1+1);
	        	if(i<10)
	        		day = "0"+i;
	        	else
	        		day = i;
	        	
	            if(eDate.getFullYear()==nYear&&eDate.getMonth()==nMonth&&i==nDate){//오늘이면 today 스타일로 표시  
	                calendarStr +="<td><a caldays='"+day+"' href='#' onclick='selectDay(event);' class='dcursor' id='"+
	                				nYear+"-"+month+"-"+day+"' title='해당일은 공연이 없습니다.'>"+day+"</a></td>";
	            }else{  
	                if(col==0){              //일요일이면  
	                    calendarStr +="<td><a caldays='"+day+"' href='#' onclick='selectDay(event);' class='dcursor' id='"+
	                				nYear+"-"+month+"-"+day+"' title='해당일은 공연이 없습니다.'>"+day+"</a></td>";
	                }else if(1<=col&&col<=5){//그외 평범한 날이면  
	                    calendarStr +="<td><a caldays='"+day+"'href='#'  onclick='selectDay(event);' class='dcursor' id='"+
	                				nYear+"-"+month+"-"+day+"' title='해당일은 공연이 없습니다.'>"+day+"</a></td>";  
	                }else if(col==6){        //토요일이면  
	                    calendarStr +="<td><a caldays='"+day+"'href='#'  onclick='selectDay(event);' class='dcursor' id='"+
	                				nYear+"-"+month+"-"+day+"' title='해당일은 공연이 없습니다.'>"+day+"</a></td>";  
	                }  
	            }             
	  
	            col++;  
	  
	            if(col==7){     //7칸을 만들면 줄 바꾸어 새 줄을 만들고 다시 첫 칸부터 시작  
	                calendarStr +="</tr><tr>";
	                col=0;  
	            }  
	        }     
	        for (i=col;i<dayName.length;i++){        //마지막 날에서 남은 요일의 빈 칸 만들기  
	            calendarStr +="<td>&nbsp;</td>";  
	        }  
	        calendarStr +="</tr>";  
	        addDays.append(calendarStr); //만든 달력 소스를 화면에 보여주기  
}


/*===============================================================================================
 * 좌석 선택 단계로 이동하기
 */
 
function ChoiceSeat(){
	window.alert("다음단계");
	
	$("#header").css("display", "none");
	$("#ContentsArea").css("display", "none");
	$("#StateBoard").css("display", "none");
	$("#SeatFlashArea").css("display", "block");
	
	//좌석표 뿌리기
	getMap();
	
}

function outMap(){
	
}

/*===============================================================================================
 * 회차 선택
 */
$(document).on("click","#ulTime > li", function(){
	
	//이미 선택된 클래스 on 제거
	$("#ulTime > li").removeClass("on");
	
	//이미 뿌려진 좌석등급, 잔여석 제거
	$("#ulSeatSpace").empty();
	
	//선택한 회차 on 클래스 추가
	$(this).addClass("on");
	
	var thisId = $(this).attr("id");
	var count = -1;
	var seats = "";
	
	var round = $(this).attr("id").substring(8,9);
	var i=0;
	
	$.each(timeseat, function(key, value){
		if((round-1)*3 <= i && i<((round-1)*3+3)){
			seats += "<li><strng>"+value.seatclass+"석 </strong>"+comma(value.price)+"원 (잔여:<span class='red'>"+value.remained+"석</span>)</li>";
		}
		i++;
	});
	
	//좌석등급, 잔여석 표시
	$("#ulSeatSpace").append(seats);
	
	//좌석 선택 상단바 select box 지정하기
	$("option["+$(this).attr("id")+"]").attr("selected", "true");
});

/*===============================================================================================
 * 좌석표 뿌리기
 */

function getMap(){
	
	//우선은 1층만하자
	var left = 11;
	var top = 12;
	var seats = "";
	
	var pxLeft;
	var pxTop;
	
	var firstTop = 188;
	var firstLeft = 10;
	
	var ABlockRowSeatNum = [5,6,7,8,9,10,11,12,13,13,13,13,13,13,13,13,13,13];
	var BBlockRowSeatNum = [12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12];
	var CBlockRowSeatNum = [12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12];
	var DBlockRowSeatNum = [12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12];
	var EBlockRowSeatNum = [5,6,7,8,9,10,11,12,13,13,13,13,13,13,13,13,13,13];
	
	var rowcount =1;
	var seatnum = 1;
	//A블럭, 열 구분없이 번호로 좌석 지정
	pxTop = firstTop;
	
	for(var i=0; i<ABlockRowSeatNum.length; i++){
		
		//좌석 갯수가 13개가 아니면 차이 수 만큼 left 계산해서 내보내기
		if(ABlockRowSeatNum[i] < 13){
			pxLeft = firstLeft + left*(13-ABlockRowSeatNum[i]);
		}else{
			pxLeft = firstLeft;
		}
		
		for(var a=0; a<ABlockRowSeatNum[i]; a++){
			if(seatnum < 10){
				seatnum = "00"+seatnum.toString();
			}else if(10<= seatnum && seatnum <100){
				seatnum = "0"+seatnum.toString();
			}
			
			seats += "<div style='TOP: "+ pxTop +"px; LEFT:"+ pxLeft +"px' id='' class='s13 act' name='tk' value='A' row='"+rowcount+"' title='1층 A구역 "+seatnum+"번'></div>";
			pxLeft += left;
			seatnum = seatnum*1;
			seatnum++;
		}
		pxTop += top;
		rowcount++;
	}

	
	//B구역
	rowcount =1;
	firstLeft = pxLeft+left;
	pxTop = firstTop;
	seatnum = 1;
	for(var i=0; i<BBlockRowSeatNum.length; i++){
		
		//좌석 갯수가 13개가 아니면 차이 수 만큼 left 계산해서 내보내기
		if(BBlockRowSeatNum[i] < 12){
			pxLeft = firstLeft + left*(12-BBlockRowSeatNum[i]);
		}else{
			pxLeft = firstLeft;
		}
		
		for(var a=0; a<BBlockRowSeatNum[i]; a++){
			if(seatnum < 10){
				seatnum = "00"+seatnum.toString();
			}else if(10<= seatnum && seatnum <100){
				seatnum = "0"+seatnum.toString();
			}
			seats += "<div style='TOP: "+ pxTop +"px; LEFT:"+ pxLeft +"px' id='' class='s13 act' name='tk' value='B' row='"+rowcount+"' title='1층 B구역 "+seatnum+"번'></div>";
			pxLeft += left;
			seatnum = seatnum*1;
			seatnum++;
		}
		pxTop += top;
		rowcount++;
	}
	
	//C구역
	rowcount =1;
	firstLeft = pxLeft+left;
	pxTop = firstTop;
	seatnum = 1;
	for(var i=0; i<CBlockRowSeatNum.length; i++){
		
		//좌석 갯수가 13개가 아니면 차이 수 만큼 left 계산해서 내보내기
		if(CBlockRowSeatNum[i] < 12){
			pxLeft = firstLeft + left*(12-CBlockRowSeatNum[i]);
		}else{
			pxLeft = firstLeft;
		}
		
		for(var a=0; a<CBlockRowSeatNum[i]; a++){
			if(seatnum < 10){
				seatnum = "00"+seatnum.toString();
			}else if(10<= seatnum && seatnum <100){
				seatnum = "0"+seatnum.toString();
			}
			seats += "<div style='TOP: "+ pxTop +"px; LEFT:"+ pxLeft +"px' id='' class='s13 act' name='tk' value='C' row='"+rowcount+"' title='1층 C구역 "+seatnum+"번'></div>";
			pxLeft += left;
			seatnum = seatnum*1;
			seatnum++;
		}
		pxTop += top;
		rowcount++;
	}
	
	//D구역
	rowcount =1;
	firstLeft = pxLeft+left;
	pxTop = firstTop;
	seatnum = 1;
	for(var i=0; i<DBlockRowSeatNum.length; i++){
		
		//좌석 갯수가 13개가 아니면 차이 수 만큼 left 계산해서 내보내기
		if(DBlockRowSeatNum[i] < 12){
			pxLeft = firstLeft + left*(12-DBlockRowSeatNum[i]);
		}else{
			pxLeft = firstLeft;
		}
		
		for(var a=0; a<DBlockRowSeatNum[i]; a++){
			if(seatnum < 10){
				seatnum = "00"+seatnum.toString();
			}else if(10<= seatnum && seatnum <100){
				seatnum = "0"+seatnum.toString();
			}
			seats += "<div style='TOP: "+ pxTop +"px; LEFT:"+ pxLeft +"px' id='' class='s13 act' name='tk' value='D' row='"+rowcount+"' title='1층 D구역 "+seatnum+"번'></div>";
			pxLeft += left;
			seatnum = seatnum*1;
			seatnum++;
		}
		pxTop += top;
		rowcount++;
	}
	
	//E구역
	rowcount =1;
	firstLeft = pxLeft+left;
	pxTop = firstTop;
	seatnum = 1;
	for(var i=0; i<EBlockRowSeatNum.length; i++){
		
		//좌석 갯수가 13개가 아니면 차이 수 만큼 left 계산해서 내보내기
		if(EBlockRowSeatNum[i] < 13){
			pxLeft = firstLeft;
		}else{
			pxLeft = firstLeft;
		}
		
		for(var a=0; a<EBlockRowSeatNum[i]; a++){
			if(seatnum < 10){
				seatnum = "00"+seatnum.toString();
			}else if(10<= seatnum && seatnum <100){
				seatnum = "0"+seatnum.toString();
			}
			seats += "<div style='TOP: "+ pxTop +"px; LEFT:"+ pxLeft +"px' id='' class='s13 act' name='tk' value='E' row='"+rowcount+"' title='1층 E구역 "+seatnum+"번'></div>";
			pxLeft += left;
			seatnum = seatnum*1;
			seatnum++;
		}
		pxTop += top;
		rowcount++;
	}
	
	$("#divSeatArray").empty();
	$("#divSeatArray").append(seats);
	
	
	//좌석표 뿌린 후 가로 순서대로 id지정
	var t=1;
	for(var r=1; r<=18; r++){
		$("div[row='"+r+"']").each(function(){
			//첫번째 열의 left값을 가져와서 첫 좌석의 번호 찾기
			if(t==1){
				t = ($(this).attr("style").substring(17,19)*1 - 10)/11 + 1;
			}
			$(this).attr("id", makeSeatId('1',r,t));
			t++;
		});
		t=1;
	}
	
	//좌석 등급별 클래스 지정
	var vip = ['10010014', '10010049'];
	
	for(var v=1; v<=14; v++){
		for(var s=14; s<=49; s++){
			if(v<10){
				$("#100"+v+"00"+s).removeClass("s13");
				$("#100"+v+"00"+s).addClass("s1").attr("grade", "VIP");
				
			}else{
				$("#10"+v+"00"+s).removeClass("s13");
				$("#10"+v+"00"+s).addClass("s1").attr("grade", "VIP");;
			}
		}
	}
	
	var aR = [[1,3,12,13], [1,3,50,51],
	         [4,5,10,13], [4,5,50,53],
	         [6,7,6,13], [6,7,50,57],
	         [8,14,4,13], [8,14,50,57],
	         [15,16,4,57],
	         [17,18,4,45]];

	for(var a=0; a<aR.length; a++){
		var StartRow = aR[a][0];
		var EndRow = aR[a][1];
		var StartSeat = aR[a][2];
		var EndSeat = aR[a][3];
	
		for(var r = StartRow; r<=EndRow; r++){
			
			for(var s=StartSeat; s<=EndSeat; s++){
				var id = makeSeatId(1,r,s);
					$("#"+id).removeClass("s13");
					$("#"+id).addClass("s6").attr("grade", "R");;
			}
		}
	}
	
	//S석
	$(".s13").removeClass("s13").addClass("s8").attr("grade", "S");
	
	//예매 불가능한 좌석 매핑
	getReservedSeat();
	
}

function makeSeatId(floor, row, seat){
	
	//아이디는 층수(1) + 열수(3) + 좌석수(4)로 총 8자리
	var id = "";
	var zero = "";
	var f = floor.toString();
	var r = row.toString();
	var s = seat.toString();
	
	if(r.length < 3){
		for(var z=0; z<3-r.length; z++){
			zero += "0";
		}
	}
	id=f+zero+r;
	zero="";
	if(s.length < 4){
		for(var z=0; z<4-s.length; z++){
			zero +="0";
		}
	}
	id += zero+s;
	return id;
}

/*==================================================================================
 * 예매 불가능한 좌석 매핑하기
 */

function getReservedSeat(){
	
	var viewdate = $("#selFlashTime option:selected").attr("cancelclose");
	
	jQuery.ajax({
        type:"POST",
        url:"./getReservedSeat.rs",
        async : false,
        data:"ping_num="+ping_num+"&viewdate="+viewdate,
        dataType:"JSON",
        success : function(data) {
        	//data.reservedSeats
        	
        	$.each(data.reservedSeats, function(key, value){
        		$("#"+value.seat_id).attr("class", "s13").attr("title","");
        	});
        },
        complete : function(data) {
        },
        error : function(xhr, status, error) {
              alert("getReservedSeat 에러발생");
        }
 	 });
}


/*=================================================================================
 * 좌석 선택
 */
$(document).on("click","div.act", function(){
	
	var chseat = "";
	var id = $(this).attr("id");
	var block = $(this).attr("value");
	var grade = $(this).attr("grade");
	var seat = $(this).attr("title");
	
	chseat = "<p id='"+id+block+"' class='txt2' name='cseat' grade='"+grade+"석'>"+seat+"</p>";
	
	//이미 son클래스를 가지고 있다면 선택을 취소
	if($(this).hasClass("son")){
		$(this).attr("class", $(this).attr("oldclass"));
		$("#"+id+block).remove();
		
	}else{
		//이전의 클래스 값 oldclass로 저장
		$(this).attr("oldclass", $(this).attr("class")).attr("class", "son act");
		$("#liSelSeat").append(chseat);
	}
});

/*===================================================================================
 * 좌석선택 > 이전화면
 */

function closeseat(){
	//좌석 해제하고 뒤로가자
	$("#SeatFlashArea").css("display", "none");
	$("#ContentsArea").css("display", "block");
	$("#StateBoard").css("display", "block");
	$("#header").css("display", "block");
}

/*===================================================================================
 * 좌석선택 > 좌석 다시선택
 */
function ChoiceReset(){
	
	//좌석표 다시 불러오기
	getMap();
	
	//선택한 좌석 비우기
	$("#liSelSeat").empty();
}

/*===================================================================================
 * 좌석선택 > 좌석선택 완료
 */
function ChoiceEnd(){
	var isChoiced = false;
	$("div.act").each(function(){
		if($(this).hasClass("son")){
			isChoiced = true;
			return false;
		}
	});
	
	if(!isChoiced){
		window.alert("좌석을 선택해 주세요");
	}else{
		$(".gnb li").removeClass("on");
		$(".gnb li.m03").addClass("on");
		$("#header").css("display", "block");
		$("#ContentsArea").css("display", "block");
		$("#step01").css("display", "none");
		$("#step03").css("display", "block");
		$("#StepCtrlBtn01").css("display", "none");
		$("#StepCtrlBtn03").css("display", "block");
		$("#StateBoard").css("display", "block");
		$("#SeatFlashArea").css("display", "none");
		
		//선택내역의 매수 지정
		var tksize = $("#liSelSeat > p").size();
		$("#tk_count").text(tksize+"매");
		//선택내역의 좌석 지정
		$("#tk_seat").empty().append($("#liSelSeat").clone());
		//결제내역의 금액 지정
		var price = 0;
		var v = "";
		var r = "";
		var s = "";
		$("#tk_seat p").each(function(){
			var grade = $(this).attr("grade");
			
			//선택한 좌석 중 존재하는 등급에 따라 가격정하고
			//할인선택의 좌석 등급에 등급 라디오 버튼 만들기
			
			switch(grade){
				case "VIP석":
					v = "<input type='radio' name='rdoPromotionSeat' value='VIP석' " +
							"classbyte='' onclick='PromotionView(this);'><label>VIP석</label>";
					price += 143000;
					break;
				case "R석":
					r = "<input type='radio' name='rdoPromotionSeat' value='R석' " +
					"classbyte='' onclick='PromotionView(this);'><label>R석</label>";
					price += 133000;
					break;
				case "S석":
					s = "<input type='radio' name='rdoPromotionSeat' value='S석' " +
					"classbyte='' onclick='PromotionView(this);'><labal>S석</label>";
					price += 111000;
					break;
			}
		});
		
		$("#spanPromotionSeat").append(v+r+s);
		//제일 앞에 있는 값 selected 해놓기
		$("input[name='rdoPromotionSeat']:eq(0)").attr("checked", "ture");
		PromotionView($("#spanPromotionSeat > input:eq(0)"));
				
		$(".pay_infor .tk_price > span").text(comma(price));
		$(".pay_infor .tk_charge > span").text(comma(1000*tksize));
		
		$(".pay_infor .tk_sumplus > span").text(comma(1000*tksize+price));
		$(".t_result").text(comma(1000*tksize+price));
	}
}

/*===================================================================================
 * 등급별로 가격선택 테이블 만들기
 */
function PromotionView(obj){
	
	var grade = $(obj).val();
	var price = 0;
	
	switch(grade){
	case "VIP석":
		price = 143000;
		break;
	case "R석":
		price = 133000;
		break;
	case "S석":
		price = 111000;
		break;
	}
	var tknum = $("#liSelSeat > p[grade='"+grade+"']").size()/2;
	//해당하는 좌석 등급의 가격선택 테이블 보이기
	var tknumop = "";
	for(var tk=0; tk <= tknum; tk++){
		tknumop += "<option value='"+tk+"'>"+tk+"매</option>";
	}
	var str = " <div classbyte=''>"+
               "<table id='tblPromotionGroup1' border='0' cellpadding='0' summary='선택한 좌석등급에 사용할 수 있는 할인 목록' cellspacing='0' class='sale_table' grpno='1' grpseq='0' cusselseatcnt='1'>"+
               "<caption>할인리스트</caption>"+
                    "<colgroup><col width='55%'><col width='15%'><col width='20%'><col width='10%'></colgroup>"+
               		"<thead><tr>"+
                            "<th scope='col' style='text-align:left;padding-left:10px;'>가격 선택</th>"+
                            "<th scope='col'>판매금액</th>"+
                            "<th scope='col'>매수</th>"+
                            "<th scope='col'>설명</th>"+
                        "</tr>"+
                    "</thead><tr><td class>일반 정가<br></td>"+"<td>"+comma(price)+"</td>"+
		    "<td>"+"<select id='selPromotion0' amount='0' onchange='PreCheckPromotion('0','0','0','T','F',1,1,this);'>"+
			    tknumop+"</select>"+"</td>"+"<td>&nbsp;</td></tr></tbody></table>";
	
	$("#tblPromotionGroup1 tbody").append(str);
}