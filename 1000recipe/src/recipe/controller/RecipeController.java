package recipe.controller;

import java.io.IOException;

import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import recipe.dao.RecipeDao;
import recipe.dao.RecipeDaoImpl;
import recipe.model.Recipe;

@WebServlet("/recipes")
public class RecipeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private RecipeDaoImpl recipeDAO;

	public void init() {
		recipeDAO = new RecipeDaoImpl(); // 실제 객체는 recipeDao를 구현한 RecipeDaoImpl로 생성
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response); // post로 요청하더라도 get으로 처리
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		// 요청주소가 localhost:8090/TODO/new => "/new" 가 action의 값
		String action = request.getParameter("action");
		if (action == null) {
			action = "list";
		}
		System.out.println(action);
		switch (action) {
		case "new":
			showNewForm(request, response);
			break;
		case "post": // 레시피 작성
			insertRecipe(request, response);
			break;
		case "delete": // 레시피 삭제
			deleteRecipe(request, response);
			break;
		case "edit": // 레시피수정
			editRecipe(request, response);
			break;
		case "update": // 레시피수정
			updateRecipe(request, response);
			break;
		case "list": // localhost:8090/TODO/recipes/list
			listRecipe(request, response);
			break;
		case "show": // 레시피보기
			showRecipe(request, response);
			break;
		default: // 요청주소가 기본 또는 잘못되었을 경우		
			listRecipe(request, response);
			break;
		} // 스위치 문 끝

	}

	private void editRecipe(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Long recipe_id = Long.parseLong(request.getParameter("id"));
		Recipe recipe = recipeDAO.selectOneRecipe(recipe_id);
	
		request.setAttribute("recipe", recipe);

		RequestDispatcher dispatcher = request.getRequestDispatcher("recipe/recipe-edit.jsp");
		dispatcher.forward(request, response);
		
	}

	private void updateRecipe(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		Long recipe_id = Long.parseLong(request.getParameter("id"));	
		System.out.println(recipe_id);
		//String userName = (String)session.getAttribute("userName");  // 나중에 userName 데이터 받으면 session.~~~ 사용
		String userName = "lee";
		String category = request.getParameter("category");
		String recipeName = request.getParameter("recipeName");
		String description = request.getParameter("description");
		String peopleNumber = request.getParameter("peopleNumber");
		String cookTime = request.getParameter("cookTime");
		String difficulty = request.getParameter("difficulty");
		String material = request.getParameter("material");
		// int recommendCount = request.getParameter("");
		// LocalDate date = LocalDate.parse(request.getParameter("regDate"));
		// LocalDate regDate = LocalDate.parse(request.getParameter("regDate"));
		String tag = request.getParameter("tag");
		String cookOrder = request.getParameter("cookOrder");
		String cookTip = request.getParameter("cookTip");

		Recipe recipe = new Recipe(recipe_id, userName, category, recipeName, description, peopleNumber, cookTime, difficulty, material, 0, tag, cookOrder, cookTip);
		
		boolean updateRow = recipeDAO.updateRecipe(recipe);

		if (updateRow) {
			System.out.println("업데이트 성공");
		}else {
			System.out.println("업데이트 실패");
		}
		request.setAttribute("recipe", recipe);

		RequestDispatcher dispatcher = request.getRequestDispatcher("recipe/recipe-show.jsp");
		dispatcher.forward(request, response);

	}

	// 레시피 글 보여주기 
	private void showRecipe(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();

		// id를 Long.parseLong을 이용해 Long type recipe_id로 변환해주고
		Long recipe_id = Long.parseLong(request.getParameter("id"));
		
		// recipe_id로 검색
		Recipe recipe = recipeDAO.selectOneRecipe(recipe_id);

		// request에 저장
		request.setAttribute("recipe", recipe);

		// recipe/recipe-show.jsp 페이지로 forward한다. 
		RequestDispatcher dispatcher = request.getRequestDispatcher("recipe/recipe-show.jsp");
		dispatcher.forward(request, response);
	}

	private void deleteRecipe(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Long recipe_id = Long.parseLong(request.getParameter("id")); // id를 받음
		recipeDAO.deleteRecipe(recipe_id);

		response.sendRedirect("recipes?action=list"); // 삭제 후 리스트 페이지로 이동
	}

	// 글쓰기 내용 클릭 후 내용을 작성하고 저장하면 저장이되고 레시피 리스트로 돌아가게 함, 글 작성하고 저장하기때문에 recipe_id는
	// 필요없음..?
	private void insertRecipe(HttpServletRequest request, HttpServletResponse response) throws IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();

		// Long recipe_id = Long.parseLong(request.getParameter("recipe_id"));
		//String userName = (String)session.getAttribute("userName"); // 나중에 userName 데이터 받으면 session.~~~ 사용
		String userName = "lee";
		String category = request.getParameter("category");
		String recipeName = request.getParameter("recipeName");
		String description = request.getParameter("description");
		String peopleNumber = request.getParameter("peopleNumber");
		String cookTime = request.getParameter("cookTime");
		String difficulty = request.getParameter("difficulty");
		String material = request.getParameter("material");
		// int recommendCount = request.getParameter("");
		// LocalDate date = LocalDate.parse(request.getParameter("regDate"));
		// LocalDate regDate = LocalDate.parse(request.getParameter("regDate"));
		String tag = request.getParameter("tag");
		String cookOrder = request.getParameter("cookOrder");
		String cookTip = request.getParameter("cookTip");

		Recipe recipe = new Recipe(userName, category, recipeName, description, peopleNumber, cookTime, difficulty,
				material, 0, tag, cookOrder, cookTip);
		recipeDAO.insertRecipe(recipe);

		response.sendRedirect("recipes?action=list"); // 새 레시피를 저장하고 리스트 페이지로 이동
	}

	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println(request.getParameter("category"));

		RequestDispatcher dispatcher = request.getRequestDispatcher("recipe/recipe-write.jsp");
		dispatcher.forward(request, response);

	}

	private void listRecipe(HttpServletRequest request, HttpServletResponse response)

			throws ServletException, IOException {
		String category = request.getParameter("category"); // 카테고리를 받음
		
		List<Recipe> listRecipe = null;
		
		if(category == null) {
			listRecipe = recipeDAO.selectAllRecipe(); // DB에서 게시글을 가져와 리스트에 저장		
		} else {
			listRecipe = recipeDAO.selectAllRecipeByCategory(category);
		}
	
		request.setAttribute("listRecipe", listRecipe); // 리스트를 리퀘스트에 저장
		request.setAttribute("categoryName", recipeDAO.categoryMap.get(category)); //카테고리 이름 저장
		

//		for (Recipe r : listRecipe) {
//			System.out.println(r.toString());
//		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("recipe/recipe-list.jsp");
		dispatcher.forward(request, response);
	}

}