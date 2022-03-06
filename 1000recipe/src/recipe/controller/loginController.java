package recipe.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import recipe.dao.loginDao;
import recipe.dao.registerDao;
import recipe.model.UserInfo;
import recipe.model.loginBean;
import recipe.model.registerBean;

@WebServlet("/login")
public class loginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private loginDao loginDao;
	private registerDao registerDao;

    @Override
	public void init() throws ServletException {
		loginDao = new loginDao();
		registerDao = new registerDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String action = request.getParameter("action");
		
		switch (action) {
			case "login":
				executeLogin(request, response);
				break;
			case "findId":
				executeFindId(request, response);
				break;
			case "findPw":
				executeFindPw(request, response);
				break;
			default:
				HttpSession session = request.getSession();
				session.invalidate();
				request.getRequestDispatcher("main.jsp").forward(request, response);
		}
	}
	
	// 로그인
	private void executeLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("ID2");
		String pw = request.getParameter("PW2");
		String adminCode = request.getParameter("Admin");
		
		loginBean loginBean = new loginBean();
		
		// 유저 로그인
		if (adminCode.isBlank()) {
			
			loginBean.setId(id);
			loginBean.setPw(pw);
			
			if (loginDao.loginUser(loginBean)) {
				System.out.println("유저 로그인 성공");
				
				registerBean info = new registerBean();
				UserInfo getuserinfo = new UserInfo(); // 현재 접속된 유저 정보 찾기위해서 (추가)  
				HttpSession session = request.getSession(); // 현재 접속하는 새로운 유저정보 저장할려고 넣었습니다
				info = (registerBean) getuserinfo.getInfo(id);		
				System.out.println(info);
				session.setAttribute("userName",info.getUserName()); // 글 등록할때 넣을려고 따로 추가(1차제출 이후)
				session.setAttribute("info", info);
				session.setAttribute("who", "user");
				
				request.getRequestDispatcher("main.jsp").forward(request, response);
			} else {
				System.out.println("유저 로그인 실패");
				request.setAttribute("ID2", id);
				request.getRequestDispatcher("main.jsp").forward(request, response);
			}
		} 
		// 관리자 로그인
		else if (!adminCode.isBlank()) {
			
			loginBean.setId(id);
			loginBean.setPw(pw);
			loginBean.setAdminCode(adminCode);
			
			if (loginDao.loginAdmin(loginBean)) {
				System.out.println("관리자 로그인 성공");
				HttpSession session = request.getSession(); 
				session.setAttribute("who", "admin");
				
				request.getRequestDispatcher("main.jsp").forward(request, response);
			} else {
				System.out.println("관리자 로그인 실패");
				request.getRequestDispatcher("main.jsp").forward(request, response);

			}
		}
	}
	
	// ID 찾기
	private void executeFindId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name2");
		String phoneNum = request.getParameter("phoneNum2");
		
		registerBean registerBean = new registerBean(name, phoneNum);
		
		String foundId = registerDao.findId(registerBean);
		
		if (foundId != null) {
			System.out.println("ID 찾기 성공");		
			
			request.setAttribute("foundId", foundId);
			
			request.getRequestDispatcher("foundIdPw.jsp").forward(request, response);
		}
		else {
			System.out.println("ID 찾기 실패");
			
			request.setAttribute("foundPw", null);
			
			request.getRequestDispatcher("foundIdPw.jsp").forward(request, response);
		}
	}
	
	// PW 찾기
	private void executeFindPw(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("ID");
		String name = request.getParameter("name3");
		String phoneNum = request.getParameter("phoneNum3");
		
		registerBean registerBean = new registerBean(id, name, phoneNum);
		
		String foundPw = registerDao.findPw(registerBean);
		
		if (foundPw != null) {
			System.out.println("PW 찾기 성공");
			
			request.setAttribute("foundPw", foundPw);
			
			request.getRequestDispatcher("foundIdPw.jsp").forward(request, response);
		} else {
			request.getRequestDispatcher("main.jsp").forward(request, response);
		}
	}

}
