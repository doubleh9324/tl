<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head id="ctl00_Head1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="No-Cache" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="keywords" content="CGV, 시지브이, 영화관, 극장, 영화, 티켓, 박스오피스, 극장, Movie, Theater, Cinema, Cgv, cgv, 예매, 상영작" />
<meta name="description" content="영화 그 이상의 감동. CGV" />
<title>TicketLion 영화예매</title>
<link rel="stylesheet" href="reserMu2.css">
<link rel="stylesheet" href="reserMu.css">
<link rel="stylesheet" href="reserve_seat.css">
<link rel="stylesheet" href="PerfSale.css">

<link rel="stylesheet" href="http://img.cgv.co.kr/CGV_RIA/Ticket/Common/css/2017/06/CGV_YS/reservation_popup.css" />
<link rel="stylesheet" href="http://img.cgv.co.kr/CGV_RIA/Ticket/Common/css/2017/06/CGV_YS/reservation_step3_special.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript" src="js/reservationMu.js"></script>
<script for="window" event="onunload" language="javascript">
browser_Event();
</script>


</head>

<body>
<% 
	String id= (String)session.getAttribute("id");
	
	if(id==null){
%>
	<script>
		alert("로그인해주세요.");
		window.close();
	</script>
<%}else{
	int member_num=(int)session.getAttribute("member_num");
	%>
	<input type="hidden" value="<%=member_num%>" class="mnum">
<% }%>

