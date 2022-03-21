<%@page import="recipe.model.Recipe"%>
<%@page import="recipe.dao.RecipeDao"%>
<%@page import="recipe.dao.RecipeDaoImpl"%>
<%@page import="recipe.dao.userboardDaoImpl"%>
<%@page import="recipe.dao.boardDaoImpl"%>
<%@page import="recipe.model.boardBean"%>
<%@page import="recipe.model.userboardBean"%>
<%@page import="recipe.dao.userboardDao"%>
<%@page import="recipe.dao.boardDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="recipe.model.UserInfo"%>
<%@page import="recipe.model.loginBean"%>
<%@page import="recipe.model.registerBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>1000개의 레시피</title>
<!-- css 링크 -->
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/styleWithTable.css" />
<link rel="stylesheet" href="css/main.css" />
<link rel="stylesheet" href="css/maintable.css" />
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

	RecipeDao recipeDao = new RecipeDaoImpl();
	List<Recipe> showKoreanRecipe = recipeDao.showMostViewCountRecipeByCategory("1");
	List<Recipe> showChineseRecipe = recipeDao.showMostViewCountRecipeByCategory("2");
	List<Recipe> showWesternRecipe = recipeDao.showMostViewCountRecipeByCategory("3");
	List<Recipe> showJapaneseRecipe = recipeDao.showMostViewCountRecipeByCategory("4");
	request.setAttribute("koreanBoard", showKoreanRecipe);
	request.setAttribute("chineseBoard", showChineseRecipe);
	request.setAttribute("westernBoard", showWesternRecipe);
	request.setAttribute("japaneseBoard", showJapaneseRecipe);
	%>

	<!-- 메인페이지 캐로셀 -->
	<div class="container-fluid">
		<div class="row">
			<div class="col" style="margin: 0; padding: 0">
				<div id="carouselExampleSlidesOnly" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="img/한정식1.jpg" class="d-block w-100" alt="..." />
						</div>
						<div class="carousel-item">
							<img src="img/일식요리.jpg" class="d-block w-100" alt="..." />
						</div>
						<div class="carousel-item">
							<img src="img/중식요리2.jpg" class="d-block w-100" alt="..." />
						</div>
						<div class="carousel-item">
							<img src="img/양식요리3.jpg" class="d-block w-100" alt="..." />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-10">
				<div class="container">
					<div class="row">
						<div id="allBoard" class="mt-5">
							<!-- 공지사항 게시판 - 제목 날짜는 jsp로 데이터 받아오기 -->
							<table id="notice" class="col-sm-6 mb-2" style="float: left">
								<tr>
									<th colspan="3">공지사항</th>
									<th><a
										href='<%=request.getContextPath()%>/board?action=list'
										style="color: black; text-decoration: none;">더보기</a></th>
								</tr>
								<c:forEach var="adminBoard" items="${adminBoard}">
									<tr>
										<td colspan="3"><a
											href="<%=request.getContextPath()%>/board?action=selected&num=<c:out value='${adminBoard.num}'/>"
											style="color: black; text-decoration: none;"> <c:out
													value="${adminBoard.title}"></c:out>
										</a></td>
										<td><c:out value="${adminBoard.regDate}"></c:out></td>
									</tr>
								</c:forEach>
								<tr> 
									<td><br></td>
								</tr>
								<tr>
									<td><br></td>
								</tr>
								<tr>
									<th width="100" height="100" scope="col"><img src="img/요리3.jpg" width="100" height="100" alt="">
										<div class="text" id="menu">
											<h5>한식</h5>
										</div>
									</th>
									<c:forEach var="koreanBoard" items="${koreanBoard}">
										<th>&nbsp;&nbsp;&nbsp;&nbsp;<a
											href="<%=request.getContextPath()%>/recipes?action=show&id=${koreanBoard.recipe_id}"
											style="color: black; text-decoration: none;"> <c:out
													value="${koreanBoard.recipeName}"></c:out>
										</a></th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${koreanBoard.regDate}"></c:out></th>
									</c:forEach>
								</tr>
								<tr> 
									<td><br></td>
								</tr>
								<tr>
									<td><br></td>
								</tr>
								<tr>
									<th width="100" height="100" scope="col"><img src="img/요리4.jpg" width="100" height="100" alt="">
										<div class="text" id="menu">
											<h5>양식</h5>
										</div>
									</th>
									<c:forEach var="westernBoard" items="${westernBoard}">
										<th>&nbsp;&nbsp;&nbsp;&nbsp;<a
											href="<%=request.getContextPath()%>/recipes?action=show&id=${westernBoard.recipe_id}"
											style="color: black; text-decoration: none;"> <c:out
													value="${westernBoard.recipeName}"></c:out>
										</a></th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${westernBoard.regDate}"></c:out></th>
									</c:forEach>
								</tr>
							</table>
							<!-- 자유게시판 - 제목 날짜는 jsp로 데이터 받아오기 -->
							<table id="freeBoard" class="col-sm-6 mb-2" style="float: left">
								<tr>
									<th colspan="3">자유게시판</th>
									<th><a
										href='<%=request.getContextPath()%>/userboard?action=list'
										style="color: black; text-decoration: none;">더보기</a></th>
								</tr>
								<c:forEach var="userBoard" items="${userBoard}">
									<tr>
										<td colspan="3"><a
											href="<%=request.getContextPath()%>/userboard?action=selected&num=<c:out value='${userBoard.num}'/>"
											style="color: black; text-decoration: none;"> <c:out
													value="${userBoard.title}"></c:out>
										</a></td>
										<td colspan="1"><c:out value="${userBoard.regDate}"></c:out></td>
									</tr>
								</c:forEach>
								<tr> 
									<td><br></td>
								</tr>
								<tr>
									<td><br></td>
								</tr>
								<tr>
									<th width="100" height="100" scope="col"><img src="img/요리1.jpg" width="100" height="100" alt="">
										<div class="text" id="menu">
											<h5>일식</h5>
										</div>
									</th>
									<c:forEach var="japaneseBoard" items="${japaneseBoard}">
										<th>&nbsp;&nbsp;&nbsp;&nbsp;<a
											href="<%=request.getContextPath()%>/recipes?action=show&id=${japaneseBoard.recipe_id}"
											style="color: black; text-decoration: none;"> <c:out
													value="${japaneseBoard.recipeName}"></c:out>
										</a></th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${japaneseBoard.regDate}"></c:out></th>
									</c:forEach>
								</tr>
								<tr>
									<td><br></td>
								</tr>
								<tr>
									<td><br></td>
								</tr>
								<tr>
									<th width="100" height="100" scope="col"><img src="img/자장면.jpg" width="100" height="100" alt="">
										<div class="text" id="menu">
											<h5>중식</h5>
										</div>
									</th>
									<c:forEach var="chineseBoard" items="${chineseBoard}">
										<th>&nbsp;&nbsp;&nbsp;&nbsp;<a
											href="<%=request.getContextPath()%>/recipes?action=show&id=${chineseBoard.recipe_id}"
											style="color: black; text-decoration: none;"> <c:out
													value="${chineseBoard.recipeName}"></c:out>
										</a></th>
										<th>&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${chineseBoard.regDate}"></c:out></th>
									</c:forEach>
								</tr>
							</table>
						</div>
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
		$(document).ready(function() {
			$('#myPage').on('click', function(e) {
				$('#modal-myUserPage').modal('show');
			});
		});
	</script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>
