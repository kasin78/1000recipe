<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>

</head>
<body>

	<div align="center">	
		<form name ="fm" method="post" action="<%=request.getContextPath()%>/userboard?action=deletecheckPass" target="openerWin">
			<input type="hidden" id="num1" name="num" value="<%=request.getParameter("num")%>"> 
			<input type="hidden" id="boardpassword" name="password" value="<%=request.getParameter("password")%>">
			<table>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" id="typing_password" name="typingNum"></td>
					<td><input type="button" value="확인" onclick="send()"></td>
				</tr>
			</table>
		</form>
	</div>

	<script>
		function send() {
			if(confirm("삭제하시겠습니까?")){
				document.fm.submit();
				self.close();	
			}
		}
	</script>
	<script src="js/jquery-3.6.0.js"></script>
</body>
</html>