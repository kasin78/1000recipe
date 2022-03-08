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
    <header>
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-3">
            <!-- 메인페이지 로고 -->
            <div id="logo">
              <img src="img/free-icon-dish-1404970.png" class="rounded float-left" alt="" style="width: 100px; height: 100px" />
              <span style="font-size: x-large; font-style: oblique" class="ml-3">1000개의 레시피</span>
            </div>
          </div>
          <div class="col-sm-6">
            <!-- 메인 페이지 검색창 -->
            <div id="search" class="input-group mt-3 mb-3 float-left">
              <div class="container h-100 mb-3">
                <div class="d-flex justify-content-center h-100">
                  <div class="searchbar">
                    <input class="search_input" type="text" name="" placeholder="검색" />
                    <!-- 통합검색 링크 구현 -->
                    <a href="#" class="search_icon"><i class="fas fa-search"></i></a>
                  </div>
                </div>
              </div>
            </div>
            <!-- 검색창 밑 내비게이션 메뉴 - 링크 걸어줘야함 -->
            <nav id="nav">
              <button class="btn btn-outline-secondary mb-3" type="button" id="button-addon2" onclick="location.href='#'">한식</button>
              <button class="btn btn-outline-secondary mb-3" type="button" id="button-addon2" onclick="location.href='#'">중식</button>
              <button class="btn btn-outline-secondary mb-3" type="button" id="button-addon2" onclick="location.href='#'">양식</button>
              <button class="btn btn-outline-secondary mb-3" type="button" id="button-addon2" onclick="location.href='#'">일식</button>
              <button class="btn btn-outline-secondary mb-3" type="button" id="button-addon2" onclick="location.href='#'">자유게시판</button>
              <button class="btn btn-outline-secondary mb-3" type="button" id="button-addon2" onclick="location.href='#'">공지사항</button>
            </nav>
          </div>
          <!-- jsp에서 action에 따라 달라질 오른쪽 메뉴 -->
          <div class="col-sm-3">
            <button type="submit" class="btn btn-primary btn-login mt-3 me-auto" data-toggle="modal" data-target="#modal-mypage" id="mypage">회원관리</button>
            <div class="w-100"></div>
            <form id="logout" action="<%=request.getContextPath()%>/logout">
              <button type="submit" class="btn btn-secondary mt-3 me-auto" name="logout">로그아웃</button>
            </form>
          </div>
        </div>
      </div>
    </header>
    <!-- 마이페이지 (정보수정) 모달창 -->
    <div class="modal fade" id="modal-mypage" tabindex="-1" aria-labelledby="addUpdateLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 id="title-add-upd" class="modal-title">정보수정</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form id="update" action="<%=request.getContextPath()%>/admin" method="get">
            <div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="" name="userName" />
                <div>유저이름</div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="submit" class="btn btn-success btn-action">회원삭제</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <!-- 게시판 리스트 보여주기 -->
    <div class="row">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-body">
            <div class="table-responsive project-list">
              <table class="table project-table table-centered table-nowrap">
                <thead>
                  <tr>
                    <th scope="col">제목</th>
                    <th scope="col">글쓴이</th>
                    <th scope="col">작성일</th>
                    <th scope="col">추천</th>
                    <th scope="col">조회수</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="board" items="${boards}">
                    <tr>
                      <td><c:out value="${board.title}" /></td>
                      <td><c:out value="${board.userName}" /></td>
                      <td><c:out value="${board.regDate}" /></td>
                      <td><c:out value="${board.recommend}" /></td>
                      <td><c:out value="${board.readAccount}" /></td>
                    </tr>
                    <tr>
                      <td colspan="5"><c:out value="${board.content}" /></td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- 엄지척 -->
    <!-- 추천 버튼 -->
    <form action="(컨트롤러)">
      <button type="button" class="btn btn-info">추천</button>
    </form>

    <!-- Footer -->
    <footer class="footer font-small black p-3">
      <img src="img/free-icon-dish-1404970.png" alt="" />
      <div class="left me-auto">&nbsp;&nbsp;대표 : 2 Team (김병철, 나경원, 이경호, 이혜민, 황성진, 황현식) / E : 사이트 / F : 02) XXX - XXXX</div>
      <div class="right">Copyright &copy;Busan IT Inc. All Rights Reserved</div>
    </footer>

    <!-- 자바스크립트 링크 -->
    <script src="../js/jquery-3.6.0.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/script.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </body>
</html>
