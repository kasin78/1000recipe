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

    <!-- 게시판 작성 -->
    <form name="adminedit" method="post" action="<%=request.getContextPath() %>/board?action=update">
      <input type="hidden" name="num" value="${boards.num}" />
      <!-- hidden타입으로 추가로 가져옴(구글참고) -->
      <input type="hidden" name="readCount" value="${boards.readCount}" />
      <input type="hidden" name="userName" value="${boards.userName}" />
      <table style="padding-top: 50px" align="center" width="700" border="0" cellpadding="2">
        <tr>
          <td height="20" align="center" bgcolor="#ccc"><font color="white"> 글쓰기</font></td>
        </tr>
        <tr>
          <td bgcolor="white">
            <table class="table2">
              <tr>
                <td>제목</td>
                <td><input type="text" name="title" size="60" value="${boards.title}" /></td>
              </tr>
              <tr>
                <td>내용</td>
                <td><textarea name="content" cols="85" rows="15">${boards.content}</textarea></td>
              </tr>
            </table>
            <input type="submit" class="btn btn-success checkadmin" value="수정하기" onclick="return editCheck();" />
            <input type="button" class="btn btn-success" value="공지사항 목록" onclick="location.href='<%=request.getContextPath()%>/board?action=list'" />
          </td>
        </tr>
      </table>
    </form>
    <script>
      function editCheck() {
    	  var a = document.adminedit.title.value.length;
    	  var b = document.adminedit.content.value.length;
        if (a == 0) {
          alert('제목을 입력하세요');
          return false;
        }
        if (b == 0) {
          alert('내용을 입력하세요');
          return false;
        }
        if (a!=0 && b!=0){
    	  	if (confirm("수정하시겠습니까?")){
    	  		alert("수정완료");
    	  	} else{
    	  		alert("게시판으로 돌아갑니다.");
    	  	} 	
    	  }
    	 return true;
      }
    
    </script>
    <!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

    <!-- 자바스크립트 링크 -->
    <script src="../js/jquery-3.6.0.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/script.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </body>
</html>
