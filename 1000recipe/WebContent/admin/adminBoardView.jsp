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
                <td>등록일시</td>
                <td>${boards.regDate}</td>
              </tr>
               <tr>
                <td>조회수</td>
                <td>${boards.readCount}</td>
              </tr>
              <tr>
              	<td>글내용</td>
                <td>${boards.content}</td>
              </tr>
            </table>
            <input type="button" class="btn btn-success" value="공지사항 목록" onclick="location.href='<%=request.getContextPath()%>/board?action=list'" />
          </td>
        </tr>
      </table>
    <!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

    <!-- 자바스크립트 링크 -->
    <script src="../js/jquery-3.6.0.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/script.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </body>
</html>
