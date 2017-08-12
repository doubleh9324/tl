<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>이전배송지</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript"> 
//<![CDATA[
	document.observe("dom:loaded", fnInit);

	//초기화
	function fnInit(){
		window.resizeTo(524,395); 
	}

	//선택한 배송지 전달
	function fnSetAddress(id)	{		
		var o = $N("AddressRow")[id];		
		opener.fnSetAddress(o.getAttribute("RName"), o.getAttribute("RHpNo"), o.getAttribute("RPhoneNo"), o.getAttribute("RZipcode"), o.getAttribute("RAddr"), o.getAttribute("RSubAddr"), o.getAttribute("ExpressYN"));
		window.close();
	}
	
	function selectAddress(event){
		
		var re = window.confirm("해당 주소로 배송지를 설정합니다.");
		
		if(re){
			var postcode = $(event.currentTarget).text();
			var address = $(event.currentTarget).parent().next().text();
			var adddetail = $(event.currentTarget).parent().next().next().text();
			
			$("#deliveryZipCode",opener.document).val(postcode);
			$("#deliveryAddress1",opener.document).val(address);
			$("#deliveryAddress2",opener.document).val(adddetail);
			
			window.close();
		}
	}
	
//]]>
</script>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width='497' border='0' cellpadding='0' cellspacing='0' height="366">
	<tr>
		<td height="47" style="background:url('http://ticketimage.interpark.com/TicketImage/onestop/pop_bg.gif') repeat-x;"><img src="http://ticketimage.interpark.com/TicketImage/onestop/re_pop_title_01.gif"></td>
	</tr>
	<tr>
		<td valign="top" align="center" style="padding-top:30px;">
			<table width="90%" border='0' cellpadding='0' cellspacing='0'>
				<tr>
					<td colspan="3" valign="top" style="letter-spacing:-1px; font-weight:bold;">
					<img src="http://ticketimage.interpark.com/TicketImage/onestop/bul_02.gif" align="absmiddle" vspace="1"> 최근 6개월간 사용하신 주소가 5개까지 자동으로 저장됩니다.</td>
				</tr>
				<tr name="AddressRow" id="AddressRow">
					<td height="33"></td>
				</tr>
					<tr>
						<td height="5" valign="top"></td>
					</tr>
					<c:choose>
						<c:when test="${fn:length(addressList) > 0}">
							<c:forEach items="${addressList }" var="address" varStatus="status">
								<tr>
									<td width="10%"><a href="#" onclick="selectAddress(event)">${address.post_code }</a> </td>
									
									<td style="width:40%; padding-left:10px">${address.address } </td>
									<td style="padding-left:10px">${address.add_detail }</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td align="center">저장된 이전 배송지가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
			</table>
		</td>
	</tr>
	<tr>
		<td height="35" style="background:#EFEFEF;" align="center"><a href="javascript:window.close();"><img src="http://ticketimage.interpark.com/TicketImage/event/110103/btn_close_02.gif" border="0"></a></td>
	</tr>
</table>
</body>
</html>