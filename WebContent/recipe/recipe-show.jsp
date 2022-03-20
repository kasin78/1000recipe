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
    <!-- 네브바 끝 -->
    
    <!-- 본문 -->
		<div class="card">
           <div id="card" class="card-body">
       	<div id ="title" class="form-group mb-2">
       		<label id="label">제목</label>
       		<br>
          	<input type="text" class="form-control" id ="titleshow" value="<c:out value='${recipe.recipeName}' />" readonly="readonly" required>
        </div>	 
       
       <br>
		
		<!-- 요리소개 -->
		<div id="description" class="mb-3">
  			 <label id="label" for="exampleFormControlTextarea1" class="form-label">요리소개</label>
  			  <textarea id="descriptionshow" class="form-control" readonly="readonly"  required><c:out value="${recipe.description}"/></textarea>
		</div>
		
	
		<div  class= "cont_line">
		<p id="label" class ="cont_tit4">요리정보</p>
		<!-- 카테고리 -->
		<label id="label">카테고리</label>
		<input id="categoryshow" type="text" class="form-control" name="peopleNumber" value="<c:out value='${recipe.category}' />" readonly="readonly" required>
		
		<!-- 인원 -->
		<label id="label">인원</label>
		<input id="peopleshow" type="text" class="form-control" name="peopleNumber" value="<c:out value='${recipe.peopleNumber}' />" readonly="readonly" required>
		
		
		<!-- 시간 -->
     	<label id="label">시간</label>
		<input id="timeshow" type="text" class="form-control" name="cookTime" value="<c:out value='${recipe.cookTime}' />" readonly="readonly" required>

		<!-- 난이도 -->
   		<label id="label">난이도</label>
		<input id="difficultyshow" type="text" class="form-control" name="difficulty" value="<c:out value='${recipe.difficulty}' />" readonly="readonly" required>
      </div>
   </div>
   </div>
      
      <br>
      <br>
      
      <div class="card">
        <div id="card"  class="card-body">
        
          <div class="col-2" style="padding: 0">
          	<div id="advertise">
           		 <img src="img/광고.png" alt="" />
          	</div>
          </div>
        
      	<!-- 재료 -->
      	<div  class="mb-3">
  			<label id="label" for="exampleFormControlTextarea1" class="form-label">재료</label>
  			<textarea id="materialshow" class="form-control" readonly="readonly"  required ><c:out value="${recipe.material}"/></textarea>
		</div>	
	  

      	<!-- 요리순서 -->
      	 <div class="mb-3">
    		<label id="label" for="exampleFormControlTextarea1" class="form-label">요리순서</label>
    		<textarea id="cookOrdershow"  class="form-control" name="cookOrder" id="exampleFormControlTextarea1" rows="3" readonly="readonly" required><c:out value="${recipe.cookOrder}"/></textarea>
	  	</div>
	   </div>
	  </div>	
	  
	  <br>
	  <br>
	  
	    <div class="card">
        <div id="card"  class="card-body">
	  
	  	<!-- 요리팁 -->
	  <div class="form-group mb-2">
         <label id="label">요리팁</label>
         <textarea id="cookTipshow" class="form-control" name="cookTip" id="cookTip" rows="3" readonly="readonly"  required><c:out value="${recipe.cookTip}"/></textarea>
      </div>
        
        <!-- 태그 -->
      <div class="form-group mb-2">
         <label id="label">태그</label>
         <input type="text" class="form-control" id="cookTagshow" value="<c:out value='${recipe.tag}' />" readonly="readonly" required>
      </div>
	</div>
	</div>


	<br>
	<br>
	
  		<div id="regi" class="form-group d-grid">
        	<button id="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/recipes?action=delete&id=${recipe.recipe_id}'" >삭제하기</button>
        	<button id="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/recipes?action=edit&id=${recipe.recipe_id}'" >수정하기</button>
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