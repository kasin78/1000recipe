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
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
				switch (action) {
			case "upload": // 게시글 업로드
				uploadBoard(request, response);
				break;
			case "delete": // 게시글 삭제
				deleteBoard(request, response);
				break;
			case "getInfoUpdate": // 게시글 수정할때 필요한 model(bean) 가져오는용
				getInfoUpdateBoard(request, response);
				break;
			case "update": // edit에서 받은 객체써서 해당글 수정하는곳
				updateBoard(request, response);
				break;
			case "list": // 게시글 리스트
				listBoard(request, response);
				break;
			case "selected": //게시글 보기
				selectedBoard(request, response);
				break;
			default:
				HttpSession session = request.getSession();
				session.invalidate(); // 세션 전부 삭제(로그인 정보를 모두 삭제)
				request.getRequestDispatcher("main.jsp").forward(request, response); 
				break;
		}
	}	

	private void uploadBoard(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//공지사항 글 등록
		String title = request.getParameter("title");
		System.out.println(title);
		String name = "관리자"; // 그냥 관리자밖에 없으니 따로 관리자로 설정해둠
		String content = request.getParameter("content");
		boardBean uploadbean = new boardBean(title, name, 0, content);
		boardDao.insertBoard(uploadbean);
		response.sendRedirect("board?action=list");

	}

	private void listBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//공지사항 리스트 보기(페이징, 검색 추가)
		String select_type="title";  
		String query1 = request.getParameter("search_text");
		String page = request.getParameter("page"); //페이지는 int로 하면x, null값이 왔을때 받을수없는 자료형
		//일단은 셀렉타입2에 title을 넣어두고 (이걸 안써두면 젤 처음 리스트보드 함수들어갈때는 선택값이 없어서 null로 들어와서 에러남
		//관리자 게시판의 타입은 제목밖에 안걸어둬서 따로 조건문은 안만듬.
		String query2 = ""; // 만약 검색창에서 아무것도 안쳤을때를 대비해서 만든다.(젤 처음 게시판으로 갈때도 null값으로 처리되는거 방지)
		if(query1 != null && !query1.equals("")) query2 = query1; 
		// 검색창에서 뭔가가 검색이 되면 query2값으로 넣어줌.
		
		int page2 = 1;
		if(page != null && !page.equals("")) {
			page2 = Integer.parseInt(page);
		}
		
		List<boardBean> boardList = boardDao.selectAllBoards(select_type, query2, page2);
		int count = boardDao.BoardCount(select_type, query2);//전체 레코드수
		System.out.println(count);
		request.setAttribute("boards", boardList);
		request.setAttribute("count", count);
		request.getRequestDispatcher("admin/adminBoard.jsp").forward(request, response);
			
	}
	private void selectedBoard(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//글 보기
		int num = Integer.parseInt(request.getParameter("num")); // 게시글 번호
		boardDao.readcount(num);//title에 걸어둔 게시글 번호로 조회수 1 증가 시키고 글내용 보기
		boardBean selectedboard = boardDao.selectBoard(num);// 글 내용보기
		request.setAttribute("boards", selectedboard);
		request.getRequestDispatcher("admin/adminBoardView.jsp").forward(request, response);	
	}

	
	private void getInfoUpdateBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 글 수정(num받은걸 model에 넣어서 해당 객체 가져오기)
		int num = Integer.parseInt(request.getParameter("num"));
		boardBean edit_model = boardDao.selectBoard(num); // 검색용으로 만들어둔거 활용(새로 만들기 귀찮아서)
		request.setAttribute("boards", edit_model);
		request.getRequestDispatcher("admin/adminBoardEdit.jsp").forward(request, response);
	}
	
	private void updateBoard(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// 글 수정
		int num =Integer.parseInt(request.getParameter("num"));
		String title = request.getParameter("title");
		String userName = request.getParameter("userName");
		String content = request.getParameter("content");
		int readCount = Integer.parseInt(request.getParameter("readCount"));
		boardBean update = new boardBean(num, title, userName, content, readCount);
		boardDao.updateBoard(update);
		//request.getRequestDispatcher("admin/adminBoardView.jsp").forward(request, response); 
		//request.getRequestDispatcher("admin/adminBoard.jsp").forward(request, response);
		response.sendRedirect("board?action=list");

		//include관련 https://dololak.tistory.com/506 참고(forward나 redirect쓰면 오류남)
	}
	
	private void deleteBoard(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 글 삭제
		int num = Integer.parseInt(request.getParameter("num"));
		boardDao.deleteBoard(num);
		response.sendRedirect("board?action=list");
	}

	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
