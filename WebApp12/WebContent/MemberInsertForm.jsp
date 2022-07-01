<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">

<script type="text/javascript">

	function memberSubmit()
	{
		// 확인
		//alert("함수 호출 확인~!!!");
		
		var memberForm = document.getElementById("memberForm");
		var uName = document.getElementById("uName");
		var nameMsg = document.getElementById("nameMsg");		//-- 이거 빼도 되는 거 아닌가,,? 확인해보기,!!
		
		// 다시 이 함수 요청했을 때, 
		// 이미 해결된 상태면 안보여야 하기 때문에, 아래와 같이 style 처리
		nameMsg.style.display = "none";
		
		if (uName.value == "")
		{
			// 에러문구 화면에 띄어주게 style 처리
			nameMsg.style.display = "inline";
			uName.focus();
			return;
		}
		
		// form 을 직접 지정하여 submit 액션
		memberForm.submit();
	}
	
	function memberReset()
	{
		// 확인
		//alert("함수 호출 확인~!!!");
		
		//나
		//document.getElementById("uName").value = "";
		//document.getElementById("uTel").value = "";
		
		//쌤
		var memberForm = document.getElementById("memberForm");
		
		nameMsg.style.display = "none";
		
		// form 을 직접 지정하여 reset 액션
		memberForm.reset();
		
		// 사용자 편의성 고려
		uName.focus();
	}

</script>

</head>
<body>

<div>
	<h1>회원 <span style="color: red;">명단</span> 관리
		  및 <span style="color: red;">입력</span> 페이지</h1>
	<hr />
</div>

<div>
	<a href="MemberSelect.jsp"><button type="button">회원 명단 관리</button></a>
</div>
<br />

<div>
	<!-- 회원 데이터 입력 폼 구성 -->
	<form action="MemberInsert.jsp" method="post" id="memberForm">
		<table class="table">
			<tr>
				<th>이름(*)</th>
				<td>
					<input type="text" id="uName" name="uName"/>
				</td>
				<td>
					<span class="errMsg" id="nameMsg">이름을 입력해야 합니다.</span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" id="uTel" name="uTel"/>
				</td>
				<td>
				</td>
			</tr>
		</table>
		<br />
		<a href="javascript:memberSubmit()"><button type="button">입력하기</button></a>
		<a href="javascript:memberReset()"><button type="button">취소하기</button></a>
		<a href="MemberSelect.jsp"><button type="button">목록으로</button></a>
	</form>
</div>

</body>
</html>