package recipe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import recipe.dao.boardDao;
import recipe.dao.boardDaoImpl;
import recipe.model.boardBean;

@WebServlet("/board")
public class boardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private boardDao boardDao;
	
	public void init() {
		boardDao = new boardDaoImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		switch (action) {
			case "upload": // 게시글 업로드
				uploadBoard(request, response);
				break;
			case "delete": // 게시글 삭제
				deleteBoard(request, response);
				break;
			case "edit": // 게시글 수정
				editBoard(request, response);
				break;
			case "list":
				listBoard(request, response);
				break;
			default:
				HttpSession session = request.getSession();
				session.invalidate(); // 세션 전부 삭제(로그인 정보를 모두 삭제)
				request.getRequestDispatcher("main.jsp").forward(request, response); 
				break;
		}
	}

	private void listBoard(HttpServletRequest request, HttpServletResponse response) {
		List<boardBean> boardList = boardDao.selectAllBoards();
		
		request.setAttribute("boards", boardList);
		
		
		request.getRequestDispatcher("");
		
		
		
	}

	private void editBoard(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	private void deleteBoard(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	private void uploadBoard(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
