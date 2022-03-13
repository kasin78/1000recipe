<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/styleNoTable.css" />
   
  </head>
  <body>
 		<jsp:include page="../common/header.jsp" />
    <!-- 네브바 끝 -->
    
    <!-- 본문 -->
    
       	<div class="form-group mb-2">
          	<label>제목</label>
          		<input type="text" class="form-control" name="recipeName" value="<c:out value='${recipe.recipeName}' />" readonly="readonly" required>
        </div>	 
       
		
		<!-- 요리소개 -->
		<div class="mb-3">
  			 <label for="exampleFormControlTextarea1" class="form-label">요리소개</label>
   			 <input type="text" class="form-control" name="description" value="<c:out value='${recipe.description}' />"  readonly="readonly" required>
		</div>
		
		<!-- 인원 -->
		<label>인원</label>
		<input type="text" class="form-control" name="peopleNumber" value="<c:out value='${recipe.peopleNumber}' />" readonly="readonly" required>
		
		
		<!-- 시간 -->
     	<label>시간</label>
		<input type="text" class="form-control" name="cookTime" value="<c:out value='${recipe.cookTime}' />" readonly="readonly" required>

		<!-- 난이도 -->
   		<label>난이도</label>
		<input type="text" class="form-control" name="difficulty" value="<c:out value='${recipe.difficulty}' />" readonly="readonly" required>
      
      	<!-- 재료 -->
  		<label for="exampleFormControlTextarea1" class="form-label">재료</label>
   		<input type="text" class="form-control" name="material" value="<c:out value='${recipe.material}' />" readonly="readonly" required>


      	<!-- 요리순서 -->
    	<label for="exampleFormControlTextarea1" class="form-label">요리순서</label>
   		<input type="text" class="form-control" name="cookOrder" value="<c:out value='${recipe.cookOrder}' />" readonly="readonly" required>
	  
	  	<!-- 요리팁 -->
	  <div class="form-group mb-2">
         <label>요리팁</label>
         <input type="text" class="form-control" name="cookTip" value="<c:out value='${recipe.cookTip}' />" readonly="readonly" required>
      </div>
        
        <!-- 태그 -->
      <div class="form-group mb-2">
         <label>태그</label>
         <input type="text" class="form-control" name="tag" value="<c:out value='${recipe.tag}' />" readonly="readonly" required>
      </div>



  		<div class="container text-right">
        	<a href="<%=request.getContextPath()%>/recipes?action=delete&id=${recipe.recipe_id}" class="btn btn-success">삭제하기</a>
      	</div>
      
      	<div class="container text-right">
        	<a href="<%=request.getContextPath()%>/recipes?action=edit&id=${recipe.recipe_id}" class="btn btn-success">수정하기</a>
      	</div>



	<!-- 본문 끝 -->
    
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