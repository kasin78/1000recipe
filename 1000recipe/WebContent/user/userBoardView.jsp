<%@page import="java.util.List"%> <%@page import="java.util.ArrayList"%> <%@page import="recipe.model.UserInfo"%> <%@page import="recipe.model.loginBean"%> <%@page
import="recipe.model.registerBean"%> <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>1000개의 레시피</title>
    <!-- css 링크 -->
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/style.css" />
    <link rel="stylesheet" href="../css/main.css" />
  </head>
  <body>
    <!-- Header -->
    <jsp:include page="../common/header.jsp" />

    <!-- 게시글 보기 -->
    <c:set var="num" value="${boards.num}" />
    <c:set var="boardpassword" value="${boards.password}"/>
      <table style="padding-top: 50px" align="center" width="700" border="0" cellpadding="2">
        <tr>
          <td height="20" align="center" bgcolor="#ccc"><font color="white"> 글 내용 </font></td>
        </tr>
        <tr>
          <td bgcolor="white">
            <table class="table2">
              <tr>
                <td>제목</td>
                <td>${boards.title}</td>
              </tr>
              <tr>
              	<td>작성자</td>
              	<td>${boards.userName}</td>
              </tr>
               <tr>
                <td>등록일시</td>
                <td>${boards.regDate}</td>
              </tr>
               <tr>
                <td>조회수</td>
                <td>${boards.readcount}</td>
              </tr>
              <tr>
              	<td>글내용</td>
                <td>${boards.content}</td>
              </tr>
                    
            </table>
            
            <input type="button" class="btn btn-success" value="자유게시판 목록" onclick="location.href='<%=request.getContextPath()%>/userboard?action=list'" />
                    
           <c:if test="${who=='user'}"> <!-- 유저 로그인상태일때 해당 게시글 비번 입력하고 수정/삭제 버튼 -->
 			  <div class="col-sm-3">
 			  	<input type="hidden" id="checknum" value="${boards.num}"/> <!-- 자식창에 보낼 보고있는 게시글의 번호 -->
 			  	<input type="hidden" id="checkboardpass" value="${boards.password}"/> <!-- 자식창 윈도우에 보낼 보고있는 게시글 비밀번호 -->
 			  	<input type="submit" class="btn btn-success" value="수정하기" onclick="updatepassCheck(${boards.num},'${boards.password}')" /> <!--boards.password를 ''로 한번더 안감싸니깐 문자로 인식을 안해서? 창이안열리는거같음  -->
 			  	<input type="submit" class="btn btn-success" value="삭제하기" onclick="deletepassCheck(${boards.num},'${boards.password}')" />
              </div>
           </c:if>
          </td>
        </tr>
      </table>
   
   <!--게시판 수정/삭제시 비밀번호 확인 모달창 -->   

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp" />
    <!-- 자바스크립트 링크 -->
    <script src="../js/jquery-3.6.0.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/script.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
	window.name='openerWin';
	var popHeight = 400; //띄울 팝업창 높이   
	var popWidth = 400;  // 띄울 팝업창 너비
	var winHeight = document.body.clientHeight;	// 현재창의 높이
	var winWidth = document.body.clientWidth; // 현재창의 너비
	var winX = window.screenLeft; // 현재창의 x좌표
	var winY = window.screenTop; // 현재창의 y좌표
	var popX = winX + (winWidth - popWidth)/2;
	var popY = winY + (winHeight - popHeight)/2;
	
  	  // 글 수정 
  	  function updatepassCheck(num, password){ 
  		var num=num;
  		var password=password;
  		  window.open("<%=request.getContextPath()%>/user/updatepassCheck.jsp?num="+num+"&password="+password, "비밀번호 확인하기",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
  		// 자식창의 window객체를 windowSub 변수에 저장
  	  }
      function deletepassCheck(num, password){ 
        var option="width=200, height=300, top=200"
      	var num=num;
      	var password=password;
      	  window.open("<%=request.getContextPath()%>/user/deletepassCheck.jsp?num="+num+"&password="+password, "비밀번호 확인하기", "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
      		// 자식창의 window객체를 windowSub 변수에 저장
      	  }
  	  
	</script>
  </body>
</html>
