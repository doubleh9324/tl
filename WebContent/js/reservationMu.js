/*===================================================
 * 브라우저 종료시 선택한 좌석이 있는 상태인 경우 application 영역에서 삭제해주기
 */

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
		var id1 = $("#step01_date").attr("style");
		var id2 = $("#ContentsArea").attr("style");
		var step1 = id1.match(/block/g);
		var step2 = id2.match(/none/g);
		
		if(step1 != null || step2 != null){
			removeLocalInfo();
		}
	
	 });
	 
	} 

//application 영역의 선택된 좌석 제거
function removeLocalInfo(){
		
		
	var pcode = $("#pcode").val();
	var munum = $("#munum").val();
	var screen_name = $("#ptheatername").attr("screen_name");
	var viewdate = $("#ulTime li.on").attr("cancelclose");
	var seat = "";
	
	var returnFlag = "";
	$("#liSelSeat p").each(function(){
		seat += $(this).attr("id")+" ";
	});
	
	jQuery.ajax({
        type:"POST",
        url:"./deleteCheckedSeatInfo.rs",
        async : false,
        data:"pcode="+pcode+"&m_num="+munum+"&screen_name="+screen_name+"&viewdate="+viewdate+"&seat="+seat,
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


/*===============================================================
 * 페이지 로딩이 완료되면
 */
 
$(document).ready(function(){
	
	//달력 구현하기
	calendars(0);
	setPlayDay();
	
});

function setPlayDay(){
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
}


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
	// TODO
	var date = event.currentTarget.id;
	getRounds(date, "date");
	
	}
}


//해당 날짜의 회차 가져오기
function getRounds(dateStr, flag){
	
	var round = "";
	var munum = $("#munum").val();
	var date = dateStr;
	var classOn = "";
	var i=1;
	var seats = "";
	var ptime;
	var selectround = "<option cancelclose='0' >회차 선택</option>";
	
	
	jQuery.ajax({
        type:"POST",
        url:"./getTimeSeat.rs",
        data:"munum="+munum+"&date="+date,
        dataType:"JSON",
        success : function(data) {
        	//data.timeseatList
        	
        	//회차 띄우기
        	timeseat = data.timeseatList;
        	
        	var rcount = 1;
    		$.each(data.timeseatList, function(key, value){
    			ping_num = value.ping_num;
    			//ptime = value.ptime;
    			
            	if(data.timeseatList.length/3 == 1){
            		classOn = "on";
            	}else{
            		classOn = "";
            	}
            	
            	seats += "<li><strng>"+value.seatclass+"석 </strong>"+comma(value.price)+"원 (잔여:<span class='red'>"+value.remained+"석</span>)</li>";
    			//새로운 회차일 때 마다 추가하기
    			if(i%3 == 0){
    			ptime = "["+rcount+"회] "+value.ptime;
    			
    			round += "<li id=round"+rcount+" timeoption=''"+" idhall=''"+" seatviewmode=''"+" saleclose='"+date
    				+"' cancelclose='"+date+" "+value.ptime+"' limitcussalecnt= ''"
    				+" limittimesalecnt=''"+" timeinfo='"+value.ptime+"' class='"+classOn+"'>["+rcount+"회] "+value.ptime+"</li>";
    			selectround += "<option id=rounds"+rcount+" value=round"+rcount+" timeoption=''"+" idhall=''"+" seatviewmode=''"+" saleclose='"+date
				+"' cancelclose='"+date+" "+value.ptime+"' limitcussalecnt= ''"
				+" limittimesalecnt=''"+" timeinfo='"+value.ptime+"' class='"+classOn+"'>["+rcount+"회] "+value.ptime+"</option>";
    			rcount++;
    			}
    			i++;
    		});
    		
    		//좌석선택 상단바에 select box 회차 추가
    		$("#selFlashTime").empty();
        	$("#selFlashTime").append(selectround);
        	
    		if(data.timeseatList.length/3 == 1){
            	//잔여석
            	$("#ulSeatSpace").empty();
            	$("#ulSeatSpace").append(seats);
            	
            	if(flag == "date"){
            		$("#rounds1").attr("selected", "true");
            	}
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
var tempmonth = 0;
function calendars(move){
	
	//move == 0 오늘에 해당하는 달
	//move == -1 이전 달
	//move == 1 다음달

	
	//일 수 붙일 tbody 
	var addDays = $("#addCalendar");
	addDays.empty();
	var nowDate = new Date();//오늘 날짜 객체 선언
	
	if(move == 0){
		//첫 화면에서 조회된거면 현재 날짜의 달로 지정
		//다음달에 티켓팅이 있다면.... (말잇못
		tempmonth = nowDate.getMonth();
	}
	
	var moveDate = new Date();
	tempmonth += move*1 ;
	nowDate.setMonth(tempmonth);
	
    var nYear = nowDate.getFullYear();      //오늘의 년도  
    var nMonth = nowDate.getMonth() ;       //오늘의 월 ※ 0월부터 시작  
    var nDate = nowDate.getDate();           //오늘의 날  
    var nNumday = nowDate.getDay();         //오늘의 요일 0=일요일...6=토요일  
    var endDay=new Array(31,28,31,30,31,30,31,31,30,31,30,31);      //각달의 마지막 날짜  
    var dayName=new Array("일", "월", "화", "수", "목", "금", "토"); // 숫자 요일을 문자 요일 바꿀 함수  
    var col=0;  //요일을 이용해서 나중에 앞뒤 빈 날짜칸 계산   
    var eDate= new Date(nYear,nMonth,1);       // 1일의 숫자 요일을 구하기 위해서날짜 객체 선언  
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

        //년.월.일 위에 표시하기
        $("#calendar .cal_selectDay span").text(nYear+". "+month);
}

function movePrevMonth(){
	calendars(-1);
	setPlayDay();
}

function moveNextMonth(){
	calendars(1);
	setPlayDay();
}

/*===============================================================================================
 * 좌석 선택 단계로 이동하기
 */
 
function ChoiceSeat(){
	
	//날짜, 회차 선택되어있는지 확인하고 넘어가기
	var re = false;
	
	$("#ulTime li").each(function(){
		if($(this).hasClass("on")){
			re=true;
			return false;
		}
	});
	
	if(re){
		$("#header").css("display", "none");
		$("#ContentsArea").css("display", "none");
		$("#StateBoard").css("display", "none");
		$("#SeatFlashArea").css("display", "block");
	
		//좌석표 뿌리기
		getMap();
		//예매 불가능한 좌석 매핑
		getReservedSeat();
		//다른 사람이 선택중인 좌석 매핑
		checkSelectedSeat();
	}else{
		window.alert("날짜, 회차를 선택해주세요.");
	}
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
	
	var round = thisId.substring(5,6);
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
	$("option[id=rounds"+round+"]").attr("selected", "true");
	
	//선택내역 시간 표시
	$("#tk_time").html($(this).text());
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
        url:"./getReservedSeatMu.rs",
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
	
	$(".gnb li").removeClass("on");
	$(".gnb li.m01").addClass("on");
	$("#step01").css("display", "block");
	$("#step03").css("display", "none");
	$("#StepCtrlBtn01").css("display", "block");
	$("#StepCtrlBtn03").css("display", "none");
	
	//선택내역, 결제내역 초기화
	$("#tk_count").text("");
	$("#tk_seat").empty().append("<p>좌석 지정 회차입니다</p>");
	
	$("#liSelSeat").empty();
	
	$(".pay_infor .tk_price > span").text("0");
	$(".pay_infor .tk_charge > span").text("0");
	
	$(".pay_infor .tk_sumplus > span").text("0");
	$(".t_result").text("0");
}

/*===================================================================================
 * 좌석선택 > 좌석 다시선택
 */
function ChoiceReset(){
	ChoiceSeat();
	checkSelectedSeat();
	//좌석표 다시 불러오기
	//getMap();
	//getReservedSeat();
	//선택한 좌석 비우기
	//$("#liSelSeat").empty();
}

function checkSelectedSeat(){
	
	//선택한 좌석이 예매 가능한 좌석인지 확인
	//TODO
	
	var pcode = $("#pcode").val();
	var munum = $("#munum").val();
	var screen_name = $("#ptheatername").attr("screen_name");
	var viewdate = $("#ulTime li.on").attr("cancelclose");
	var seat = "";
	
	var returnFlag = "";
	$("#liSelSeat p").each(function(){
		seat += $(this).attr("id")+" ";
	});
	
	var len = seat.length;
	if(len == 0)
		seat = "0";
	else
		seat = seat.substring(0,len-1);
	
	jQuery.ajax({
        type:"POST",
        url:"./checkedSeat.rs",
        async : false,
        data:"pcode="+pcode+"&m_num="+munum+"&screen_name="+screen_name+"&viewdate="+viewdate+"&seat="+seat+"&flag=mu",
        dataType:"JSON",
        success : function(data) {
        	//data.checkFlag == n 이면 통과 아니면 다시 선택
        	
        	if(data.checkedFlag == "f"){
        		returnFlag =  "f";
        		//첫 좌석창 조회, 예매중인 좌석도 없음
        	}else if(data.checkedFlag == "y"){
        		returnFlag =  "y";
        		
        		window.alert("이미 선택된 좌석입니다.");
        		getMap();
        		getReservedSeat();
        		//선택한 좌석 비우기
        		$("#liSelSeat").empty();

        		//선택중인 좌석 표시하기
        	}else if(data.checkedFlag == "n"){
        		returnFlag =  "n";
        		
        		if(data.checkedSeats.length>0){
            		$.each(data.checkedSeats, function(key, value){
            			
                		var seat_bl = value.seat_bl;
                		var seat_no = value.seat_no;
                		$("#divSeatArray div").each(function(i){
                			if($(this).attr("id") == seat_no){
                				//예약되어있는 좌석의 class를 가져와서 act 클래스 빼주고  title 제거
                				if($(this).hasClass("act")){
                					$(this).removeClass("act").attr("title", "").addClass("s13");
                				}
                			}
                		});
                	});
            	}
        	}
        	

        },
        complete : function(data) {
              // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        },
        error : function(xhr, status, error) {
              alert("checkedSeat date 에러발생");
        }
 	 });
	
	return returnFlag;
	
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
		
		//선택한 좌석이 예매 가능한 좌석인지 확인
		//TODO
		var returnFlag = checkSelectedSeat();
	
        	if(returnFlag == "y"){
            	
        	}else if(returnFlag == "n"){
        		
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
        		$("#tk_count").attr("tksize", tksize);
        		//선택내역의 좌석 지정
        		$("#tk_seat").empty().append($("#liSelSeat > p").clone());
        		//결제내역의 금액 지정
        		var price = 0;
        		var v = "";
        		var r = "";
        		var s = "";
        		var vn=1;
        		var rn =1;
        		var sn = 1;
        		$("#tk_seat p").each(function(){
        			var grade = $(this).attr("grade");
        			
        			//선택한 좌석 중 존재하는 등급에 따라 가격정하고
        			//할인선택의 좌석 등급에 등급 라디오 버튼 만들기
        			
        			switch(grade){
        				case "VIP석":
        					v = "<input type='radio' name='rdoPromotionSeat' value='VIP석' " +
        							"classbyte='' onclick='PromotionView(this);'><label>VIP석</label>";
        					price += 143000;
        					do{PromotionCraete(grade); vn=-3}while(vn>1);
        					break;
        				case "R석":
        					r = "<input type='radio' name='rdoPromotionSeat' value='R석' " +
        					"classbyte='' onclick='PromotionView(this);'><label>R석</label>";
        					price += 133000;
        					do{PromotionCraete(grade); rn=-2}while(rn>1);
        					break;
        				case "S석":
        					s = "<input type='radio' name='rdoPromotionSeat' value='S석' " +
        					"classbyte='' onclick='PromotionView(this);'><labal>S석</label>";
        					price += 111000;
        					do{PromotionCraete(grade); sn=-1}while(sn>1);
        					break;
        			}
        			
        		});
        		
        		$("#spanPromotionSeat").empty().append(v+r+s).trigger("create");
        		//제일 앞에 있는 값 selected 해놓기
        		$("input[name='rdoPromotionSeat']:eq(0)").attr("checked", "ture");
        		
        		var re = (vn < rn) ? "V" : ((rn < sn) ? "R" : "S" );
        		$("#PromotionGroup"+re).parent().css("display", "block");
        				
        		$(".pay_infor .tk_price > span").text(comma(price));
        		$(".pay_infor .tk_charge > span").text(comma(1000*tksize));
        		
        		$(".pay_infor .tk_sumplus > span").text(comma(1000*tksize+price));
        		$(".t_result").text(comma(1000*tksize+price));
        		
        		
        	}
		
	}
}


/*===================================================================================
 * 등급별로 가격선택 테이블 만들기
 */
function PromotionCraete(grade){
	
	var price = 0;
	var g = "";
	switch(grade){
	case "VIP석":
		g = "V";
		price = 143000;
		break;
	case "R석":
		g = "R";
		price = 133000;
		break;
	case "S석":
		g = "S";
		price = 111000;
		break;
	}
	
	
	var tknum = $("#liSelSeat > p[grade='"+grade+"']").size();
	//해당하는 좌석 등급의 가격선택 테이블 보이기
	var tknumop = "";
	for(var tk=0; tk <= tknum; tk++){
		tknumop += "<option value='"+tk+"'>"+tk+"매</option>";
	}
	var str = " <div classbyte='' style='display:none;'>"+
				    "<table id='PromotionGroup"+g+"' border='0' cellpadding='0' summary='선택한 좌석등급에 사용할 수 있는 할인 목록' cellspacing='0' class='sale_table' grpno='1' grpseq='0' cusselseatcnt='1'>"+
				    "<caption>할인리스트</caption>"+
                    "<colgroup><col width='55%'><col width='15%'><col width='20%'><col width='10%'></colgroup>"+
               		"<thead><tr>"+
                            "<th scope='col' style='text-align:left;padding-left:10px;'>가격 선택</th>"+
                            "<th scope='col'>판매금액</th>"+
                            "<th scope='col'>매수</th>"+
                            "<th scope='col'>설명</th>"+
                        "</tr>"+
                    "</thead><tr><td class>일반 정가<br></td>"+"<td>"+comma(price)+"</td>"+
		    "<td>"+"<select name='selPromotion' amount='0'>"+
			    tknumop+"</select>"+"</td>"+"<td>&nbsp;</td></tr></tbody></table></div>";
	
	$("#divPromotionList").append(str);
}

/*===================================================================================
 * 등급별로 가격선택 테이블 만들기
 */
function PromotionView(obj){
	
	var grade = $(obj).val();
	switch(grade){
	case "VIP석":
		grade = "V";
		break;
	case "R석":
		grade = "R";
		break;
	case "S석":
		grade = "S";
		break;
	}
	
	$("#divPromotionList > div").css("display", "none");
	$("#PromotionGroup"+grade).parent().css("display", "block");
}

/*===================================================================================
 * 이전단계
 */

function GoPrevStep(event){
	
	//누른 곳 현재 단계
	var id = $(event.currentTarget).parent().attr("id");
	var step3 = id.match(/03/g);
	var step4 = id.match(/04/g);
	var step5 = id.match(/05/g);
	
	if(step3!= null){
		//현재가 3단계, 좌석 선택으로 돌아가기
		$(".gnb li").removeClass("on");
		$(".gnb li.m03").addClass("on");
		$("#header").css("display", "none");
		$("#ContentsArea").css("display", "none");
		$("#StepCtrlBtn03").css("display", "none");
		$("#StateBoard").css("display", "none");
		$("#SeatFlashArea").css("display", "block");
	}else if(step4!=null){
		//현재 4단계, 할인 선택으로 돌아가기
		$(".gnb li").removeClass("on");
		$(".gnb li.m03").addClass("on");
		$("#StepCtrlBtn03").css("display", "block");
		$("#StepCtrlBtn04").css("display", "none");
		$("#step03").css("display", "block");
		$("#step04").css("display", "none");
	}else if(step5!=null){
		//현재 5단계, 수령 방법 선택으로 돌아가기
		$(".gnb li").removeClass("on");
		$(".gnb li.m04").addClass("on");
		$("#StepCtrlBtn04").css("display", "block");
		$("#StepCtrlBtn05").css("display", "none");
		$("#step04").css("display", "block");
		$("#step05").css("display", "none");
	}
}

/*===================================================================================
 * 할인 선택 완료
 */
function PromotionEnd(){
	//매수 선택 확인 할 것
	var isTkchoiced = false;
	var sum = 0;
	$("select[name='selPromotion'] > option:selected").each(function(){
		sum += $(this).attr("value")*1;
	});
	
	if(sum == $("#liSelSeat > p").size()){
		
		// 필요한거 키고, 끄고
		$(".gnb li").removeClass("on");
		$(".gnb li.m04").addClass("on");
		$("#step03").css("display", "none");
		$("#step04").css("display", "block");
		$("#StepCtrlBtn03").css("display", "none");
		$("#StepCtrlBtn04").css("display", "block");
		
		//주문자 확인 창에 정보 띄우기
		$("#ordererUserName").val($("#mname").val());
		var phone = $("#phone").val();
		$("#ordererMobile1").val(phone.substring(0,3));
		$("#ordererMobile2").val(phone.substring(4,8));
		$("#ordererMobile3").val(phone.substring(9,13));
		var email = $("#id").val();
		$("#ordererMailH").val(email.split('@', -1));
		$("#ordererMailD").val(email.split('@', 1));
		
		
	}else{
		window.alert("매수를 선택해주세요");
	}
}

/*===================================================================================
 * 수령방법선택
 */
function DeliveryMethodChange(obj){
	var method = $(obj).attr("value");
	
	if(method == "direct"){
		
		$("#step04_DeliveryInfo").css("display", "none");
		$(".pay_infor .tk_deli > span").text("0");
		var price = uncomma($(".pay_infor .tk_sumplus > span").text())*1-2500;
		$(".pay_infor .tk_sumplus > span").text(comma(price));
		$(".t_result").text(comma(price));
		
	}else if(method == "delivery"){
		
		//배송 선택시 배송비 추가
		$("#step04_DeliveryInfo").css("display", "block");
		var delprice = $(obj).attr("price")*1;
		$(".pay_infor .tk_deli > span").text(comma(delprice));
		var price = uncomma($(".pay_infor .tk_sumplus > span").text())*1;
		$(".pay_infor .tk_sumplus > span").text(comma(price+delprice ));
		$(".t_result").text(comma(price+delprice ));
	}
}

/*===================================================================================
 * 배송지 정보   radio 버튼 선택
 */

function DisplayUserInfo(obj){
	
	//받아온 객체의 id(deliveryInfoTypeN)으로 판단
	var thisId = $(obj).attr("id");
	
	
	if(thisId == "deliveryInfoType0"){
		//주문자 정보와 동일
		$("#deliveryUserName").val($("#ordererUserName").val());
		
		$("#deliveryMobile1").val($("#ordererMobile1").val());
		$("#deliveryMobile2").val($("#ordererMobile2").val());
		$("#deliveryMobile3").val($("#ordererMobile3").val());
		
		//DB에서 기본 배송지로 선택된 주소가 있으면 불러오기
		jQuery.ajax({
	        type:"POST",
	        url:"./getDefaultAddress.rs",
	        data:"mnum="+$(".mnum").val(),
	        dataType:"JSON",
	        success : function(data) {
	        	//받아온 데이터가 있으면 표시, 없으면 그냥 두기
	        	if(data.de == "n"){
	        		window.alert("설정된 기본 배송지가 없습니다.");
	        	}else if(data.de == "y"){
	        		$("#deliveryZipCode").val(data.defaultAdd.post_code);
	    			$("#deliveryAddress1").val(data.defaultAdd.address);
	    			$("#deliveryAddress2").val(data.defaultAdd.add_detail);
	        	}
	        },
	        complete : function(data) {
	        },
	        error : function(xhr, status, error) {
	              alert("에러발생");
	        }
	 	 });
		
	}else if(thisId == "deliveryInfoType1"){
		//최근 배송지 선택
		$("#newDelivery").attr("value", "n");
		window.open("./getLatestAddress.rs?mnum="+$(".mnum").val(),"","width=497, height=367, toolbar=no, menubar=no, scrollbars=no, resizable=no");
	}else if(thisId == "deliveryInfoType2" || thisId == "btnSearchAddress"){
		
		//우편번호 찾기 버튼 클릭시 새로 입력 checked 설정
		if(thisId == "btnSearchAddress"){
			$("#deliveryInfoType2").attr("checked", "checked");
			$("#step04_DeliveryInfo > ul > li:eq(2) > input").val("");
			$("#step04_DeliveryInfo > ul > li:eq(3) > input").val("");
			
			//주소 검색 후 창 바로 종료 안되는 부분 수정 할 것
		}else{
			//새로 입력
			$("#step04_DeliveryInfo > ul > li > input").val("");
			$("#newDelivery").attr("value", "y");
		}

	}
}

/*===================================================================================
 * 배송지 완료, 다음 단계
 */
function DeliveryEnd(){
	
	//배송선택인데 배송지란이 채워져 있지 않을 경우 체크
	var re = true;
	if($("#rdoDelivery8").is(":checked")){
		$("#step04_DeliveryInfo > ul > li input").each(function(){
			if(!($(this).val().length > 0)){
				re = false;
				return false;
			} 
		});
	}
	
	
	if(re){
		
		// 필요한거 키고, 끄고
		$(".gnb li").removeClass("on");
		$(".gnb li.m05").addClass("on");
		$("#step04").css("display", "none");
		$("#step05").css("display", "block");
		$("#StepCtrlBtn04").css("display", "none");
		$("#StepCtrlBtn05").css("display", "block");
		
		//취소기한 지정
		var date = new Date($("#tk_day").text());
		var year = date.getYear()+1900;
		var month = date.getMonth()+1;
		var day = date.getDate();
		var maxDate = year+"년 "+(month)+"월 "+(day-1)+"일 17시 00분 까지";
		
		$("#lblCancelTimeInfo div span").text(maxDate);
		
		// 예매일과 공연일 사이의 날짜 수 세기
		var today = new Date();
		var daygap = date.getDate() - today.getDate();
		
		var sday = new Date();
		var eday = new Date();
	
		var str = "";
		
		if(daygap > 13){
			//미부과 기간부터 5개 출력
			sday.setDate(date.getDate()-20);
			eday.setDate(date.getDate()-13);
			str = "<tr><td>미부과 기간</td><td>"+setDateStr(sday)+" ~ "+setDateStr(eday)+"</td><td>없음</td></tr>";
		}
		if(daygap > 10){
			sday.setDate(date.getDate()-12);
			eday.setDate(date.getDate()-10);
			str += "<tr><td></td>예매후 8일 ~ 관람일 10일 전까지<td>"+setDateStr(sday)+" ~ "+setDateStr(eday)+"</td><td>장당 4000원 부과<br>(티켓금액의 10% 한도)</td></tr>";
		}
		if(daygap > 7){
			sday.setDate(date.getDate()-9);
			eday.setDate(date.getDate()-7);
			str += "<tr><td>관람일 9일전 ~관람일 7일전까지</td><td>"+setDateStr(sday)+" ~ "+setDateStr(eday)+"</td><td>티켓금액의 10%</td></tr>";
		}
		if(daygap > 3){
			sday.setDate(date.getDate()-6);
			eday.setDate(date.getDate()-3);
			str += "<tr><td>관람일 6일전 ~관람일 3일전까지</td><td>"+setDateStr(sday)+" ~ "+setDateStr(eday)+"</td><td>티켓금액의 20%</td></tr>";
		}
		if(daygap > 1){
			sday.setDate(date.getDate()-2);
			eday.setDate(date.getDate()-1);
			str += "<tr><td>관람일 2일전 ~취소마감시까지</td><td>"+setDateStr(sday)+" ~ "+setDateStr(eday)+"</td><td>티켓금액의 30%</td></tr>";
		}
		
		$(".tbl_commission tbody").append(str);
	}else{
		window.alert("배송지 정보를 정확하게 입력해주세요.");
	}
	
}

//날짜 형태 만들어주기
function setDateStr(date){
	
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	
	var endDay=new Array(31,28,31,30,31,30,31,31,30,31,30,31); 
		
	if(day.length == 1){
		day = "0" + day;
	}
	
	if(month.length == 1){
		month = "0" + month;
	}
	
	return year+"."+month+"."+day;
	
}

/*===================================================================================
 * step5 포인트 사용
 */
function PointUseChange(obj){
	var use = $("#txtMileageUse1").val()*1;
	var point = $("#spanMileageTxt1 .red").text()*1;
	var price = uncomma($(".tk_sumplus span").text())*1;
	var reprice = price - use;
	
	if(use >point ){
		use = point;
		$("#txtMileageUse1").val(use);
		reprice = price - point
	}else if(use>price && use<point){
		use = price;
		$("#txtMileageUse1").val(use);
	}
	$(".tk_disc span").text(comma(use));
	$(".tk_summinus span").text(comma(use));
	
	//최종 금액에 적용
	if(reprice>0){
		$(".t_result").text(comma(reprice));
	}else{
		$(".t_result").text('0');
	}
	
	
}


/*===================================================================================
 * 결제하기 버튼
 */
function PrePayCheck(){
	//약관 동의, 은행 선택 체크 후 결제하기
	var re1 = $("#cbxCancelFeeAgree").is(":checked");
	var re2 = $("#cbxTermAgree").is(":checked");
	var re3 = $("#selBank option:selected").attr("value") > 0 ? true:false;
	
			
	if(re1 && re2 && re3){
		$("#ContentsArea").css("display", "none");
		$("#StateBoard").css("display", "none");
		$("#header").css("display", "none");
		$("#step05").css("display", "none");
		$("#StepCtrlBtn05").css("display", "none");
		
		$("#SuccessBoard").css("display", "block");
		
		//DB에 결제 정보 넣기 전 한번 더 예약된 좌석 확인하기
		
		var mnum = $(".mnum").val();
		var munum = $("#munum").val();
		var pingnum = $("#pingnum").val();
		var screen_name = $("#ptheatername").attr("screen_name");
		var price = uncomma($(".t_result").text());
		var viewdate = $("#ulTime li.on").attr("cancelclose");
		var seat_no = $("#tk_count").attr("tksize");
		var seat = ""; 
		var usepoint = uncomma($(".tk_disc span").text());
		var payinfo = $("#selBank option:selected").text();
		var grade = "";
		
		$("#tk_seat p").each(function(){
			seat += $(this).attr("id")+" ";
			grade += $(this).attr("grade")+" ";
		});
		
		//DB에 정보 넣기
		jQuery.ajax({
	        type:"POST",
	        url:"./makeMuReservation.rs",
	        data:"mnum="+mnum+"&mu_num="+munum+"&pingnum="+pingnum+"&screen_name="+screen_name+"&price="+price
	        		+"&viewdate="+viewdate+"&seat_no="+seat_no+"&seat="+seat+"&usepoint="+usepoint+"&payinfo="+payinfo+"&grade="+grade,
	        dataType:"JSON",
	        success : function(data) {
	        	//data.reservation 받아오기
	        	$("#bk_bookno").text(data.reservation.r_num);
	        	$("#bk_tkcount").text($("#tk_count").text());
	        	$("#bk_perfname").text($("#ptitle a").text());
	        	$("#bk_theatername").text($("#ptheatername a").text());
	        	$("#bk_viewtime").text($("#tk_day").text() + " "+ $("#tk_tike").text());
	        	$("#bk_tkseat").append($("#tk_seat p").clone());
	        	
	        	
	        	var tkm = $("input[name=rdoDelivery]:checked").val();
	        	if(tkm=="direct"){
	        		$("#bk_deliveryinfo").text("현장수령");
	        	}else{
	        		$("#bk_deliveryinfo").text("일반배송");	
	        	}
	        	
	        	$(".tk_price span").text()
	        	$(".tk_charge span").text()
	        	$(".tk_deli span").text();
	        	$(".tk_sumplus span").text();
	        	
	        	$("#sp_tkprice").text($(".tk_price span").text());
	        	$("#sp_charge").text($(".tk_charge span").text());
	        	$("#sp_deli").text($(".tk_deli span").text());
	        	$("#sp_sumplus").text($(".tk_sumplus span").text());
	        	
	         	$("#sp_disc").text($(".tk_disc span").text());
	        	$("#sp_coupon").text($(".tk_coupon span").text());
	        	$("#sp_otherpays").text($(".tk_otherpays span").text());
	        	$("#sp_sumninus").text($(".tk_summinus span").text());
	        	$("#sp_result").text($(".t_result").text());
	        	
	        	
	        	$("#bk_canceltimeinfo").text($("#lblCancelTimeInfo div.box span.red").text());
	        },
	        complete : function(data) {
	        },
	        error : function(xhr, status, error) {
	              alert("makeMuReservation 에러발생");
	        }
	 	 });
		//새로 입력한 주소가 있을 경우 이 주소를 DB에 저장하기
		if($("#newDelivery").val() == "y"){
			
			var postcode = $("#deliveryZipCode").val();
			var address = $("#deliveryAddress1").val();
			var add_detail = $("#deliveryAddress2").val();
			
			jQuery.ajax({
		        type:"POST",
		        url:"./insertAddress.me",
		        data:"mnum="+$(".mnum").val()+"&postcode="+postcode+"&address="+address+"&add_detail="+add_detail,
		        dataType:"JSON",
		        success : function(data) {
		        },
		        complete : function(data) {
		        },
		        error : function(xhr, status, error) {
		              alert("insertAddress 에러발생");
		        }
		 	 });
		}
		
		//예매 확인 내역 표시하기
		
	}else{
		if(re1 && re2)
			window.alert("은행을 선택해주세요.");
		else if(re3)
			window.alert("약관에 동의해주세요.")
	}
}


function selFlashDateAllChange(dateStr){
	//좌석선택 단계 날짜 변경
	//select box의 value값 = 날짜를 매개변수로 받아오기
	
	//첫 페이지의 선택된 날짜도 다시 설정
	$(".dcursor").parent().removeClass("term");
	$("#"+dateStr).parent().addClass("term");
	
	//회차 선택의 선택 날짜 띄우기
	$(".select_day > .tit").next().text(dateStr);
	
	//선택 내역의 선택 날짜 띄우기
	$("#tk_day").text(dateStr);
	
	getRounds(dateStr, "seat");
	$("#divGuide").css("display", "none");
}

function SelFlashTimeChange(roundid){
	//선택한 날짜에  on 클래스 추가해주기
	if(roundid != 0){
		//선택한 좌석이 있다면 없애기
		$("#liSelSeat").empty();
		//첫 페이지의 선택 내용 수정
		$("#ulTime li").removeClass("on");
		$("#"+roundid).addClass("on");
		//선택내역 시간 표시
		$("#tk_time").html($("#"+roundid).text());
		
		$("#divGuide").css("display", "block");
		getMap();
		getReservedSeat();
	}
}

function PopupCouponRegister(){
	window.alert("서비스 준비중입니당 ^0^/**")
}

//예매내역 확인 페이지로 이동
$(document).on("click", "#imgGoTicketView", function(){
	opener.document.location="./MemberReservation.me";
	window.close();
});
