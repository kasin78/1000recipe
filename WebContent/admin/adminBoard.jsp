<%@page import="java.util.List"%> <%@page import="java.util.ArrayList"%> <%@page import="recipe.model.UserInfo"%> <%@page import="recipe.model.loginBean"%> <%@page
import="recipe.model.registerBean"%> <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
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
    <link rel="stylesheet" href="css/boardview.css" />
    
  </head>
  <body>
    <!-- Header -->
    <jsp:include page="../common/header.jsp" />
	
    <!-- 관리자 게시판 리스트 보여주기 -->

        <div class="card" style="width:77rem; left: 151px;">
          <div class="card-body">
            <div class="table-responsive project-list">
              <table class="table" style="table-layout:fixed;">
                <thead>
                  <tr>
                    <th class="col-lg-1">공지사항</th>
                    <th class="col-lg-1">제목</th>
                    <th class="col-lg-1">글쓴이</th>
                    <th class="col-lg-1">작성일</th>
                    <th class="col-lg-1">조회수</th>
                    <c:if test="${who == 'admin'}">
                    	<th class="col-lg-1">관리하기</th>
                    </c:if>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="board" items="${boards}">
                    <tr>
                      <th scope="row" style="padding-top: 12px; padding-bottom: 12px;"><c:out value="공지사항" /></th>
                      <td style="padding-top: 12px; padding-bottom: 12px; text-overflow: ellipsis; overflow:hidden; white-space:nowrap; ">
                        <a href="<%=request.getContextPath()%>/board?action=selected&num=<c:out value='${board.num}'/>" style="color:black; text-decoration:none;">
                          <c:out value="${board.title}" />
                        </a>
                      </td>
                      <td style="padding-top: 12px; padding-bottom: 12px;"><c:out value="${board.userName}" /></td>
                      <td style="padding-top: 12px; padding-bottom: 12px;"><c:out value="${board.regDate}" /></td>
                      <td style="padding-top: 12px; padding-bottom: 12px;"><c:out value="${board.readCount}" /></td>
                      <c:if test="${who == 'admin'}">
                        <td>
                          <a href="<%=request.getContextPath()%>/board?action=getInfoUpdate&num=<c:out value='${board.num}'/>" class="btn btn-info btn-sm"> 수정 </a>
                          <a href="<%=request.getContextPath()%>/board?action=delete&num=<c:out value='${board.num}'/>" onclick="return confirm('정말 삭제하시겠습니까?');" class="btn btn-danger btn-sm"> 삭제 </a>
                        </td>
                      </c:if>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            <!-- 페이지 처리 -->
            <!-- c set으로 페이지컨텍스트에 저장해두기 -->
            <c:set var="paging" value="${(param.page == null)? 1:param.page}"/><!--1또는 현재 전달되고있는 p값을 항상 저장, 처음 페이지로 접속하면 p값이 null이기 때문에 1로 설정해둔다.  -->
            <c:set var="startNum" value="${paging-(paging-1)%5}"/>
            <c:set var="lastNum" value="${func:substringBefore(Math.ceil(count/10),'.')}"/>                  
            <!--count를 5페이지씩 짜르기(반올림), functions라이브러리 호출하고 서브스트링써서 실수로 나오는 점부분 제거 -->    
            <div class="pt-3">
              <ul class="pagination justify-content-center mb-0">
              	<c:if test="${startNum > 1}">
              	<!-- 밑에 a태그가 쓰일려면 0보다 커야한다 -->
                	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/board?action=list&page=${startNum-5}&search_text=">Previous</a></li>
                </c:if>
                
                <c:if test="${startNum <=1}">
                	<li class="page-item"><a class="page-link" onclick="alert('이전 페이지가 없습니다');">Previous</a></li>
                </c:if>
                
               	<c:forEach var="i" begin="0" end="4">
               		<c:if test="${(startNum+i) <= lastNum }">
                    <li class="page-item ${(paging==(startNum+i))? 'active' : ''}"><a class="page-link" href="<%=request.getContextPath()%>/board?action=list&page=${startNum+i}&search_text=${param.query2}">${startNum+i}</a></li>
                    </c:if>
                </c:forEach>
                
                <c:if test="${startNum+4 < lastNum}">
                	<!-- 다음번호보다 lastNum이 더 크면 보이게  -->
                	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/board?action=list&page=${startNum+5}&search_text=">Next</a></li>
                	<!--next는 위의 가장큰값(startNum+4)보다 1이 더 큰수(startNum+5)가 된다 -->
                </c:if>
                
                <c:if test="${startNum+4 > lastNum}">
                <!-- 다음번호보가 lastNum보다 크거나 같으면 현재번호가 마지막이니깐 경고창표시  -->	
                	<li class="page-item"><a class="page-link" onclick="alert('다음 페이지가 없습니다');">Next</a></li>
                </c:if>
              </ul>
            </div>
        <!-- 검색창 -->
         <div style="text-align: center; margin-top: 12px;">
      		<form action="<%=request.getContextPath()%>/board?action=list" method="post">
      			<select> <!-- 관리자 게시판은 제목밖에 없기때문에 따로 name값을 주진 않음 -->
      			<option value="title" selected="selected">제목</option><!-- 제목1개라서 그냥 선택되게 함 -->
      			</select>
        			<input type="text" name="search_text" value="${param.search_text}"/> <!-- 텍스트박스에 적은거 컨트롤러에서 다시 넘겨받아서 그대로 유지할수있게  -->
        		<button type="submit" class="btn btn-secondary">검색</button>
      		</form>
      	</div>
      	<!-- 검색창 -->
      	
      	 <!-- 글쓰기 -->
      	<div style="text-align: end;">
    	<c:if test="${who == 'admin'}">
      		<div>
        		<button type="button" class="btn btn-dark" onclick="location.href='<%=request.getContextPath()%>/admin/adminBoardWrite.jsp'">글쓰기</button>
      		</div>
    	</c:if>
    	</div>
    	<!-- 글쓰기 --> 
         </div>
       </div>
   
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
  </body>
</html>
