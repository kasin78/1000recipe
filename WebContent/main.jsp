<%@page import="recipe.dao.userboardDaoImpl"%>
<%@page import="recipe.dao.boardDaoImpl"%>
<%@page import="recipe.model.boardBean"%>
<%@page import="recipe.model.userboardBean"%>
<%@page import="recipe.dao.userboardDao" %>
<%@page import="recipe.dao.boardDao" %>
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
    <link rel="stylesheet" href="css/styleWithTable.css" />
    <link rel="stylesheet" href="css/main.css" />
  </head>
  <body>
    <jsp:include page="common/header.jsp" />

    <%-- 레시피, 자유게시판, 공지사항 게시판 데이터 불러오기 --%>
    <%
    	userboardDao userboardDao = new userboardDaoImpl(); 	
    	List<userboardBean> userBoard = userboardDao.showMainUserBoard();
    	request.setAttribute("userBoard", userBoard);
    	
    	boardDao boardDao = new boardDaoImpl(); 	
    	List<boardBean> adminBoard = boardDao.showMainAdminBoard();
    	request.setAttribute("adminBoard", adminBoard);	
    %>

    <!-- 메인페이지 캐로셀 -->
    <div class="container-fluid">
      <div class="row">
        <div class="col" style="margin: 0; padding: 0">
          <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="img/갈비찜.jpg" class="d-block w-100" alt="..." />
              </div>
              <div class="carousel-item">
                <img src="img/초밥.jpg" class="d-block w-100" alt="..." />
              </div>
              <div class="carousel-item">
                <img src="img/탕수육.jpg" class="d-block w-100" alt="..." />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div id="leftHead" class="col-2" style="margin: 0; padding: 0">BEST 요리 레시피</div>
        <div class="col-8">
          <div class="container">
            <div class="row">
              <div id="allBoard" class="mt-2">
                <!-- 공지사항 게시판 - 제목 날짜는 jsp로 데이터 받아오기 -->
                <table id="notice" class="col-sm-5 mb-2" style="float: left">
                  <tr>
                    <th>공지사항</th>
                    <th><a href='<%=request.getContextPath()%>/board?action=list'>더보기</a></th>
                  </tr>
                  <c:forEach var="adminBoard" items="${adminBoard}">
                  <tr>
                    <td><c:out value="${adminBoard.title}"></c:out></td>
                    <td><c:out value="${adminBoard.regDate}"></c:out></td>
                  </tr>
                  </c:forEach>
                </table>
                <!-- 자유게시판 - 제목 날짜는 jsp로 데이터 받아오기 -->
                <table id="freeBoard" class="col-sm-5 mb-2" style="float: left">
                  <tr>
                    <th>자유게시판</th>
                    <th><a href='<%=request.getContextPath()%>/userboard?action=list'>더보기</a></th>
                  </tr>
                  <c:forEach var="userBoard" items="${userBoard}">
                  <tr>
                    <td><c:out value="${userBoard.title}"></c:out></td>
                    <td><c:out value="${userBoard.regDate}"></c:out></td>
                  </tr>
                  </c:forEach>
                </table>
              </div>
            </div>
            <div class="row">
              <table class="table table-borderless" id="bestRecipe">
                <thead>
                  <tr>
                    <td scope="col"><img src="img/요리1.jpg" alt="" /></td>
                    <td scope="col"><img src="img/요리2.jpg" alt="" /></td>
                    <td scope="col"><img src="img/요리3.jpg" alt="" /></td>
                    <td scope="col"><img src="img/요리4.jpg" alt="" /></td>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row">타코야끼</th>
                    <td>삼겹살</td>
                    <td>비빔밥</td>
                    <td>피자</td>
                  </tr>
                  <tr>
                    <th scope="row">요리설명</th>
                    <td>요리설명</td>
                    <td>요리설명</td>
                    <td>요리설명</td>
                  </tr>
                  <tr>
                    <td scope="col"><img src="img/요리1.jpg" alt="" /></td>
                    <td scope="col"><img src="img/요리2.jpg" alt="" /></td>
                    <td scope="col"><img src="img/요리3.jpg" alt="" /></td>
                    <td scope="col"><img src="img/요리4.jpg" alt="" /></td>
                  </tr>
                </tbody>

                <tbody>
                  <tr>
                    <th>타코야끼</th>
                    <td>삼겹살</td>
                    <td>비빔밥</td>
                    <td>피자</td>
                  </tr>
                  <tr>
                    <th>요리설명</th>
                    <td>요리설명</td>
                    <td>요리설명</td>
                    <td>요리설명</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <!-- 광고 -->
        <div class="col-2" style="padding: 0">
          <div id="advertise">
            <img src="img/광고.png" alt="" />
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="common/footer.jsp" />

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