<form name="baseForm" method="post" action="PerfSaleProcess.aspx?IdPerf=32966&amp;IdTime=660175" id="baseForm">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE2NTMwNjQ3OTNkZCGym67a+L9N/u3OWe+AcE6fbNuPGNdmXcl5Op+Nmtcj">
<input type="hidden" id="munum" value="${musical.musical_num }">
</div>

        <div id="progressBar" style="width: 300px; display: none; position: absolute; left: 345.747px; top: 297.955px; z-index: 2000;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="10" intervalid=""><div class="ui-progressbar-value ui-widget-header ui-corner-left" style="width: 10%;"></div></div>
        <script type="text/javascript">
       //     $j("#progressBar").jry_home_ShowProgressBar({ "state": "start" });
        </script>
        <div id="dialogPayProgress" style="display:none;"></div>
        <div id="dialogNoticeAlert" style="display:none;"></div>
        <div id="dialogAlert" style="display:none;"></div><div id="dialogConfirm" style="display:none;"></div><div id="dialogPopup" style="display:none;"></div>
        <div id="divSCISendForm" style="display:none;"></div>
        
        
        
        <!-- UI 영역 START -->
        <div id="warp">
            <div id="all" style="display: block;">
                <!--상단메뉴 -->
                <div id="header" class="header">
                    <h1><img src="http://image16.hanatour.com/img/perfsale/h1_tit.gif" alt="hanatour.com"></h1>
                    <ul class="gnb">
                        <li class="m01 on"><span>관람일/회차</span></li>
                        <li class="m02"><span>좌석선택</span></li>
                        <li class="m03"><span>할인/쿠폰</span></li>
                        <li class="m04"><span>수령방법</span></li>
                        <li class="m05"><span>결제방법</span></li>
                    </ul>
                </div>
                <!--//상단메뉴 -->
                <!-- 내용컨탠츠 -->
                <div id="ContentsArea" class="container" style="display: block;">
                    <!-- 제 1 단계 : 관람일/회차 -->
                    <div id="step01">
                        <!-- 관람일선택 -->
                        <div id="step01_date" class="step01_date" style="display: block;">
                            <h2><img src="http://image16.hanatour.com/img/perfsale/h2_tit01.gif" alt="관람일선택"></h2>
                            <div id="calendar" class="calendar">
                            <p class="fr">
                            <img id="imgTodaySale" src="http://image16.hanatour.com/img/perfsale/btn_day_reserv.gif" alt="당일예매" style="display:none;">
                            </p>
                            <div class="cal_selectDay">
                            <a class="pre dcursor" onclick="fdc_CtrlStep(jcSTEP1_1);" title="이전달">
                            <img src="http://image16.hanatour.com/img/perfsale/btn_pre.gif" alt="이전달">
                            </a><a class="next dcursor" onclick="fdc_CtrlStep(jcSTEP1_2);" title="다음달">
                            <img src="http://image16.hanatour.com/img/perfsale/btn_next.gif" alt="다음달">
                            </a>
                            <span>2017. 08</span></div>
                            <input type="hidden" id="sday" value="${musical.open_day }">
                            <input type="hidden" id="eday" value="${musical.close_day }">
                            <table summary="공연일정을 선택할 수 있는 달력 형태의 표">
                            <caption>공연일정 달력</caption>
                            <tbody id="addCalendar">
	                            <tr>
	                            <td style="border:none;">
	                            <img src="http://image16.hanatour.com/img/perfsale/day_sun.gif" alt="sun"></td>
	                            <td style="border:none;">
	                            <img src="http://image16.hanatour.com/img/perfsale/day_mon.gif" alt="mon"></td>
	                            <td style="border:none;"><img src="http://image16.hanatour.com/img/perfsale/day_tue.gif" alt="tue"></td>
	                            <td style="border:none;"><img src="http://image16.hanatour.com/img/perfsale/day_wed.gif" alt="wed"></td>
	                            <td style="border:none;"><img src="http://image16.hanatour.com/img/perfsale/day_thu.gif" alt="thu"></td>
	                            <td style="border:none;"><img src="http://image16.hanatour.com/img/perfsale/day_fri.gif" alt="fri"></td>
	                            <td style="border:none;"><img src="http://image16.hanatour.com/img/perfsale/day_sat.gif" alt="sat"></td>
	                            </tr>
                            <tr>
                            <!-- 달력 구현 -->
                            </tr>
                  			</tbody></table><p class="tc"><img src="http://image16.hanatour.com/img/perfsale/img_selday.gif" alt="선택하신날짜 / 예매가능날짜"></p>
                          
                            
                            
                            </div>                        
                        </div>
                        <!-- //관람일선택 -->
                        <!--회차선택 -->
                        <div id="step01_time" class="step01_time" style="display: block;">
                            <div style="display: none;">
                                <p><img src="http://image16.hanatour.com/img/perfsale/img_select.gif" alt="관람일을 선택해주세요"></p>
                            </div>
                            <div style="display: block;">
                                <h2><img src="http://image16.hanatour.com/img/perfsale/h2_tit02.gif" alt="회차선택"></h2>
                                <div class="choie_select">
                                    <div class="select_day">
                                        <em class="tit">선택날짜</em><span></span>
                                    </div>
                                    <div class="number">
                                        <em class="tit">회차선택</em>
                                        <ul id="ulTime">
                                        
                                        </ul>
                                    </div>
                                    <div class="seat">
                                        <em class="tit">좌석등급/잔여석</em>
                                        <ul id="ulSeatSpace" class="hi">
                                        </ul>
                                    </div>
                                    <div class="btn">
                                        <div class="fr">
                                            <img id="btnSeatSelect" src="http://image16.hanatour.com/img/perfsale/btn_seat.gif" alt="좌석선택" class="dcursor" onclick="ChoiceSeat();" style="display: block;">
                                        </div>
                                        <div class="red" style="text-align:left;"> *예매 하시고자 하는 공연명.공연일시를 정확하게 선택하셨는지 확인 부탁드립니다.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //회차선택 -->
                        <!-- 공연안내 -->
                        <div id="step01_notice" class="step01_notice" style="display: block;">
                            <h3><img src="http://image16.hanatour.com/img/perfsale/h3_tit_notice.gif" alt="공연안내"></h3>
                            <div id="guideview">
                                <ul>
                                    <li>- 예매 하시고자 하는 공연명, 공연일시를 정확하게 선택하셨는지 확인 부탁드립니다.</li>
                                    <li>- 예매 시 무통장입금으로 선택하시면, 입금 가능한 은행명,계좌번호,입금마감일을 확인합니다.<br>
                                    (결제하기 후 예매확인/취소 내용으로 가셔서 예매가 잘되었는지 재확인 부탁드립니다.)</li>
                                    <li>- 하나티켓이 공지한 입금마감시간은 익일 23:59:59까지이나, 은행별 가상계좌 입금마감시간이 상이할 수 있으니 23시30분 이전까지는 입금하도록 합니다.</li>
                                    <li>- ATM 기기에 따라 무통장입금이 불가한 경우가 있습니다. 되도록 낮시간/계좌이체를 이용하시기 바랍니다.</li>
                                    <li>- 무통장 결제는 티켓취소가능시간 기준 2일전 까지만 가능합니다. </li>
                                </ul>                            
                            </div>
                            <!-- 공연안내 미등록시 보여줄 Default 문구 -->
                            <div id="guideview_default" style="display: none;">
                                <ul>
                                    <li>- 예매 하시고자 하는 공연명, 공연일시를 정확하게 선택하셨는지 확인 부탁드립니다.</li>
                                    <li>- 예매 시 무통장입금으로 선택하시면, 입금 가능한 은행명,계좌번호,입금마감일을 확인합니다.<br>
                                    (결제하기 후 예매확인/취소 내용으로 가셔서 예매가 잘되었는지 재확인 부탁드립니다.)</li>
                                    <li>- 하나티켓이 공지한 입금마감시간은 익일 23:59:59까지이나, 은행별 가상계좌 입금마감시간이 상이할 수 있으니 23시30분 이전까지는 입금하도록 합니다.</li>
                                    <li>- ATM 기기에 따라 무통장입금이 불가한 경우가 있습니다. 되도록 낮시간/계좌이체를 이용하시기 바랍니다.</li>
                                    <li>- 무통장 결제는 티켓취소가능시간 기준 2일전 까지만 가능합니다. </li>
                                </ul>                            
                            </div>
                        </div>
                        <!-- //공연안내 -->
                    </div>
                    <!-- //제 1 단계 : 관람일/회차 -->
                    <!-- 제 3 단계 : 할인/쿠폰 -->
                    <div id="step03" style="display: none;">
                        <!-- 할인선택 -->
                        <div class="step03_promotion">
                            <h2><img src="http://image16.hanatour.com/img/perfsale/h2_tit03.gif" alt="할인선택"></h2>
                            <div class="disc_select">
                                <div class="select_seat">
                                    <em class="tit">좌석등급</em> 
                                    <span id="spanPromotionSeat"></span>
                                </div>
                                <div id="divPromotionList" class="scroll"></div>
                            </div>
                        </div>
                        <!-- //할인선택 -->
                        <!-- 쿠폰선택 -->
                        <div class="step03_coupon">
                            <h2><img src="http://image16.hanatour.com/img/perfsale/h2_tit04.gif" alt="쿠폰선택"></h2>
                            <div class="sale_select">
                                <div class="select_coupon tr">
                                    <a class="dcursor" onclick="fdc_PopupCouponRegister();"><img src="http://image16.hanatour.com/img/perfsale/btn_coupon.gif" alt="쿠폰등록"></a>
                                </div>
                                <div id="divCouponList" class="scroll"></div>
                                <p>
                                    <strong class="red">주의사항</strong>
                                    <span>1) 쿠폰은 중복사용이 불가능합니다 (단, “중복사용가능” 표기 쿠폰은 쿠폰간 중복사용이 가능합니다)</span><br>
                                    <span>2) 공연별 / 할인 내용에 따라 우편배송이 불가할 수 있습니다.</span>
                                </p>
                            </div>
                        </div>
                        <!-- //쿠폰선택 -->
                    </div>
                    <!-- //제 3 단계 : 할인/쿠폰 -->
                    <!-- 제 4 단계 : 수령방법 -->
                    <div class="step04" id="step04" style="display: none;">
                        <h2><img src="http://image16.hanatour.com/img/perfsale/h2_tit05.gif" alt="수령방법"></h2>
                        <div class="receipt_select">
                            <!-- 수령방법선택 -->
                            <div class="select_seat" style="margin-bottom:10px;">
                                <em class="tit">수령방법선택</em> 
                                <div class="delivery">
                                    <span id="deliveryPos"></span>
                                    <span id="enblocDate" class="date" style="display:none;"><img src="http://image16.hanatour.com/img/perfsale/tit_01.gif" alt="일괄배송"><em>&nbsp;</em></span>
                                </div>
                                <div id="divTip_NoMobile" style="padding:27px 0 0 0;">* 티켓은 묶음배송이 불가합니다.<br>* 배송 받으신 티켓 분실시 재발권 및 관람이 불가합니다.</div>
                                <div id="divTip_Mobile">&nbsp;<br>* 모바일티켓(MMS문자)은 현물 티켓 대신 현장에서 모바일티켓을 제시하여 즉시 입장이 가능합니다.</div>
                            </div>
                            <!-- //수령방법 -->
                            <!-- 주문자확인 정보 -->
                            <div id="step04_OrdererInfo" style="margin-top:-15px;">
                                <div class="tit_area"><h4>주문자확인</h4> <span>입력하신 정보는 예매내역 확인 및 공지사항 전달시 필요하오니 정확한 입력 부탁드립니다.</span></div>
                                
                                
                                <ul style="margin-bottom:18px;">
                                    <li><em>이름</em><input id="ordererUserName" type="text" style="width: 110px;" maxlength="50" class="imekor" disabled="disabled"></li>
                                    <li><em>휴대폰/전화</em>
                                        <input id="ordererMobile1" type="text" style="width: 30px;" maxlength="3" class="imedisable" disabled="disabled">
                                        -
                                        <input id="ordererMobile2" type="text" style="width: 50px;" maxlength="4" class="imedisable" disabled="disabled">
                                        -
                                        <input id="ordererMobile3" type="text" style="width: 50px;" maxlength="4" class="imedisable" disabled="disabled">
                                    </li>
                                    <li><em>e-mail</em>
                                        <input id="ordererMailH" type="text" style="width: 110px;" maxlength="50" class="imedisable" disabled="disabled">
                                        @
                                        <input id="ordererMailD" type="text" style="width: 110px;" maxlength="50" class="imedisable" disabled="disabled">
                                    </li>
                                </ul>
                            </div>
                            <!-- //주문자확인 정보 -->
                            <!-- 배송지 정보 -->
                            <div id="step04_DeliveryInfo">
                                <div class="tit_area add_info">
                                <h4>배송지정보</h4>
                                <span>배송 받으시는 분의 휴대폰으로 배송시 전화를 드릴 수 있으니 정확한 입력 부탁드립니다.</span>
                                </div>
                                <ul>
                                    <li><em>받으시는분</em>
                                        <input id="deliveryUserName" type="text" style="width: 110px;" maxlength="50" class="imekor">
                                        <span>
                                            <input id="deliveryInfoType0" name="deliveryInfoType" type="radio" value="0" onclick="fdc_DisplayUserInfo(this);"><label>주문자정보와동일</label>
                                            <input id="deliveryInfoType1" name="deliveryInfoType" type="radio" value="1" onclick="fdc_DisplayUserInfo(this);"><label>최근배송지<a id="btnRecentAddress"><img src="http://image16.hanatour.com/img/perfsale/btn_more.gif" alt="더보기"></a></label>
                                            <input id="deliveryInfoType2" name="deliveryInfoType" type="radio" value="2" onclick="fdc_DisplayUserInfo(this);"><label>새로입력</label>
                                        </span></li>
                                    <li><em>휴대폰/전화</em>
                                        <input id="deliveryMobile1" type="text" style="width: 30px;" maxlength="3" class="imedisable">
                                        -
                                        <input id="deliveryMobile2" type="text" style="width: 50px;" maxlength="4" class="imedisable">
                                        -
                                        <input id="deliveryMobile3" type="text" style="width: 50px;" maxlength="4" class="imedisable">
                                    </li>
                                    <li><em>주소</em>
                                        <input id="deliveryZipCode1" type="text" style="width: 30px;" maxlength="3" class="imedisable"> - 
                                        <input id="deliveryZipCode2" type="text" style="width: 30px;" maxlength="3" class="imedisable">
                                        <input id="deliveryAddress1" type="text" style="width: 250px;" maxlength="200" class="imekor">
                                        <a id="btnSearchAddress"><img src="http://image16.hanatour.com/img/perfsale/btn_zip.gif" alt="우편번호검색"></a> 
                                    </li>
                                    <li id="lideliveryAddress2"><em>상세주소</em>
                                        <input id="deliveryAddress2" type="text" style="width: 300px;" maxlength="100" class="imekor">
                                    </li>
                                </ul>
                            </div>
                            <!-- //배송지 정보 -->
                            <!-- 모바일티켓 정보 -->
                            <div id="step04_MobileInfo" class="mticket">
                                <h5>모바일티켓(MMS문자) 이용안내</h5>
                                <ul>
                                    <li>* 티켓예매를 완료하시면 모바일로 MMS문자를 수신하실 수 있습니다.</li>
                                    <li>* 현장에서 해당 문자의 URL을 클릭하여 모바일티켓을 제시하시면 검표 후 즉시 입장 할 수 있습니다.</li>
                                    <li>* 모바일티켓은 MMS문자로 수신 받은 티켓에 명시된 유효기간까지만 사용이 가능합니다.</li>
                                    <li>* MMS문자  재발송이나 미수신 관련 문의는 모바일 티켓관련 고객센터(1600-0527)를 이용해 주세요.</li>
                                    <li>* 미사용 티켓은 취소 마감시간 전까지 환불 및 취소가 가능합니다.(단, 취소일자에 따라 취소수수료가 발생할 수 있습니다.)</li>
                                    <li>* 취소 마감 시간 이후에도 유효기간이 지나지 않은 티켓은 이용이 가능 합니다.</li>
                                </ul>
                            </div>
                            <!-- //모바일티켓 정보 -->
                            <!-- 주의사항 -->
                            <div class="caution" style="bottom:15px; padding-bottom:2px;">
                                <h5>주의사항</h5>
                                <ul>
                                    <li>1) 현장수령의 경우 관람당일 여유있게 1시간전에 도착하여 예매내역/신분증을 지참하시고 매표소에서 티켓 수령 부탁드립니다.</li>
                                    <li>2) 일반배송의 경우 예매하신 분과 받으시는 분이 다를 경우 티켓을 배송받으실 분의 이름,연락처,주소를 직접 입력하셔야 하며 입력된 정보는 배송을 위한 정보입니다.</li>
                                    <li>3) 일괄배송의 경우 정해진 날짜에 티켓 발송이 시작되면 주소수정은 일괄배송일 2일전까지 가능합니다.</li>
                                </ul>
                            </div>
                            <!-- //주의사항 -->
                        </div>
                    </div>
                    <!-- //제 4 단계 : 수령방법 -->
                    <!-- 제 5 단계 : 결제방법 -->
                    <div class="step05" id="step05" style="display: none;">
                        <h2><img src="http://image16.hanatour.com/img/perfsale/h2_tit06.gif" alt="결제방법"></h2>
                        <div class="receipt_select">
                            <!-- 결제수단 & 결제방법선택 -->
                            <div class="receipt_scroll">
                                <h4 class="mt">하나투어 마일리지</h4>
                                <ul class="mb mileage">
                                    <!-- 마일리지선택 -->
                                    <li><em>보유 마일리지</em> 
                                        <span id="spanSelfMileage">
                                        </span>
                                        <a id="imgMileageUse1" class="dcursor" onclick="fdc_MileageUse(this);"><img src="http://image16.hanatour.com/img/perfsale/btn_use02.gif" alt="사용하기"></a>
                                        <a class="dcursor" style="display:none;" onclick="fdc_MileageCertify(1);"><img src="http://image16.hanatour.com/img/perfsale/btn_confirm01.gif" alt="본인인증"></a>
                                        <a class="dcursor" onclick="fdc_MileageCertify(2);"><img src="http://image16.hanatour.com/img/perfsale/btn_confirm02.gif" alt="타인추가인증"></a>
                                        <span id="spanMileageTxt1" class="mtxt">총 <strong class="red">0</strong> 마일리지 사용가능</span>
                                    </li>
                                    <li><em>타인 마일리지</em>
                                        <div id="divOtherMileage" class="other">
                                            <p style="padding-left: 7px; padding-top: 5px;">타인의 마일리지를 사용하실려면 <strong class="blu">타인추가인증</strong> 버튼을 클릭해 주세요.</p>
                                        </div>
                                    </li>
                                    <!-- //마일리지선택 -->
                                    <!-- 결제방법선택 -->
                                    <li class="payment"><em class="red bold">결제방법선택</em>
                                        <div class="con">
                                            <ul id="paymethodPos"></ul>
                                            <a href="#" class="more" style="display:none;"><img src="http://image16.hanatour.com/img/perfsale/btn_infor03.gif" alt="신용카드 및 무통장입급안내"></a>
                                        </div>
                                        <div class="txt_pay">
                                            우측 결제하기 버튼 클릭 후 다음 페이지에서 예매확인서가 정상적으로 나타나지 않거나 에러 메세지를 받은 경우,<br>반드시 [예매확인/취소]에서 예매내역을 확인하시기 바랍니다.
                                        </div>
                                    </li>
                                    <!-- //결제방법선택 -->
                                </ul>
                                <!-- 결제수단 & 결제방법선택 -->
                                <!-- 취소수수료 안내 및 약관동의 -->
                                <div class="caution">
                                    <div class="tit_payArea">
                                        <h5>취소수수료 안내 및 이용 약관</h5>
                                        <span class="red">단, 아래 취소 마감시간 이후 예매되는 티켓은 취소 및 변경, 환불이 불가하오니 유의해 주시기 바랍니다.</span>
                                    </div>
                                    
                                    <span id="lblCancelTimeInfo">
                                    </span>
                                    <p>
                                        
                                        * 관람일 전일 평일 오후 5시 이후(토요일은 오전 11시) 또는 관람일 당일 예매하신 건에 대해서는
                                        <br>
                                        &nbsp;&nbsp;예매 후 취소/변경/ 환불 불가 (자세한 취소수수료 규정은 “티켓고객센터&gt;취소/환불안내” 참고)
                                    </p>
                                </div>                                
                            </div>
                            <span class="chkbox">
                                    <input id="cbxCancelFeeAgree" type="checkbox"><label>취소수수료 및 예매 특별 약관을 읽었으며, 이에 동의합니다. <a href="javascript:fdc_PopupSaleSpecialAgree()">[상세보기]</a></label> 
                                    <input id="cbxTermAgree" type="checkbox"><label>제3자 정보제공 내용에 동의합니다. <a href="javascript:fdc_PopupTermAgree()">[상세보기]</a></label>
                            </span>
                            <!-- //취소수수료 안내 및 약관동의 -->
                        </div>
                    </div>
                    <!-- //제 5 단계 : 결제방법 -->
                </div>
                <!--// 내용컨탠츠 -->
                <!-- 상황판 -->
                <div id="StateBoard">
                    <div class="result">
                        <div id="perfboard" class="title">
	                        <p>
	                        <!-- 포스터 -->
	                        <img src="MusicalImage/${musical.image }" width="79" height="98" alt=""></p>
	                        <span id="ptitle" class="tit"><a title="${musical.name })">${musical.name }</a></span>
	                        <span class="date">${musical.open_day } ~ ${musical.close_day }</span>
	                        <span id="ptheatername" class="date"><a title="${place.name }">${place.name }</a></span>
	                        <input id="hiddenGenreId" type="hidden" value="">
	                        <input id="hiddenDisplayRemainSeat" type="hidden" value="0">
                        </div>
                        <div class="select_infor">
                            <h3><img src="http://image16.hanatour.com/img/perfsale/h3_tit_result01.gif" alt="선택내역"></h3>
                            <ul>
                            
                                <li><em><img src="http://image16.hanatour.com/img/perfsale/r_tit01.gif" alt="날짜"></em><span id="tk_day">
									<c:if test="${musical.open_day } == ${musical.close_day }">
										${musical.open_day  }
									</c:if>
								</span></li>
                                <li><em><img src="http://image16.hanatour.com/img/perfsale/r_tit02.gif" alt="시간"></em><span id="tk_time"></span></li>
                                <li><em><img src="http://image16.hanatour.com/img/perfsale/r_tit03.gif" alt="매수"></em><span id="tk_count"></span></li>
                                <li><em><img src="http://image16.hanatour.com/img/perfsale/r_tit04.gif" alt="좌석"></em>
                                    <div id="tk_seat"><span>좌석 지정 회차입니다.</span></div>
                                </li>
                            </ul>
                        </div>
                        <div class="pay_infor">
                            <h3><img src="http://image16.hanatour.com/img/perfsale/h3_tit_result02.gif" alt="결제내역"></h3>
                            <div class="link01">
                                <ul>
                                    <li class="tk_price"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit05.gif" alt="티켓금액"></em><span>0</span></li>
                                    <li class="tk_charge"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit06.gif" alt="예매수수료"></em><span>0</span></li>
                                    <li class="tk_deli"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit07.gif" alt="배송료"></em><span>0</span></li>
                                    <li class="tk_sumplus"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit08.gif" alt="총금액"></em><span>0</span></li>
                                </ul>
                            </div>
                            <div class="link02">
                                <ul>
                                    <li class="tk_disc"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit09.gif" alt="할인금액"></em><span>0</span></li>
                                    <li class="tk_coupon"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit10.gif" alt="쿠폰/예매권"></em><span>0</span></li>
                                    <li class="tk_mileage"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit11.gif" alt="마일리지"></em><span>0</span></li>
                                    <li class="tk_otherpays"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit12.gif" alt="기타결제"></em><span>0</span></li>
                                    <li><em><img src="http://image16.hanatour.com/img/perfsale/r_titblank.gif" alt=""></em><span>&nbsp;</span></li>
                                    <li><em><img src="http://image16.hanatour.com/img/perfsale/r_titblank.gif" alt=""></em><span>&nbsp;</span></li>
                                    <li class="tk_summinus"><em><img src="http://image16.hanatour.com/img/perfsale/r_tit15.gif" alt="총할인금액"></em><span>0</span></li>
                                </ul>
                            </div>
                        </div>
                        <span class="t_result">0<span>원</span></span>
                        <div class="btn">
                            <div id="StepCtrlBtnPanel" class="tc">
                                <div id="StepCtrlBtn01" style="display: block;">
                                    <a class="dcursor" onclick="ChoiceSeat();"><img src="http://image16.hanatour.com/img/perfsale/btn_next04.gif" alt="다음단계"></a>
                                </div>
                                <div id="StepCtrlBtn03" style="display:none;">
                                    <a class="dcursor" onclick="fdc_GoPrevStep(jcSTEP1);"><img src="http://image16.hanatour.com/img/perfsale/btn_prev.gif" alt="이전단계"></a>
                                    <a class="dcursor" onclick="fdc_PromotionEnd();"><img src="http://image16.hanatour.com/img/perfsale/btn_next02.gif" alt="다음단계"></a>
                                </div>
                                <div id="StepCtrlBtn04" style="display:none;">
                                    <a class="dcursor" onclick="fdc_GoPrevStep(jcSTEP3);"><img src="http://image16.hanatour.com/img/perfsale/btn_prev.gif" alt="이전단계"></a>
                                    <a class="dcursor" onclick="fdc_DeliveryEnd();"><img src="http://image16.hanatour.com/img/perfsale/btn_next02.gif" alt="다음단계"></a>
                                </div>
                                <div id="StepCtrlBtn05" style="display:none;">
                                    <a class="dcursor" onclick="fdc_GoPrevStep(jcSTEP4);"><img src="http://image16.hanatour.com/img/perfsale/btn_prev.gif" alt="이전단계"></a>
                                    <a class="dcursor" onclick="fdc_PrePayCheck();"><img id="imgPayEnd" src="http://image16.hanatour.com/img/perfsale/btn_succ.gif" alt="결제하기"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--// 상황판 -->
            </div>
            <!-- 제 2 단계 : 좌석선택 (좌석플래시) -->
            <div id="SeatFlashArea" style="display: none;">
                <div class="seat_arrange">
                    <div class="f_header">
                        <ul>
                            <li>
                                <em><img src="http://image16.hanatour.com/img/perfsale/h3_tit_seat01.gif" alt="관람일변경"></em> 
                                <span>
                                    <select id="selFlashDateAll" onchange="fdc_selFlashDateAllChange(this.value);" style="width: 200px;"><option selected="">날짜선택</option></select>
                                </span>
                            </li>
                            <li>
                                <em><img src="http://image16.hanatour.com/img/perfsale/h3_tit_seat02.gif" alt="회차변경"></em> 
                                <span>
                                    <select id="selFlashTime" onchange="fdc_SelFlashTimeChange(this.value);" style="width: 200px;">
                                    <option selected="" value="0">회차 선택</option>
                                    </select>
                                </span>
                            </li>
                        </ul>
                    </div>
                    <div id="divFlash">
                    <form name="form1" method="post" action="PerfSaleHtmlSeat.aspx?idTime=660175&amp;idHall=4700&amp;block=0&amp;stMax=10&amp;channel=1" id="form1">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTIwODU4NzA5NWRkltej5HFgOfnthMekpeeOLkkHcwEVu1tswQTkP3+pzZ8=">
