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
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/main.css" />
  </head>
  <body>
    <!-- Header -->
    <% registerBean info = (registerBean)session.getAttribute("info"); String who = (String)session.getAttribute("who"); %>
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
              <a class="btn btn-outline-secondary mb-3" href="<%=request.getContextPath()%>/recipes?action=list&category=1">한식</a>
              <a class="btn btn-outline-secondary mb-3" href="<%=request.getContextPath()%>/recipes?action=list&category=2">중식</a>
              <a class="btn btn-outline-secondary mb-3" href="<%=request.getContextPath()%>/recipes?action=list&category=3">양식</a>           
              <a class="btn btn-outline-secondary mb-3" href="<%=request.getContextPath()%>/recipes?action=list&category=4">일식</a>           
              <button class="btn btn-outline-secondary mb-3" type="button" id="button-addon2" onclick="location.href='#'">자유게시판</button>
              <button class="btn btn-outline-secondary mb-3" type="button" id="button-addon2" onclick="location.href='#'">공지사항</button>
            </nav>
          </div>
          <!-- jsp에서 action에 따라 달라질 오른쪽 메뉴 -->
          <!-- 비회원 -->
          <c:if test="${who != 'user' && who != 'admin'}">
            <div class="col-sm-3">
              <button type="submit" class="btn btn-primary btn-login mt-3 me-auto" data-toggle="modal" data-target="#modal-login" id="login">로그인</button>
              <div class="w-100"></div>
              <button type="submit" class="btn btn-secondary mt-3 me-auto" data-toggle="modal" data-target="#modal-register" id="register">회원가입</button>
            </div>
          </c:if>
          <!-- 유저 -->
          <c:if test="${who == 'user'}">
            <div class="col-sm-3">
              <button type="submit" class="btn btn-primary btn-login mt-3 me-auto" data-toggle="modal" data-target="#modal-myUserpage" id="mypage">마이페이지</button>
              <div class="w-100"></div>
              <form id="logout" action="<%=request.getContextPath()%>/logout">
                <button type="submit" class="btn btn-secondary mt-3 me-auto" name="logout">로그아웃</button>
              </form>
            </div>
          </c:if>
          <!-- 관리자 -->
          <c:if test="${who == 'admin'}">
            <div class="col-sm-3">
              <button type="submit" class="btn btn-primary btn-login mt-3 me-auto" data-toggle="modal" data-target="#modal-myAdminPage" id="adminPage">회원관리</button>
              <div class="w-100"></div>
              <form id="logout" action="<%=request.getContextPath()%>/logout">
                <button type="submit" class="btn btn-secondary mt-3 me-auto" name="logout">로그아웃</button>
              </form>
            </div>
          </c:if>
        </div>
      </div>
    </header>