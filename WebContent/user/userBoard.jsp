<%@page import="java.util.List"%> <%@page import="java.util.ArrayList"%> <%@page import="recipe.model.UserInfo"%> <%@page import="recipe.model.loginBean"%> <%@page
import="recipe.model.registerBean"%> <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<%@ taglib prefix = "func" uri ="http://java.sun.com/jsp/jstl/functions" %>


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

    <!-- 유저 게시판 리스트 보여주기 -->
    <div class="row">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-body">
            <div class="table-responsive project-list">
              <table class="table project-table table-centered table-nowrap">
                <thead>
                  <tr>
                  	<th scope="col">글번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">글쓴이</th>
                    <th scope="col">작성일</th>
                    <th scope="col">조회수</th>
                    <c:if test="${who == 'admin'}">
                    	<th scope="col">관리하기</th>
                    </c:if>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="board" items="${boards}">
                     <tr>
                      <th scope="row"><c:out value="${board.num}"/></th>
                      <td>
                        <a href="<%=request.getContextPath()%>/userboard?action=selected&num=<c:out value='${board.num}'/>" class="btn btn-info btn-sm">
                          <c:out value="${board.title}" />
                        </a>
                      </td>
                      <td><c:out value="${board.userName}" /></td>
                      <td><c:out value="${board.regDate}" /></td>
                      <td><c:out value="${board.readcount}" /></td>
                    </tr>
                     <c:if test="${who == 'admin'}">
                        <td>
                          <a href="<%=request.getContextPath()%>/userboard?action=deletedByAdmin&num=<c:out value='${board.num}'/>" onclick="return confirm('정말 삭제하시겠습니까?');" class="btn btn-info btn-sm"> 삭제 </a>
                        </td>
                      </c:if>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            <!-- 페이지 처리 -->
            <!-- startNum은 pagecontext에 저장 -->
          <c:set var="paging" value="${(param.page == null)? 1:param.page}"/><!--1또는 현재 전달되고있는 p값을 항상 저장, 처음 페이지로 접속하면 p값이 null이기 때문에 1로 설정해둔다.  -->
            <c:set var="startNum" value="${paging-(paging-1)%5}"/>
            <c:set var="lastNum" value="${func:substringBefore(Math.ceil(count/5),'.')}"/>                  
            <!--count를 5페이지씩 짜르기(반올림), functions라이브러리 호출하고 서브스트링써서 실수로 나오는 점부분 제거 -->    
            <div class="pt-3">
              <ul class="pagination justify-content-end mb-0">
              	<c:if test="${startNum > 1}">
              	<!-- 밑에 a태그가 쓰일려면 0보다 커야한다 -->
                	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/userboard?action=list&page=${startNum-5}&search_text=">Previous</a></li>
                </c:if>
                
                <c:if test="${startNum <=1}">
                	<li class="page-item"><a class="page-link" onclick="alert('이전 페이지가 없습니다');">Previous</a></li>
                </c:if>
                
               	<c:forEach var="i" begin="0" end="4">
               		<c:if test="${(startNum+i) <= lastNum }">
                    <li class="page-item ${(paging==(startNum+i))? 'active' : ''}"><a class="page-link" href="<%=request.getContextPath()%>/userboard?action=list&page=${startNum+i}&f=${param.f}&search_text=${param.query2}">${startNum+i}</a></li>
                    </c:if>
                </c:forEach>
                
                <c:if test="${startNum+4 < lastNum}">
                	<!-- 다음번호보다 lastNum이 더 크면 보이게  -->
                	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/userboard?action=list&page=${startNum+5}&search_text=">Next</a></li>
                	<!--next는 위의 가장큰값(startNum+4)보다 1이 더 큰수(startNum+5)가 된다 -->
                </c:if>
                
                <c:if test="${startNum+4 > lastNum}">
                <!-- 다음번호보가 lastNum보다 크거나 같으면 현재번호가 마지막이니깐 경고창표시  -->	
                	<li class="page-item"><a class="page-link" onclick="alert('다음 페이지가 없습니다');">Next</a></li>
                </c:if>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 검색창 -->
    
	<div>
      <form action="<%=request.getContextPath()%>/userboard?action=list" method="post">
      	<select name="f"> <!-- 관리자 게시판은 제목밖에 없기때문에 따로 name값을 주진 않음 -->
      		<option ${(param.f == "title")? "selected" : ""} value = "title">제목</option>
      		<option ${(param.f == "userName")? "selected" : ""} value = "userName">닉네임</option>
      	</select>
        <input type="text" name="search_text" value="${param.search_text}"/> <!-- 텍스트박스에 적은거 컨트롤러에서 다시 넘겨받아서 그대로 유지할수있게  -->
        <button type="submit" class="btn btn-info">검색</button>
      </form>
    </div>
    

    <!-- 글쓰기(유저만) -->
    <c:if test="${who == 'user'}">
    <div>
      <div>
        <button type="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/user/userBoardWrite.jsp'">글쓰기</button>
      </div>
    </div>
    </c:if>
    
	<!-- footer -->
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