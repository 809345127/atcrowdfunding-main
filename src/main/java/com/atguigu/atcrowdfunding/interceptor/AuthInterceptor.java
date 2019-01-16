package com.atguigu.atcrowdfunding.interceptor;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.StringUtil;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	
	//@Autowired
	//private PermissionService permissionService;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
		HttpServletResponse response, Object handler) throws Exception {
		System.out.println("AuthInterceptor - preHandle");
		
		String requestURI = request.getServletPath(); //request.getRequestURI();
		
		//获取系统所有许可权限菜单,请求路径必须包含于许可菜单中,否则拒绝访问
		/*List<Permission> allPermission = permissionService.queryAllPermission();
		Set<String> allPermissionUrls = new HashSet<String>();
		for (Permission permission : allPermission) {
			if(StringUtil.isNotEmpty(permission.getUrl())){
				allPermissionUrls.add("/"+permission.getUrl());
			}
		}*/
		ServletContext application = request.getSession().getServletContext();
		Set<String> allPermissionUrls = (Set<String>)application.getAttribute(Const.ALL_PERMISSION_URLS);
		
		if(allPermissionUrls.contains(requestURI)){			
			//获取当前用户角色的许可菜单,请求路径必须包含于许可菜单中,否则拒绝访问
			HttpSession session = request.getSession();
			
			Set<String> authUris = (Set<String>)session.getAttribute(Const.LOGIN_AUTH_PERMISSION_URI);
			
			if(authUris.contains(requestURI)){
				return true ;
			}else{
				response.sendRedirect(request.getContextPath()+"/error.htm");
				return false ;
			}	
			
		}else{ //不需要权限控制的,直接放行
			return true ;
		}
	}

}
