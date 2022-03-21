<%@page import="java.util.List"%> <%@page import="java.util.ArrayList"%> <%@page import="recipe.model.UserInfo"%> <%@page import="recipe.model.loginBean"%> <%@page
import="recipe.model.registerBean"%> <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>1000개의 레시피</title>
    <!-- css 링크 -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/styleNoTable.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" />
  </head>
  <body>
    <!-- Header -->
    <jsp:include page="../common/header.jsp" />

    <!-- 게시판 작성 -->
    <form name="adminwrite" method="post" action="<%=request.getContextPath() %>/userboard?action=upload">
      <div class="container" style="padding-left: 270px; padding-right: 270px; font-size: 15px">
        <table class="table" style="text-align: center; border: 3px solid #dddddd">
          <thead>
            <tr>
              <th colspan="2" style="background-color: #eeeeee; text-align: center">자유게시글 작성</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>제목</td>
              <td><input type="text" name="title" style="width: 620px" /></td>
            </tr>
            <tr>
              <td>비밀번호</td>
              <td style="text-align: left; padding-left: 36px"><input type="password" name="password" style="width: 150px" /></td>
            </tr>
            <tr>
              <td style="text-align: center">내용</td>
              <td><textarea name="content" cols="85" rows="23"></textarea></td>
            </tr>
          </tbody>
        </table>

        <div style="text-align: right">
          <input type="submit" class="btn btn-info checkadmin" value="작성" style="margin-bottom: 10px" onclick="return writeCheck()" />
          <input
            type="button"
            class="btn btn-success"
            value="자유게시판 목록"
            style="margin-bottom: 10px"
            onclick="location.href='<%=request.getContextPath()%>/userboard?action=list'"
          />
        </div>
      </div>
    </form>
    <!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

    <!-- 자바스크립트 링크 -->
    <script src="<%=request.getContextPath() %>/js/jquery-3.6.0.js"></script>
    <script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/recipe.js"></script>
    <script src="<%=request.getContextPath() %>/js/mainModalScript.js"></script>
    <script>
      $(document).ready(function () {
        $('#myPage').on('click', function (e) {
          $('#modal-myUserPage').modal('show');
        });
      });
    </script>
    <script>
      function writeCheck() {
        var a = document.adminwrite.title.value.length;
        var b = document.adminwrite.password.value.length;
        var c = document.adminwrite.content.value.length;
        if (a == 0) {
          alert('제목을 입력하세요');
          return false;
        }
        if (b == 0) {
          alert('비밀번호를 입력하세요');
          return false;
        }
        if (c == 0) {
          alert('내용을 입력하세요');
          return false;
        }
        if (a != 0 && b != 0 && c != 0) {
          if (confirm('작성하시겠습니까?')) {
            alert('작성완료');
          } else {
            alert('게시판으로 돌아갑니다.');
          }
        }
        return true;
      }
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </body>
</html>
