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
<script type="text/javaScript" language="javascript" defer="defer">
	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}
	function deleteMber() {
		document.detailForm.action = "<c:url value='/deleteMber.do'/>";
       	document.detailForm.submit();
	}
</script>
<style>
label {
	margin-top: 30px;
}

p {
	margin-top: 30px;
}
</style>
</head>
<body>
	<form:form commandName="mberVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<div class="jumbotron text-center alert-info" role="alert"
				onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<h4 for="mberSn" class="control-label">
					'
					<c:out value="${result.mberNm}" />
					'님 상세화면
				</h4>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="form-inline form-group">
					<label for="mberSn" class="col-sm-2 col-sm-offset-1 control-label">순번:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.mberSn}" />
						</p>
					</div>

					<label for="eEmpId" class="col-sm-2 col-sm-offset-1 control-label">담당
						직원:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.eEmpId}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="mberNm" class="col-sm-2 col-sm-offset-1 control-label">이름:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.mberNm}" />
						</p>
					</div>

					<label for="registId"
						class="col-sm-2 col-sm-offset-1 control-label">등록자:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.registId}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="sexdstn" class="col-sm-2 col-sm-offset-1 control-label">성별:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.sexdstn}" />
						</p>
					</div>

					<label for="registDt"
						class="col-sm-2 col-sm-offset-1 control-label">등록일:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.registDt}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="telno" class="col-sm-2 col-sm-offset-1 control-label">전화번호:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.telno}" />
						</p>
					</div>

					<label for="updtId" class="col-sm-2 col-sm-offset-1 control-label">수정자:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.updtId}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="brthdy" class="col-sm-2 col-sm-offset-1 control-label">생년월일:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.brthdy}" />
						</p>
					</div>

					<label for="updtDt" class="col-sm-2 col-sm-offset-1 control-label">수정일:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.updtDt}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="updtDt" class="col-sm-2 col-sm-offset-1 control-label">예약내용:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<a href="">예약 내용</a>
						</p>
					</div>
				</div>
			</div>
		</div>

		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="button" class="btn btn-info" onclick="">수정</button>
			<button type="button" class="btn btn-info" onclick="deleteMber()">삭제</button>
			<button type="button" class=" btn btn-danger" onclick="">예약상태</button>
			<button type="button" class=" btn btn-info" onclick="home()">이전</button>
		</div>

	</form:form>
</body>
</html>