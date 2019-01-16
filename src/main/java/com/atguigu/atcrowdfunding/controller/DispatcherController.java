package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Const;

@Controller
public class DispatcherController {

	@Autowired
	private UserService userService ;
	
	@RequestMapping("/index")
	public String index() {		
		return "index";
	}
	
	@RequestMapping("/login")
	public String login() {		
		return "login";
	}
	
	@RequestMapping("/error")
	public String error() {		
		return "error/error";
	}
	
	
	@RequestMapping("/main")
	public String main() {		
		return "main";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {	
		if(session!=null) {
			session.removeAttribute(Const.USER_LOGIN);
			session.invalidate();
		}
		return "redirect:/index.htm";
	}
	
	@ResponseBody //启用底层消息转换器:HttpMessageConverter 将对象(Map,Entity)转换为JSON字符串.使用Jackson组件.
	@RequestMapping("/doLogin")
	public Object doLogin(String loginacct,String userpswd,String usertype,HttpSession session) {
	
		AjaxResult result = new AjaxResult();
		
		try {
			Map<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("loginacct", loginacct);
			paramMap.put("userpswd", userpswd);
			paramMap.put("usertype", usertype);
			
			User userLogin = userService.queryUserByLogin(paramMap);
			if(userLogin==null) {
				result.setSuccess(false);
				result.setMessage("用户名称或密码不对,请重新登录!");
			}else {
				
				List<Permission> permissionSelfList =  userService.queryPermissionSelf(userLogin.getId());
				
				Permission parent = null;
				
				Map<Integer,Permission> permissionMap = new HashMap<Integer,Permission>();
				
				Set<String> uriSelfSet = new HashSet<String>();
				
				for (Permission permission : permissionSelfList) {
					permissionMap.put(permission.getId(), permission);
					uriSelfSet.add("/"+permission.getUrl());
				}
				
				for (Permission permission : permissionSelfList) {
					if(permission.getPid() == null) {
						parent = permission ;
					}else {
						permissionMap.get(permission.getPid()).getChildren().add(permission);
					}
				}
				
				
				session.setAttribute(Const.LOGIN_AUTH_PERMISSION_URI, uriSelfSet);			
				session.setAttribute(Const.ROOT_PERMISSION, parent);			
				session.setAttribute(Const.USER_LOGIN, userLogin);				
				result.setSuccess(true);
			}
			   
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMessage("系统出现错误,请与管理员联系!");
		}
		
		return result;
	}
	
	/*	
	@RequestMapping("/doLogin")
	public String doLogin(String loginacct,String userpswd,String usertype,HttpSession session) {
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("loginacct", loginacct);
		paramMap.put("userpswd", userpswd);
		paramMap.put("usertype", usertype);
		
		User userLogin = userService.queryUserByLogin(paramMap);
		
		session.setAttribute(Const.USER_LOGIN, userLogin);
		
		return "main";
	}*/
	
	
	
}
