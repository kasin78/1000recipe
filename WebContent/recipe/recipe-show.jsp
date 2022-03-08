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
    <!-- 네브바 끝 -->
    
    <!-- 본문 -->
       	
    	
      <br />
      <table class="table table-bordered">
        <thead>
       		<tr>
            	<th>제목</th>
            	<th>조회수</th>
            </tr>	
        </thead>
        <tbody>
          <td><c:out value="${recipe.recipeName}" /></td>
          <td colspan="2"><c:out value="${recipe.viewCount}" /></td>
       	</tbody>
       	
       	 <thead>
       		<tr>
            	<th>인원</th>
            	<th>시간</th>
            	<th>난이도</th>
            </tr>	
        </thead>
        <tbody>
          <td><c:out value="${recipe.peopleNumber}" /></td>
          <td><c:out value="${recipe.cookTime}" /></td>
          <td><c:out value="${recipe.difficulty}" /></td>
       	</tbody>
        
	  <thead>
       		<tr>
            	<th>요리소개</th>
            </tr>	
        </thead>
        <tbody>
          <td><c:out value="${recipe.description}" /></td>
       	</tbody>
	</table> 
	<tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
	
	<br />
	<table class="table table-bordered">
		<thead>
       		<tr>
            	<th>재료</th>
            </tr>	
        </thead>
        
        <tbody>
          <td><c:out value="${recipe.material}" /></td>
       	</tbody>
	</table> 
	<tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>	
	
	<table class="table table-bordered">
		<thead>
       		<tr>
            	<th>요리순서</th>
            </tr>	
        </thead>
        
        <tbody>
          <td><c:out value="${recipe.cookOrder}" /></td>
       	</tbody>
	</table> 
	
	<table class="table table-bordered">
	<thead>
        <tr>
            <th>요리 꿀팁</th>
            <th>태그</th>
        </tr>	
    </thead>
        <tbody>
          <td><c:out value="${recipe.cookTip}" /></td>
          <td><c:out value="${recipe.tag}" /></td>
       	</tbody>
    </table>    	
	<tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>	
 	
 	  <div class="container text-right">
        	<a href="<%=request.getContextPath()%>/recipes?action=delete&id=${recipe.recipe_id}" class="btn btn-success">삭제하기</a>
      </div>
      
      <div class="container text-right">
        	<a href="<%=request.getContextPath()%>/recipes?action=edit&id=${recipe.recipe_id}" class="btn btn-success">수정하기</a>
      </div>
 
 
   </div>
  
    <!-- 본문 끝 -->
    
      <jsp:include page="../common/footer.jsp" />   
    
    <script src="js/jquery-3.6.0.js"></script>
    <script src="<%=request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
    <script src="js/recipe.js"></script>
  </body>
</html>