</div>

    <!-- 좌석 정보 -->
    <div class="bx_seatbg">
        <div class="seatarea">
            <div class="bx_top"></div>
            <div id="divGuide" class="bx_con1">
                <div id="divContainer" class="raffer" style="width: 750px; height: 585px; background-image: url(&quot;http://image16.hanatour.com/Upload/Hall/4000/4700/0482e9c14-f294-43cf-b65f-387f2c3d0fcd.jpg&quot;); background-repeat: no-repeat; background-position: 0px 0px;">
                    <div id="divSeatArray"><div style="TOP: 188px; LEFT: 98px" id="t500018" class="s13" name="tk" value="500018"></div>
					</div>
                </div>
            </div>
        </div>
        <div class="seatinfo">
            <div class="minimap_m">
                <!-- 미니맵 -->
                <p><img src="http://image16.hanatour.com/img/htmlseat/tit2_minimap1.gif" alt="공연장 미니맵" class="tit"></p>
                <ul>
                   <li class="list_no"><img src="http://image16.hanatour.com/img/htmlseat/tit2_minimap1_1.jpg" alt="" title="구역 이동은 미니맵을 이용해주세요"></li>
                    <li id="liminiMap" class="list_no" style="text-align: center; height:203px; border: solid 1px #C8C8C8;"><span><!--맵표시부분--></span></li>
                    <!--<li class="list_no"><img src="http://image16.hanatour.com/img/htmlseat/bx3_minimap3.jpg" alt="" /></li>-->
                </ul>
                <!-- //미니맵 -->
                <!--  좌석 등급/가격 -->
                <p><img src="http://image16.hanatour.com/img/htmlseat/tit2_minimap2.gif" alt="좌석 등급 및 가격" class="tit"></p>
                <ul>
                    <li class="list_no"><img src="http://image16.hanatour.com/img/htmlseat/bx3_minimap1.jpg" alt=""></li>
                    <li id="liLegend" class="bx3_wbg bx3_wbg2"><p class="txt"><img src="http://image16.hanatour.com/img/htmlseat/ic_seat6.gif" alt="">R석 50,000원</p><p class="txt"><img src="http://image16.hanatour.com/img/htmlseat/ic_seat8.gif" alt="">S석 30,000원</p><p class="txt"><img src="http://image16.hanatour.com/img/htmlseat/ic_seat4.gif" alt="">A석 10,000원</p><p class="txt"><img src="http://image16.hanatour.com/img/htmlseat/ic_seat13.gif" alt="">판매 완료</p></li><li class="list_no"><img src="http://image16.hanatour.com/img/htmlseat/bx3_minimap3.jpg" alt=""></li>
                </ul>
                <!--  //좌석 등급/가격 -->
                <!--  선택좌석 -->
                <p><img src="http://image16.hanatour.com/img/htmlseat/tit2_minimap3.gif" alt="선택좌석" class="tit"></p>
                <ul>
                    <li class="list_no"><img src="http://image16.hanatour.com/img/htmlseat/bx3_minimap1.jpg" alt=""></li>
                    <li id="liSelSeat" class="bx3_wbg bx3_wbg3"></li>
                    <li class="list_no"><img src="http://image16.hanatour.com/img/htmlseat/bx3_minimap3.jpg" alt=""></li>
                </ul>
                <!--  //선택좌석 -->
                <div class="btn">
                    <p>
                        <a href="javascript:closeseat();"><img src="http://image16.hanatour.com/img/htmlseat/btn_pre.gif" alt="이전화면"></a>
                        <a href="javascript:ChoiceReset();"><img src="http://image16.hanatour.com/img/htmlseat/btn_refresh.gif" alt="좌석선택다시"></a>
                    </p>
                    <p>
                        <a href="javascript:ChoiceEnd();"><img src="http://image16.hanatour.com/img/htmlseat/btn_booking.gif" alt="좌석선택완료" class="booking"></a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    <!-- //좌석 정보 -->
    <div id="progressbar" style="position: absolute; left: 300px; top: 250px; display: none;"><img src="http://image16.hanatour.com/img/htmlseat/loading_re.gif" alt="로딩이미지"></div>
    <div id="btnBigMap" class="bigmapdiv" style="display: none;">
        <img src="http://image16.hanatour.com/img/htmlseat/btn_show_bigmap.gif" alt="공연장맵 보기" class="booking" style="cursor:pointer;cusor:hand;" onclick="ShowBigMap();">
    </div>
    <div id="blkInfo" class="csblkInfo" style="display: none"></div>
    <div id="dMapInfo" class="seatMap" onmouseout="outMap();" style="left: 758px; top: 57px; width: 188px; height: 203px;">
	    <svg height="203" version="1.1" width="188" xmlns="http://www.w3.org/2000/svg" style="overflow: hidden; position: relative;" viewBox="0 0 188 203" preserveAspectRatio="none">
		    <desc style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);">Created with Raphaël 2.0.0</desc>
		    <defs style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></defs>
		    <image x="0" y="0" width="184" height="170" preserveAspectRatio="none" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://image16.hanatour.com/Upload/Hall/4000/4700/fa05a5d2c8f642fb8c709aea14d3b966.PNG" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);" stroke-width="1"></image>
		    <path fill="#ffff00" stroke="#000000" d="M18,34L18,81L165,81L165,34" pointer-events="fill" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); fill-opacity: 0.8;" fill-opacity="0.8" stroke-width="0"></path>
		    <path fill="#000000" stroke="#ffff00" d="M18,90L18,123L165,123L165,90" pointer-events="fill" fill-opacity="0.0" stroke-width="2" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); fill-opacity: 0;"></path>
		    <path fill="#000000" stroke="#ffff00" d="M18,133L18,166L167,167L167,133" pointer-events="fill" fill-opacity="0.0" stroke-width="2" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); fill-opacity: 0;"></path>
	    </svg>
    </div>
    <div id="availableSeatCountTooltip" class="availableSeatCountTooltip" style="top: 224px; left: 835px; display: none;">잔여석: 54</div>

   
    </form>
                    
                    </div>
                </div>
            </div>
            <!-- //제 2 단계 : 좌석선택 (좌석플래시) -->
            <!-- 결과페이지 -->
            <div id="SuccessBoard" style="display: none;">
                <div class="success">
                    <div class="suc_tit">
                        <h2><img src="http://image16.hanatour.com/img/perfsale/h2_suc.gif" alt="결제가 정상적으로 완료되었습니다."></h2>
                        <p><img src="http://image16.hanatour.com/img/perfsale/suc_txt.gif" alt="예매 상세내역은 마이페이지 > MY공연 > 예매확인/취소에서 확인하실 수 있습니다."></p>
                    </div>
                    <div id="BannerCtrl" class="no_banner">
                        <div id="SuccBook" class="succ">
                            <h4><img src="http://image16.hanatour.com/img/perfsale/suc_tit01.gif" alt="예매정보"></h4>
                            <ul>
                                <li><em>예약번호</em><span class="red"><strong id="bk_bookno" class="big">&nbsp;</strong><strong id="bk_tkcount">&nbsp;</strong><img id="bk_bookstatus" src="http://image16.hanatour.com/img/perfsale/btn_suc.gif" alt="예매완료"></span> </li>
                                <li><em>공연명</em><span><strong id="bk_perfname">&nbsp;</strong></span></li>
                                <li><em>공연장</em><span><strong id="bk_theatername">&nbsp;</strong></span></li>
                                <li><em>관람일시</em><span id="bk_viewtime">&nbsp;</span></li>
                                <li>
                                    <em>좌석</em>
                                    <div id="bk_tkseat">&nbsp;</div>
                                </li>
                                <li>
                                    <em>수령방법</em>
                                    <span id="bk_deliveryinfo">&nbsp;</span>
                                </li>
                            </ul>
                            <h4><img src="http://image16.hanatour.com/img/perfsale/suc_tit02.gif" alt="예매후 유의사항"></h4>
                            <ul>
                                <li>
                                    <em>취소가능일시 :</em>
                                    <span class="blk"><strong id="bk_canceltimeinfo">&nbsp;</strong></span>
                                </li>
                            </ul>
                        </div>
                        <div id="SuccPay" class="succ">
                            <h4><img src="http://image16.hanatour.com/img/perfsale/suc_tit03.gif" alt="결제정보"></h4>
                            <ul class="pay">
                                <li><em>티켓금액</em><span id="sp_tkprice">&nbsp;</span></li>
                                <li><em>예매수수료</em><span id="sp_charge">&nbsp;</span></li>
                                <li><em>배송료</em><span id="sp_deli">&nbsp;</span></li>
                                <li class="bg"><em><strong>(+)금액</strong></em><span><strong id="sp_sumplus">&nbsp;</strong></span></li>
                                <li><em>할인금액</em><span id="sp_disc">&nbsp;</span></li>
                                <li><em>쿠폰/예매권</em><span id="sp_coupon">&nbsp;</span></li>
                                <li><em>마일리지</em><span id="sp_mileage">&nbsp;</span></li>
                                <li><em>기타결제</em><span id="sp_otherpays">&nbsp;</span></li>
                                <li><em>&nbsp;</em><span>&nbsp;</span></li>
                                <li><em>&nbsp;</em><span>&nbsp;</span></li>
                                <li class="bg"><em><strong>(-)금액</strong></em><span><strong id="sp_sumninus">&nbsp;</strong></span></li>
                                <li class="total"><em>총 결제금액</em><span><strong id="sp_result">&nbsp;</strong> 원</span></li>
                                <li><em>결제수단</em><span id="sp_payinfo">&nbsp;</span></li>
                                <li id="bank_accbank" style="display:none;"><em>입금계좌/은행</em><span id="sp_bank_accbank">&nbsp;</span></li>
                                <li id="bank_amttime" style="display:none;"><em>입금금액/마감</em><span id="sp_bank_amttime">&nbsp;</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="banner" style="display:none;">
                    </div>
                    <div class="confirm">
                        <div class="tc">
                            <a id="imgGoTicketView" class="dcursor"><img src="http://image16.hanatour.com/img/perfsale/btn_ok02.gif" alt="예매내역확인"></a>
                        </div>
                    </div>
                </div>
            </div>
            <!--// 결과페이지 -->
            <!-- 이벤트 알림 -->
			<style>
				.pu_lucky {position:fixed; left:250px; top:100px; width:550px; height:504px; background-color:#fff; z-index:10;}
				.pu_lucky > div {position:relative;}
				.pu_lucky > div a {display:block; position:absolute; right:17px; bottom:17px; z-index:50}
				.pu_lucky > div a.btn_event {position:absolute; bottom:89px; left:36px; display:block; width:125px; height:26px}
				.pu_lucky > div a.btn_closed {position:absolute; bottom:10px; left:16px; display:block; width:34px; height:12px;}
				.pu_lucky > div a.btn_today {position:absolute; bottom:9px; right:16px; display:block; width:107px; height:12px;}
			</style>
			<div class="pu_lucky" id="EventBoard1" style="display: none;">
				<div>
					<img src="http://image16.hanatour.com/img/popup/img_perf_event.jpg" alt="하나티켓~ 연말을 부탁해 매주 100명씩! 최대 2천만원 쏩니다!">
					<a href="http://ticket.hanatour.com/Pages/Bridge/List.aspx?mode=2&amp;id=493" class="btn_event" title="이벤트응모하기"><img src="http://image16.hanatour.com/img/popup/btn_event_apply.gif" alt="이벤트 응모하기"></a>
					<a href="#none" class="btn_closed"><img src="http://image16.hanatour.com/img/popup/btn_close4.png" alt="닫기"></a>
					<a href="#none" class="btn_today"><img src="http://image16.hanatour.com/img/popup/btn_today.png" alt="하루동안 열지 않기"></a>
				</div>
			</div>
            <!--//이벤트 알림 -->
            <!-- Inicis 결제 및 주문을 위한 (지불/티켓) 전송 정보 DIV -->
            <div id="divPayInfoSendForm" class="PayInfoSendForm"></div>
        </div>
        <!-- UI 영역 END -->    
        <img id="imgAjaxLoader1_1" style="position: absolute; top: 75.5556px; left: 241.111px; display: none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader1_2" style="position: absolute; top: 75.5556px; left: 241.111px; display: none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader1_3" style="position: absolute; top: 75.5556px; left: 241.111px; display: none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader2_1" style="position: absolute; top: 462.278px; left: 395.122px; display: none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader2_2" style="position: absolute; top: 462.278px; left: 395.122px; display: none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader2_3" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader2_4" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader3_1" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader3_2" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader4_1" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader4_2" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader5_1" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader5_2" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader5_3" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader5_4" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader5_5" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader5_6" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader5_7" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader"><img id="imgAjaxLoader6" style="display:none;" src="http://image16.hanatour.com/img/ajax/loader.gif" alt="ajaxLoader">
        <!-- 전체영역에서 사용되는 중요보관 콘트롤 -->
        <input id="IdTime" type="hidden" value="660175">
        <input id="IdSeatClassPrice" type="hidden" value=""> 
        <input id="IdSeatClass" type="hidden" value=""> 
        <input id="IdSeat" type="hidden" value="">
        <input id="lockId" type="hidden">
        <!-- 기타 DIV -->
        <div id="divTimeTempData" style="display:none"><ul id="ulTimeData"><li value="660175" timeoption="2" idhall="4700" seatviewmode="1" saleclose="2017.08.17" cancelclose="2017.08.17 17:00:00" limitcussalecnt="1000" limittimesalecnt="0" timeinfo="20시 00분">[1회] 20시 00분</li></ul><select id="selFlashTimeData"><option selected="" value="0">회차 선택</option><option value="660175" timeoption="2" idhall="4700" seatviewmode="1" saleclose="2017.08.17" cancelclose="2017.08.17 17:00:00" limitcussalecnt="1000" limittimesalecnt="0" timeinfo="20시 00분">[1회] 20시 00분</option></select></div>
        <!-- 할인체크 DIV -->
        <div id="SelPromotionStorage"></div>
        <!-- 사용자 주소정보 & 최근배송지 TOP1 보관 템플릿 DIV -->
        <div id="divDeliveryUserInfo" style="display:none"></div>
        <!-- 예매수수료 DIV -->
        <div id="divBookingFee" bkinloading="" style="display:none"></div>
        <!-- 현금영수증 발행 신청 정보 -->
        <input id="hiddenReceiptInfo" type="hidden" receipt="" receiptno="">
        <!-- 메시지 큐 -->
        <div id="divMsgQueue" style="display:none"></div>
        <!-- 가상계좌정보 DIV -->
        <div id="divVBankInfo" style="display:none"></div>
        <!-- 입금은행 OPTION 콘트롤 -->
        <input id="hiddenBankOptions" type="hidden" value="<option value='-1'>입급은행을 입력하세요</option><option value='4777'>기업은행</option><option value='4778'>국민은행</option><option value='4780'>신한은행</option><option value='4781'>하나은행</option><option value='4782'>수협</option><option value='4783'>농협중앙회</option><option value='21274'>우리은행</option><option value='21275'>우체국</option><option value='21276'>부산은행</option><option value='21277'>제일은행</option><option value='21278'>광주은행</option><option value='24718'>한국시티은행</option><option value='24719'>경남은행</option><option value='24720'>대구은행</option>">
        <!-- 결제 진행(바) 표시 DIV -->
        <div id="divPayProgress" style="display:none;">
            <table style="width:400px; height:265px;" border="0" cellspacing="0" cellpadding="0">
                <tbody><tr>
                    <td style="background:url('http://image16.hanatour.com/img/perfsale/loading_box.gif') 0 0 no-repeat; padding-top: 10; position:relative;" align="center">
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tbody><tr>
                                <td align="center" height="40" valign="top">
                                    <strong style="color:#333;">결제 진행중입니다. 잠시만 기다려 주십시요.</strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="http://image16.hanatour.com/img/perfsale/loading.gif" alt="">
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody></table>        
        </div>       
        <!-- 예매시 주의사항 DIV -->
        <div id="divNAlert" style="display: none;">
            <div class="popup2" style="width: 480px;">
                <div class="pu_tit"><h1>예매시 주의사항</h1></div>
                <div class="pu_cont">
                    <div class="txt divNAlertContens"></div>
                    <div class="agree">
                        <h2>확인사항</h2>
                        <p>예매시 주의사항을 읽었으며, 이에 동의합니다.</p>
                        <p class="ck"><input type="checkbox" id="cbxNAlertAgree" class="cbxNAlertAgree"> <label for="cbxNAlertAgree">예</label></p>
                    </div>
                    <div class="tr"><a class="divNAlertClose" href="#none"><img src="http://image16.hanatour.com/img/perfsale/btn_ok03.gif" alt="확인"></a></div>
                </div>
            </div>
        </div>
        <!-- AceCounter DIV -->
        <div id="divAceCounterInfoSendForm" style="display:none"></div>

    <script type="text/javascript">
        // Inicis 플러그인 설치

        
        
    </script>
    <script type="text/javascript">
   //     jgBookAlert = jgBookTAlert;
  //      jgBookPopup = jgBookTPopup;
/*
        // Page 초기화 스크립트
        $j(document).ready(function () {
            if (jgIsPageShow) {
                // 전역변수 값설정 (서버연동이 필요한 경우만)
                jgOrdHeader = 'H';
                jgIdPerf = '32966';
                jgIdSelTime = '660175';

                // 고객구매매수 : 지산밸리를 위해 SP로 수정 사용
                jgSeatSelectMax = parseInt('10');

                // 고객구매매수 관련하여서는 사용하지 않음
                //jgSeatSelectMax = parseInt('10');

                //if (jgSeatSelectMax > 10) {
                //    jgSeatSelectMax = 10;
                //}

                jgCusMemberType = '113';
                //jgCusEnableBookTicket = '1'; // 예매가능여부 : No Used!!
                jgSaleChannel = '1';

                jgIsMania = '0';

                $j("#progressBar").jry_home_ShowProgressBar({ "state": "stop" });

                if ('1' != '0') {
                    fdc_AttachStatusMonitor(jgIdPerf);  
                    fax_GetPerfSaleInfo(jgIdPerf);
                    fax_GetPerfGuideView(jgIdPerf);
                    fdc_CtrlStep(jcSTEP1);
                    checkSamsungPayDevice();
                }
                else {// 로그인을 안 한 경우
                    parent.jsf_dialog_PopupClose();
                }
                if (jgBannerMode == jcBANNER_ON) {
                    $j("#ifrTicketBanner").attr("src", '/Pages/Perf/Sale/Banner/PerfSaleBanner.aspx');
                }

                //$j("#step04_DeliveryInfo").find("#deliveryZipCode1, #deliveryZipCode2, #deliveryAddress1").unbind('.Addr_NoInput').bind('keydown.Addr_NoInput', jsf_def_NoInput).bind('paste.Addr_NoInput', jsf_def_NoPaste).bind('cut.Addr_NoInput', jsf_def_NoCut);
                $j("#step04_DeliveryInfo input[id^='deliveryMobile']:text, #step04_DeliveryInfo input[id^='deliveryZipCode']:text, #step04_OrdererInfo input[id^='ordererMobile']:text").
                    unbind('.delivery_onlynumber').bind('blur.delivery_onlynumber', jsf_def_InputBlur).bind('keydown.delivery_onlynumber', jsf_def_InputOnlyNumber);
            }
        });

        // 트래킹 정보
        _log.push(['tg', '']);
        */
    </script>
    </form>

	
	
<div class="blackscreen" style="display:none;" id="blackscreen"></div>
<!-- loading -->

<!-- iframe -->
<!-- javascript 상위프레임에 있는 스크립트를 사용-->

<!--<script type="text/javascript" src="http://img.cgv.co.kr/common/js/insightIS.js"></script>-->



</body>
