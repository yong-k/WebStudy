<%@ page contentType="text/html; charset=UTF-8"%>

<!-- Guest_ok.jsp에서 받은 값 넘겨받으려고 작업함 -->
<%-- 
<%
	request.setCharacterEncoding("UTF-8");
	
	String userName = request.getParameter("userName");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
%>
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Guest.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<script type="text/javascript">
	function sendIt()
	{
		var guestForm = document.guestForm;
		
		//		:
		// 체크 및 검증할 내용의 코드 작성...
		//		:
		
		guestForm.submit();
	}
</script>
</head>
<body>

<div>
	<h1>간단한 기본 방명록 작성 실습</h1>
	<hr />
</div>

<!-- Guest_ok.jsp 에서 받은 값 다시 넘겨봄 -->
<%-- 
<%=userName %> <br />
<%=subject %> <br />
<%=content %> <br /> 
--%> 

<div>
	<form action="Guest_ok.jsp" method="post" name="guestForm">
		<table class="table">
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="userName" class="txt" />
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="subject" class="txt" />
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" cols="32" rows="5"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" onclick="sendIt()" style="width:100%;" class="btn">방명록 작성</button>
				</td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>