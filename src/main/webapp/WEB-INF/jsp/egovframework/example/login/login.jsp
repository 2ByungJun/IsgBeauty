<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<title>IsgBeauty</title>

<!-- CSS -->
<style>
.bjLabel {
	margin-top: 5px;
}

.bjInput {
	width: 200px;
	margin-top: 5px;
}
</style>

<!-- JSP -->
<body onload="noBack();" onpageshow="if(event.persisted) noBack();">
	<!-- header -->
	<div class="container">
		<header class="page-header">
			<div class="container">
				<div style="text-align: center;" alt="IsgBeauty 로고"><img src="<c:url value='images/logo.jpg' />"></div>
			</div>
		</header>
	</div>

	<!-- body -->
	<form class="form-horizontal" style="display: grid; margin-top:20px;">
		<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

			<!-- (35%) -->
			<div style="width: 35%;"></div>

			<!-- label (10%) -->
			<div style="width: 10%; text-align: center;">
				<p><label class="bjLabel control-label" for="email">ID : </label></p>
				<p><label class="bjLabel control-label" for="pwd">Password : </label></p>
			</div>

			<!-- input (20%) -->
			<div style="width: 20%; text-align: left;">
				<!-- id -->
				<div style="display: inline-flex;"><input type="text" class="bjInput form-control" id="email" name="email" placeholder="아이디를 입력해주세요" value="관리자" onkeydown="if(event.keyCode==13) login()"></div>
				<!-- password -->
				<div style="display: inline-flex;"><input type="password" class="bjInput form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요" value="1234" onkeydown="if(event.keyCode==13) login()"></div>
			</div>

			<!-- (35%) -->
			<div style="width: 35%;"></div>
		</div>
	</form>

	<!-- button -->
	<div class="container" style="text-align: center;">
		<button type="button" class="btn btn-primary" onclick="login()">로그인</button>
		<button type="button" class=" btn btn-info" onclick="empRegister()">회원가입</button>
	</div>

	<!-- footer -->
	<jsp:include page="/common/layouts/userLayout/footer.jsp"></jsp:include>
</body>

<!-- JS -->
<link rel="stylesheet" href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<%if (session.getAttribute("empId") != null) {%>
	location.href = "<c:url value='/mberList.do'/>";
<%}%>
	window.history.forward();
	function noBack() {
		window.history.forward();
	}

	function login() {
		var url = "<c:url value='/loginCheck.json'/>";
		var jsonData = {
			"empId" : $("#email").val(),
			"empPassword" : $("#pwd").val()
		};

		$.ajax({
			headers : {
				Accept : "application/json;utf-8"
			},
			contentType : "application/json;utf-8",
			dataType : "json",
			type : "POST",
			url : url,
			data : JSON.stringify(jsonData),
			success : function(data) {
				console.log(data);
				if (data.result == "idError") {
					alert("아이디 혹은 비밀번호를 확인하세요.");
				} else if (data.result == "pwdError") {
					alert("아이디 혹은 비밀번호를 확인하세요.");
				} else {
					location.href = "<c:url value='/mberList.do'/>";
				}
			}
		})
	}

	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}
	function empRegister() {
		location.href = "<c:url value='/loginEmpRegister.do'/>";
	}
</script>