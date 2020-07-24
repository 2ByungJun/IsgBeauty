<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IsgBeauty 프로젝트</title>
<link rel="stylesheet"
	href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>
</head>
<script type="text/javaScript" language="javascript" defer="defer">

<%if (session.getAttribute("empId") != null) {%>
	alert("이미 로그인 중입니다..");
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

<style>
.bjLabel {
	margin-top: 5px;
}

.bjInput {
	width: 200px;
	margin-top: 5px;
}
</style>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();">

	<div class="container">
		<header class="page-header">
		<div class="container">
			<div style="text-align: center;" alt="IsgBeauty 로고">
				<img src="<c:url value='images/logo.jpg' />">
			</div>
		</div>
		</header>
	</div>
	<form class="form-horizontal" style="display: grid; margin-top:20px;">
		<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

			<!-- Start(35%) -->
			<div style="width: 35%;"></div>


			<!-- Center(label)(10%) -->
			<div style="width: 10%; text-align: center;">
				<p>
					<label class="bjLabel control-label" for="email">ID : </label>
				</p>
				<p>
					<label class="bjLabel control-label" for="pwd">Password : </label>
				</p>
			</div>

			<!-- Center(input)(20%) -->
			<div style="width: 20%; text-align: left;">
				<div style="display: inline-flex;">
					<input type="text" class="bjInput form-control" id="email"
						name="email" placeholder="아이디를 입력해주세요" value=관리자>
				</div>

				<div style="display: inline-flex;">
					<input type="password" class="bjInput form-control" id="pwd"
						name="pwd" placeholder="비밀번호를 입력해주세요" value=1234
						onkeydown="if(event.keyCode==13) login()">
				</div>
			</div>


			<!-- Start(35%) -->
			<div style="width: 35%;"></div>
		</div>
	</form>
	<div class="container" style="text-align: center;">
		<button type="button" class="btn btn-primary" onclick="login()">로그인</button>
		<button type="button" class=" btn btn-info" onclick="empRegister()">회원가입</button>
	</div>
	<jsp:include page="/common/layouts/userLayout/footer.jsp"></jsp:include>
</body>
</body>
</html>