package com.atguigu.atcrowdfunding.interceptor;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.util.Const;

//@Component
//@Scope("prototype")
public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("LoginInterceptor - preHandle - 登录验证拦截器开始拦截了.");
		//0.如果是访问公共资源,要放行.
		
		//白名单
		Set<String> publicResourceSet = new HashSet<String>();
		publicResourceSet.add("/login.htm");
		publicResourceSet.add("/regist.htm");
		publicResourceSet.add("/doRegist.do");
		publicResourceSet.add("/index.htm");
		publicResourceSet.add("/doLogin.do");
		
		String servletPath = request.getServletPath();
		if(publicResourceSet.contains(servletPath)) {//属于白名单路径放行
			return true ;
		}
		
		
		//------------------------------------
		//1.获取session
		HttpSession session = request.getSession();
		
		//2.从session获取用户对象
		User user = (User)session.getAttribute(Const.USER_LOGIN);
		
		
		//3.如果用户存在,说明登录了,放行;否则,跳转到登录页面.
		if(user!=null) {
			return true; //放行
		}else {
			response.sendRedirect(request.getContextPath()+"/login.htm");
			return false ;
		}
		
	}
	
}
