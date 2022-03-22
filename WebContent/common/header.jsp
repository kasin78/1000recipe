<%@page import="java.util.List"%> <%@page import="java.util.ArrayList"%> <%@page import="recipe.model.UserInfo"%> <%@page import="recipe.model.loginBean"%> <%@page
import="recipe.model.registerBean"%> <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>1000개의 레시피</title>
  </head>
  <body>
    <!-- Header -->
    <% registerBean info = (registerBean) session.getAttribute("info"); String who = (String) session.getAttribute("who"); %>
    <header>
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
          <a class="navbar-brand" href="<%=request.getContextPath()%>/main.jsp">
            <img src="<%=request.getContextPath()%>/img/free-icon-dish-1404970.png" class="rounded float-left" alt="" style="width: 100px; height: 100px" />
            1000개의 레시피
          </a>
          <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarNavDropdown"
            aria-controls="navbarNavDropdown"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/recipes?action=list">통합레시피</a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false"> 레시피 카테고리 </a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                  <li><a class="dropdown-item" href="<%=request.getContextPath()%>/recipes?action=list&category=1">한식</a></li>
                  <li><a class="dropdown-item" href="<%=request.getContextPath()%>/recipes?action=list&category=2">중식</a></li>
                  <li><a class="dropdown-item" href="<%=request.getContextPath()%>/recipes?action=list&category=3">양식</a></li>
                  <li><a class="dropdown-item" href="<%=request.getContextPath()%>/recipes?action=list&category=4">일식</a></li>
                </ul>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/userboard?action=list">자유게시판</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/board?action=list">공지사항</a>
              </li>
            </ul>
          </div>

          <!-- jsp에서 action에 따라 달라질 오른쪽 메뉴 -->
          <!-- 비회원 -->
          <c:if test="${who != 'user' && who != 'admin'}">
            <div class="me-auto">
              <button type="submit" class="btn btn-primary btn-login me-3" data-toggle="modal" data-target="#modal-login" id="login">로그인</button>
            </div>
            <div>
              <button type="submit" class="btn btn-secondary me-3" data-toggle="modal" data-target="#modal-register" id="register">회원가입</button>
            </div>

            <!-- 회원가입 모달창 -->
            <div class="modal fade" id="modal-register" name="modal-register" tabindex="-1" aria-labelledby="addUpdateLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 id="title-add-upd" class="modal-title">회원가입</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>

                  <form id="register" autocomplete="off" action="<%=request.getContextPath()%>/register" method="post">
                    <div class="modal-body">
                      <div class="container-fluid">
                        <div class="row">
                          <div class="col-md-8 ps-0">
                            <input type="text" class="form-control mb-2 id_input" id="ID1" name="ID1" placeholder="아이디(*)" />
                          </div>
                          <div class="col-md-4 ps-4 pe-3">
                            <button type="button" class="btn btn-secondary btn-action mb-3" id="id_check" onclick="idValidate()">중복확인</button>
                          </div>
                        </div>
                        <div class="row mt-2" id="checkId"></div>
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="password" class="form-control" id="PW1" name="PW1" placeholder="비밀번호(*)" />
                      </div>
                    </div>
                    <div class="modal-body">
                      <div class="form-group">
                        <input type="password" class="form-control" id="PWCheck" name="PWCheck" placeholder="비밀번호확인(*)" />
                      </div>
                    </div>
                    <div class="alert alert-success" id="alert-success">비밀번호가 일치합니다</div>
                    <div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다</div>

                    <div class="container-fluid">
                      <div class="row">
                        <div class="col-md-5 ps-3">
                          <input type="text" class="form-control" id="userName" name="userName" placeholder="닉네임(*)" />
                        </div>
                        <div class="col-md-4 ps-3">
                          <button type="button" class="btn btn-secondary btn-action mb-3" onclick="userNameValidate()">중복확인</button>
                        </div>
                      </div>
                      <div class="row mt-2 ms-2" id="checkUserName"></div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="name1" name="name1" placeholder="이름" />
                      </div>
                    </div>

                    <div class="container-fluid">
                      <div class="row">
                        <div class="col-md-5 ps-3">
                          <input type="text" class="form-control" id="postNum" name="postNum" placeholder="우편번호" />
                        </div>
                        <div class="col-md-4 ps-3">
                          <button type="button" class="btn btn-secondary btn-action mb-3" onclick="find_PostNum()">우편번호 찾기</button>
                        </div>
                      </div>
                    </div>
                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="address" name="address" placeholder="주소" />
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="phoneNum1" name="phoneNum1" placeholder="전화번호 '-' 없이 입력" />
                      </div>
                    </div>

                    <div class="modal-footer">
                      <button type="submit" id="makeAccount" class="btn btn-success btn-action" disabled>계정생성</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>

            <!-- 로그인 모달창 -->
            <div class="modal fade" id="modal-login" tabindex="-1" aria-labelledby="addUpdateLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 id="title-add-upd" class="modal-title">로그인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <form id="login" autocomplete="off" action="<%=request.getContextPath()%>/login?action=login" method="post">
                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="ID2" name="ID2" placeholder="아이디" required />
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="password" class="form-control" id="PW2" name="PW2" placeholder="비밀번호" required />
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="Admin" name="Admin" maxlength="15" placeholder="관리자 코드" />
                      </div>
                    </div>

                    <div class="modal-footer">
                      <button type="submit" class="btn btn-success btn-action">로그인</button>
                      <a href="#" data-toggle="modal" data-target="#modal-findIdPw" id="findIdPw">아이디 / 패스워드 찾기</a>
                    </div>
                  </form>
                </div>
              </div>
            </div>

            <!-- ID / PW 찾기 모달창 -->
            <div class="modal fade" id="modal-findIdPw" tabindex="-1" aria-labelledby="addUpdateLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 id="title-add-upd" class="modal-title">ID / PW 찾기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>

                  <!-- ID 찾기 모달 -->
                  <form id="findId" autocomplete="off" action="<%=request.getContextPath()%>/login?action=findId" method="post" onsubmit="return idTrimCheck()">
                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="name2" name="name2" placeholder="이름" />
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="phoneNum2" name="phoneNum2" placeholder="전화번호" />
                      </div>
                    </div>

                    <div class="modal-footer">
                      <button type="submit" class="btn btn-success btn-action">아이디 찾기</button>
                    </div>
                  </form>

                  <!-- PW 찾기 모달 -->
                  <form id="findPw" autocomplete="off" action="<%=request.getContextPath()%>/login?action=findPw" method="post" onsubmit="return pwTrimCheck()">
                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="ID" name="ID" placeholder="ID" />
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="name3" name="name3" placeholder="이름" />
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="phoneNum3" name="phoneNum3" placeholder="전화번호" />
                      </div>
                    </div>

                    <div class="modal-footer">
                      <input type="hidden" />
                      <button type="submit" class="btn btn-success btn-action">비밀번호 찾기</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </c:if>

          <!-- 유저 -->
          <c:if test="${who == 'user'}">
            <div class="me-auto">
              <button type="submit" class="btn btn-primary btn-login me-3 mb-2" data-toggle="modal" data-target="#modal-myUserPage" id="myPage">유저정보</button>
              <form id="logout" action="<%=request.getContextPath()%>/logout">
                <button type="submit" class="btn btn-secondary" name="logout">로그아웃</button>
              </form>
            </div>

            <!-- 유저 마이페이지 (정보수정) 모달창 -->
            <div class="modal fade" id="modal-myUserPage" tabindex="-1" aria-labelledby="addUpdateLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 id="title-add-upd" class="modal-title">정보수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <form id="update" action="<%=request.getContextPath()%>/info" method="post">
                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="ID9" name="id" value="<%= info.getId() %>" readonly />
                        <div>아이디(수정불가)</div>
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="PW9" name="password" autocomplete="off" value="<%= info.getPassword() %>" readonly />
                        <div>비밀번호(수정불가)</div>
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="userName9" name="userName" value="<%= info.getUserName() %>" readonly />
                        <div>닉네임(수정불가)</div>
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="name9" name="name" value="<%=info.getName() %>" />
                        <div>성함</div>
                      </div>
                    </div>

                    <div class="container-fluid">
                      <div class="row">
                        <div class="col-md-5 ps-3">
                          <input type="text" class="form-control" id="postNum" name="postNum" value="<%=info.getPostNum() %>" />
                        </div>
                        <div class="col-md-4 ps-3">
                          <button type="button" class="btn btn-secondary btn-action" onclick="find_PostNum()">우편번호 찾기</button>
                        </div>
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="address" name="address" value="<%=info.getAddress() %>" />
                        <div>주소</div>
                      </div>
                    </div>

                    <div class="modal-body">
                      <div class="form-group">
                        <input type="text" class="form-control" id="phoneNum9" name="phoneNum" value="<%=info.getPhoneNum() %>" />
                        <div>전화번호</div>
                      </div>
                    </div>

                    <div class="modal-footer">
                      <button type="submit" class="btn btn-success btn-action">회원정보 수정</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </c:if>

          <!-- 관리자 -->
          <c:if test="${who == 'admin'}">
            <div class="me-auto">
              <button type="submit" class="btn btn-primary btn-login me-3 mb-2" data-toggle="modal" data-target="#modal-myAdminPage" id="adminPage">회원관리</button>
              <form id="logout" action="<%=request.getContextPath()%>/logout">
                <button type="submit" class="btn btn-secondary" name="logout">로그아웃</button>
              </form>
            </div>

            <!-- 관리자 회원관리 모달창 -->
            <div class="modal fade" id="modal-myAdminPage" tabindex="-1" aria-labelledby="addUpdateLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 id="title-add-upd" class="modal-title">정보수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <form id="delete" action="<%=request.getContextPath()%>/admin" method="get">
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
          </c:if>
        </div>
      </nav>
    </header>
  </body>
</html>
