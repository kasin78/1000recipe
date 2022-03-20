<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/styleNoTable.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/recipe.css" />
  </head>
  
  <body>
 
 		<jsp:include page="../common/header.jsp" />
 
    <!-- 본문 -->
     
      <h3 class="text-center"><c:out value="${categoryName}"/>게시판</h3>
      <hr />
      
      <br />
        <div class="row">
      	 <div class="col-lg-12">
          <div class="card">
           <div id="card"  class="card-body">
            <div class="table-responsive project-list">
      <table class="table project-table table-centered table-nowrap">
        <thead>
          <tr>
            <th>글번호</th>
            <th>제목</th>
            <th>글쓴이</th>
            <th>작성일</th>
            <th>조회수</th>
          </tr>
        </thead>
        
        <tbody>        
          <!-- 게시판 데이터(리스트)를 테이블로 가져오기-->
          <c:forEach var="recipe" items="${listRecipe}">
            <tr>
              <td><c:out value="${recipe.recipe_id}" /></td>
              <td><a href="<%=request.getContextPath()%>/recipes?action=show&id=${recipe.recipe_id}"><c:out value="${recipe.recipeName}" /></a></td>
              <td><c:out value="${recipe.userName}" /></td>
              <td><c:out value="${recipe.regDate}" /></td>       	
              <td><c:out value="${recipe.viewCount}" /></td>       	
            </tr>
          </c:forEach> 
       	</tbody>

  	   </table> 
  	   
  	   </div>
	            </div>
          </div>
        </div>
      </div>
    <!-- 본문 끝 -->
    
    <br>
    
        <!-- 글쓰기(유저만) -->
    <c:if test="${who == 'user'}">
    <div>
      <div>
        <button type="button" id="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/recipe/recipe-write.jsp'">글쓰기</button>
      </div>
    </div>
    </c:if>
    
   

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