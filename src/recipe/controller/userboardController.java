package recipe.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import recipe.dao.userboardDao;
import recipe.dao.userboardDaoImpl;
import recipe.model.boardBean;
import recipe.model.userboardBean;

@WebServlet("/userboard")
public class userboardController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private userboardDao userboardDao;

	@Override
	public void init() {
		userboardDao = new userboardDaoImpl();
	}
	

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");
		switch (action) {
		case "list": // 게시글 리스트(검색용으로 post에 하나더)
			System.out.println("dd");
			listBoard(request, response);
			break;
		case "updatecheckPass": // 비번맞으면 수정데이터 얻어와서 update로 보내기
			updateboardpasscheck(request, response);
			break;
		case "deletecheckPass": // 
			deleteboardpasscheck(request, response);
			break;
		case "update": // passcheck->userboardedit에서 받은 객체써서 해당글 수정하는곳
			updateBoard(request, response);
			break;
		case "upload": // 게시글 업로드
			uploadBoard(request, response);
			break;

		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");
		switch (action) {
		case "list": // 게시글 리스트
			System.out.println("dd");
			listBoard(request, response);
			break;
		case "selected": // 게시글 보기
			selectedBoard(request, response);
			break;
		case "deletedByAdmin": // 
			deleteBoard(request, response);

		}
	}

	private void updateboardpasscheck(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// 수정(비밀번호)
		int num = Integer.parseInt(request.getParameter("num")); // 게시판 번호
		String boardpassword = request.getParameter("password"); // 게시판 비번
		String typingPassword = request.getParameter("typingNum"); // 유저가 윈도우창에 타이핑한 비번

		if (typingPassword.equals(boardpassword)) {
			userboardBean edit_model = userboardDao.selectBoard(num);
			request.setAttribute("boards", edit_model);
			request.getRequestDispatcher("user/userBoardEdit.jsp").forward(request, response);
		} else {
			response.sendRedirect("user/failPassword.jsp");
			// 비번 안맞을때 따로 처리
		}

	}

	private void updateBoard(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 비번 맞으면 수정
		int num = Integer.parseInt(request.getParameter("num"));
		String title = request.getParameter("title");
		String userName = request.getParameter("userName");
		String content = request.getParameter("content");
		int readCount = Integer.parseInt(request.getParameter("readCount"));

		userboardBean update = new userboardBean(num, title, userName, content, readCount);
		userboardDao.updateBoard(update);
		response.sendRedirect("userboard?action=list");
	}

	private void deleteboardpasscheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 삭제(비밀번호)
		int num = Integer.parseInt(request.getParameter("num")); // 게시판 번호
		String boardpassword = request.getParameter("password"); // 게시판 비번
		String typingPassword = request.getParameter("typingNum"); // 유저가 윈도우창에 타이핑한 비번

		if (typingPassword.equals(boardpassword)) {
			userboardDao.deleteBoard(num);
			response.sendRedirect("userboard?action=list");
		} else {
			response.sendRedirect("user/failPassword.jsp");
			// 비번 틀렸을때
		}
	}

	private void deleteBoard(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// 관리자가 삭제
		int num = Integer.parseInt(request.getParameter("num"));
		userboardDao.deleteBoard(num);
		RequestDispatcher dispatcher = request.getRequestDispatcher("userboard?action=list");
		dispatcher.include(request, response);
		//response.sendRedirect("userboard?action=list");
	}

	private void listBoard(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 자유게시판 리스트보기
		String select_type=request.getParameter("f");  
		String query1 = request.getParameter("search_text");
		String page = request.getParameter("page"); //페이지는 int로 하면x, null값이 왔을때 받을수없는 자료형
		//일단은 셀렉타입2에 title을 넣어두고 (이걸 안써두면 젤 처음 리스트보드 함수들어갈때는 선택값이 없어서 null로 들어와서 에러남
		//관리자 게시판의 타입은 제목밖에 안걸어둬서 따로 조건문은 안만듬.
		
		String select_type2 = "title";
		if(select_type !=null && !select_type.equals("")) select_type2 = select_type;
		
		String query2 = ""; // 만약 검색창에서 아무것도 안쳤을때를 대비해서 만든다.(젤 처음 게시판으로 갈때도 null값으로 처리되는거 방지)
		if(query1 != null && !query1.equals("")) query2 = query1; 
		// 검색창에서 뭔가가 검색이 되면 query2값으로 넣어줌.
		
		int page2 = 1;
		if(page != null && !page.equals("")) {
			page2 = Integer.parseInt(page);
		}
		
		List<userboardBean> boardList = userboardDao.selectAllBoards(select_type2, query2, page2);
		int count = userboardDao.BoardCount(select_type2, query2);//전체 레코드수
		
		request.setAttribute("boards", boardList);
		request.setAttribute("count", count);
		System.out.println("좀");

		request.getRequestDispatcher("user/userBoard.jsp").forward(request, response);

	}

	private void uploadBoard(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		String title = request.getParameter("title");
		String userName = (String) session.getAttribute("userName"); // 유저로그인 성공했을때 세션에 넣어둔거 활용
		// System.out.println(userName);
		String password = request.getParameter("password");
		String content = request.getParameter("content");

		userboardBean uploadbean = new userboardBean(title, userName, password, 0, content);
		userboardDao.insertBoard(uploadbean);
		response.sendRedirect("userboard?action=list");

	}

	private void selectedBoard(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int num = Integer.parseInt(request.getParameter("num"));
		userboardDao.readcount(num);// 조회수1증가
		userboardBean selectedboard = userboardDao.selectBoard(num);

		request.setAttribute("boards", selectedboard);
		request.getRequestDispatcher("user/userBoardView.jsp").forward(request, response);

	}

}
