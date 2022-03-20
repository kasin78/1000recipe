<%@page import="java.util.List"%> <%@page import="java.util.ArrayList"%> <%@page import="recipe.model.UserInfo"%> <%@page import="recipe.model.loginBean"%> <%@page
import="recipe.model.registerBean"%> <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>1000개의 레시피</title>
    <!-- css 링크 -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/styleNoTable.css" />
    <link rel="stylesheet" href="css/main.css" />
  </head>
  <body>
    <!-- Header -->
    <jsp:include page="../common/header.jsp" />

    <!-- 게시글 보기 -->

		<div class="container" style="padding-left: 270px; padding-right: 270px; font-size:15px;">
			    <table class="table" style="text-align:center; border: 3px solid #dddddd;">
			    	<thead>
			    		<tr>
			    		  <th colspan="2" style="background-color: #eeeeee; text-align: center;">공지사항 보기</th>
			    		</tr>
			    	</thead>
			    	<tbody>
              		<tr>
                		<td style="width: 20%;">제목</td>
                		<td colspan="2" style="text-align:left">${boards.title}</td>
              		</tr>
               		<tr>
                		<td>등록일시</td>
                		<td colspan="2" style="text-align:left">${boards.regDate}</td>
              		</tr>
               		<tr>
                		<td>조회수</td>
                		<td colspan="2" style="text-align:left">${boards.readCount}</td>
              		</tr>
              		<tr>
              			<td>글내용</td>
                		<td colspan="2" style="height: 500px; max-width:100px; text-align:left; overflow:auto;">${boards.content}</td>
              		</tr>
              		</tbody>
            	</table>
            	<div style="text-align:end">
       				<input type="button" class="btn btn-success" value="공지사항 목록" style="margin-bottom: 10px;" onclick="location.href='<%=request.getContextPath()%>/board?action=list'" />		
          		</div>
			</div>

       <!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

     <!-- 자바스크립트 링크 -->
    <script src="js/jquery-3.6.0.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/recipe.js"></script>
    <script src="js/mainModalScript.js"></script>
    <script>
      $(document).ready(function () {
        $('#myPage').on('click', function (e) {
          $('#modal-myUserPage').modal('show');
        });
      });
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </body>
</html>
