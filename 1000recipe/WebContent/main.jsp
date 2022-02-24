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
    <jsp:include page="common/header.jsp" />
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
                    <input type="text" class="form-control mb-2 id_input" id="ID1" name="ID1" placeholder="아이디(*)" title="n" />
                  </div>
                  <div class="col-md-4 ps-4 pe-3">
                    <button type="button" class="btn btn-secondary btn-action" id="id_check" onclick="idValidate()">중복확인</button>
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
                  <button type="button" class="btn btn-secondary btn-action" onclick="userNameValidate()">중복확인</button>
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
                  <button type="button" class="btn btn-secondary btn-action" onclick="find_PostNum()">우편번호 찾기</button>
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
              <button type="submit" id="makeAccount" class="btn btn-success btn-action" disabled="disabled">계정생성</button>
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
                <input type="text" class="form-control" id="ID2" name="ID2" value="${id}" placeholder="아이디" required />
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

    <!-- 유저 마이페이지 (정보수정) 모달창 -->

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
                    <th>더보기</th>
                  </tr>
                  <tr>
                    <td>제목</td>
                    <td>날짜</td>
                  </tr>
                  <tr>
                    <td>제목</td>
                    <td>날짜</td>
                  </tr>
                </table>
                <!-- 자유게시판 - 제목 날짜는 jsp로 데이터 받아오기 -->
                <table id="freeBoard" class="col-sm-5 mb-2" style="float: left">
                  <tr>
                    <th>자유게시판</th>
                    <th>더보기</th>
                  </tr>
                  <tr>
                    <td>제목</td>
                    <td>날짜</td>
                  </tr>
                  <tr>
                    <td>제목</td>
                    <td>날짜</td>
                  </tr>
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
    <script src="js/script.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </body>
</html>
