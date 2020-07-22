<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IsgBeauty 프로젝트</title>
<link rel="stylesheet"
	href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
	function home() {
		location.href = "<c:url value='/login.do'/>";
	}

	/* 글 등록 function */
	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				if($("#snCheck").val()=="true") {
					var check = confirm("관리자를 등록하시겠습니까?");
					if (check) {
						document.detailForm.action = "<c:url value= '/addAdmin.do'/>";
						document.detailForm.submit();
						alert("등록되었습니다.");
					} else {
						alert("취소하셨습니다.");
					}
				} else {
					alert("시리얼 키를 확인해주세요.");
				}
			},
			rules: {
				empId: {
					required : true
				},
				empPassword: {
					required : true,
					minlength : 4
				},
				empNm: {
					required : true
				},
				telno: {
					required : true,
					digits : true
				}
			},
			messages: {
				empId: {
					required : "필수 입력 항목입니다.",
				},
				empPassword: {
					required : "필수 입력 항목입니다.",
					minlength : "비밀번호는 최소 4자리 이상입니다."
				},
				empNm : {
					required : "필수 입력 항목입니다."
				},
				telno : {
					required : "필수 입력 항목입니다.",
					digits : "숫자만 입력할 수 있습니다."
				}
			}
		});
	});

	function snKeyCehck() {
		 var url  =  "<c:url value='/addAdminCheck.json'/>";
		 var jsonData = {"snKey": $("#snKey").val()};
		 $.ajax({

			headers: {
				Accept: "application/json;utf-8"
			}
			,contentType: "application/json;utf-8"
			,dataType: "json"
			,type: "POST"
			,url: url
			,data: JSON.stringify(jsonData)
			,success:function(data){
				console.log(data);

				if(data.result=="true") {
					 $("#snCheck").val("true");
					 alert("사용 가능한 시리얼 키 입니다.");
				} else {
					$("#snCheck").val("false");
					alert("올바르지 않은 시리얼 키입니다.");
				}

			}
			,error:function(e){
			   	console.log(e.status, e.statusText);
			   	alert("서버 오류 입니다. 관리자에게 문의하세요.");
			}
		});
	}


</script>
</head>
<style>
label {
	margin-top: 30px;
}

input {
	margin-top: 30px;
}

select {
	margin-top: 30px;
}
</style>
<body>
	<%
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(now);
	%>
	<form:form commandName="empVO" id="detailForm" name="detailForm"
		method="post">
		<div class="container">
			<div class="jumbotron text-center alert-success" style="margin-top:30px" role="alert"
				onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<p>
					<b>관리자 회원가입 화면입니다.</b>
				</p>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class=" form-inline form-group">
					<label for="empId" class="col-sm-2 col-sm-offset-1 control-label">아이디*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empId" name="empId">
					</div>

					<label for="empPassword"
						class="col-sm-2 col-sm-offset-1 control-label">비밀번호*:</label>
					<div class="col-md-3">
						<input type="password" class="form-control" id="empPassword"
							name="empPassword">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="empNm" class="col-sm-2 col-sm-offset-1 control-label">이름*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empNm" name="empNm">
					</div>

					<label for="telno" class="col-sm-2 col-sm-offset-1 control-label">전화번호*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="telno" name="telno">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="sexdstn" class="col-sm-2 col-sm-offset-1 control-label">성별*:</label>
					<div class="col-md-3">
						<select type="text" class="form-control" id="sexdstn"
							name="sexdstn">
							<option value="Male" selected="selected">Male</option>
							<option value="Female">Female</option>
						</select>
					</div>

					<label for="pspofc" class="col-sm-2 col-sm-offset-1 control-label">직책:</label>
					<div class="col-md-3">
						<select type="text" class="form-control" id="pspofc" name="pspofc" disabled="disabled">
							<option value="Admin" selected="selected">Admin</option>
							<option value="Designer">Designer</option>
						</select>
					</div>
				</div>
				<div class="form-inline form-group">

					<label for="snKey"
						class="col-sm-2 col-sm-offset-1 control-label">시리얼 키*:</label>
					<div class="col-md-3">
						<input type="password" class="form-control" id="snKey"
							name="snKey" value="123456">
					</div>
					<label for="updtId" class="col-sm-2 col-sm-offset-1 control-label">등록일:</label>
					<div class="col-md-3">
						<input type="date" class="form-control" id="registDt"
							name="registDt" value="<%=today%>" readonly >
					</div>
				</div>
				<button type="button" class=" btn btn-info" onclick="snKeyCehck()">시리얼 확인</button>


			</div>
		</div>
				<input type="hidden" class="form-control" id="registId"
							name="registId" value="test" readonly >
				<input type="hidden" id="snCheck" name="snCheck" value="false" readonly >

		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-success" onclick="" >등록</button>
			<button type="button" class=" btn btn-info" onclick="home()">취소</button>
		</div>

	</form:form>
</body>
</html>