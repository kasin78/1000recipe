<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css" />
  </head>
  
  <body>
 
 		<jsp:include page="../common/header.jsp" />
 
    <!-- 본문 -->
     <div class="container mt-5">
      <h3 class="text-center"><c:out value="${categoryName}"/>게시판</h3>
      <hr />
      
      <br />
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
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
	
	
   <div class="d-grid gap-2 d-md-flex justify-content-md-end">
   		<div class="container text-right">
        <a href="<%=request.getContextPath()%>/recipes?action=new&category=<c:out value="${categoryName}"/>" class="btn btn-success">글쓰기</a>
      </div>
   </div>
  
    <!-- 본문 끝 -->
    
    <jsp:include page="../common/pagination.jsp"/>
    <jsp:include page="../common/footer.jsp" />

	<!-- 자바스크립트 링크 -->
 	  <script src="js/jquery-3.6.0.js"></script>
    <script src="<%=request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
    <script src="js/recipe.js"></script>
  </body>
</html>