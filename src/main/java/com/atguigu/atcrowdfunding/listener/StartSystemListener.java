package com.atguigu.atcrowdfunding.listener;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.StringUtil;

/**
 * 监听ServletContext对象创建和销毁.
 * 	
 * ServletContext对象创建 : 将contextPath存放到application域中,给JSP使用.
 *
 */
public class StartSystemListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("StartSystemListener - contextInitialized : 将contextPath存放到application域中,给JSP使用.");
		//1.将contextPath存放到application域中,给JSP使用.
		ServletContext application = sce.getServletContext();
		String contextPath = application.getContextPath() ; // ${pageConext.request.contextPath}
		application.setAttribute(Const.APP_PATH, contextPath); // ${APP_PATH}
		
		//2.将系统所有许可数据存放到application域中.
		//PermissionService permissionService = new PermissionServiceImpl();
		//ApplicationContext ioc = new ClassPathXmlApplicationContext("spring/spring-context.xml") ;
		WebApplicationContext ioc = WebApplicationContextUtils.getWebApplicationContext(application);
		PermissionService permissionService = ioc.getBean(PermissionService.class);
		List<Permission> allPermission = permissionService.queryAllPermission();
		Set<String> allPermissionUrls = new HashSet<String>();
		for (Permission permission : allPermission) {
			if(StringUtil.isNotEmpty(permission.getUrl())){
				allPermissionUrls.add("/"+permission.getUrl());
			}
		}		
		application.setAttribute(Const.ALL_PERMISSION_URLS, allPermissionUrls);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
	}

}
