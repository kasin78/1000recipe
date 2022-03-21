<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/recipe.css" />
  </head>
  <body>
    <!-- header -->
    <jsp:include page="../common/header.jsp" />
    <!-- 본문 시작 -->

    <div class="container">
      <div class="row mt-5">
        <div class="col-md-10 mx-auto">
          <div class="mb-3">
            <form method="post" action="<%=request.getContextPath()%>/recipes?action=update">
              <input type="hidden" name="id" value="<c:out value='${recipe.recipe_id}' />" />

              <div id="title" class="form-group mb-2">
                <label>제목</label>
                <input type="text" class="form-control" name="recipeName" value="<c:out value='${recipe.recipeName}' />" required />
              </div>

              <!-- 요리소개 -->
              <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">요리소개</label>
                <textarea id="description" class="form-control" name="description" required><c:out value="${recipe.description}"/></textarea>
              </div>

              <div class="cont_line">
                <p class="cont_tit4">요리정보</p>

                <!-- 카테고리 -->
                <select id="category" class="form-select form-select-lg mb-3" name="category" aria-label=".form-select-lg example" required>
                  <option selected>종류</option>
                  <option value="1">한식</option>
                  <option value="2">중식</option>
                  <option value="3">양식</option>
                  <option value="4">일식</option>
                </select>

                <!-- 인원 -->
                <select id="people" class="form-select form-select-lg mb-3" name="peopleNumber" aria-label=".form-select-lg example" required>
                  <option selected>인원</option>
                  <option value="1인분">1인분</option>
                  <option value="2인분">2인분</option>
                  <option value="3인분">3인분</option>
                  <option value="4인분">4인분</option>
                  <option value="5인분이상">5인분이상</option>
                </select>

                <!-- 시간 -->
                <select id="time" class="form-select form-select-lg mb-3" name="cookTime" aria-label=".form-select-lg example" required>
                  <option selected>시간</option>
                  <option value="10분이내">10분이내</option>
                  <option value="30분이내">30분이내</option>
                  <option value="1시간이내">1시간이내</option>
                  <option value="2시간이내">2시간이내</option>
                  <option value="4시간이내">4시간이내</option>
                  <option value="4시간이상">4시간이상</option>
                </select>

                <!-- 난이도 -->
                <select id="difficulty" class="form-select form-select-lg mb-3" name="difficulty" aria-label=".form-select-lg example" required>
                  <option selected>난이도</option>
                  <option value="상">상</option>
                  <option value="중">중</option>
                  <option value="하">하</option>
                </select>
              </div>

              <!-- 재료 -->
              <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">재료</label>
                <textarea id="material" class="form-control" name="material" required><c:out value="${recipe.material}"/></textarea>
              </div>

              <!-- 요리순서 -->
              <span class="guide">
                <b>요리의 맛이 좌우될 수 있는 부분은 꼭 적어주세요.</b>
                <br />
                "예) 30분간 끓여주세요 -> 10분간 강불로 끓인 후, 20분간 약불로 끓여주세요."
                <br />
                " 참치액젓 1스푼을 넣어주세요 -> 참치액젓이 없다면 다른 액젓으로 대체 가능합니다."
              </span>
              <br />
              <br />

              <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label"> 요리순서</label>
                <textarea class="form-control" id="cookOrder" name="cookOrder" id="exampleFormControlTextarea1" rows="3" required><c:out value="${recipe.cookOrder}"/></textarea>
              </div>

              <!-- 요리팁 -->
              <div class="form-group mb-2">
                <label>요리팁</label>
                <textarea class="form-control" id="cookTip" rows="3" name="cookTip" required><c:out value="${recipe.cookTip}"/></textarea>
              </div>

              <!-- 태그 -->
              <div class="form-group mb-2">
                <label>태그</label>
                <input type="text" class="form-control" name="tag" value="<c:out value='${recipe.tag}' />" required />
              </div>
              <span class="tag"> 주재료, 효능, 대상 등을 태그로 남겨주세요. 예) 소고기, 미역국, 생일 </span>

              <!-- 저장! -->
		      <div style="text-align:end ; margin-bottom: 10px;" class="form-group">
		          <button id="button" type="submit" class="btn btn-info">저장</button>
		      </div>
            </form>
          </div>
        </div>
      </div>
    </div>
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
