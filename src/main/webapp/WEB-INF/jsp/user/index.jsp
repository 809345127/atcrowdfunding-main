<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH }/css/main.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <%@ include file="/WEB-INF/jsp/common/userinfo.jsp" %>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
				<jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" onclick="deleteBatch()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/user/toAdd.htm'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input id="selectAllCheckbox" type="checkbox"></th>
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              
              <tbody>
              	<%-- <c:forEach items="${page.datas }" var="user" varStatus="status">         	
	                <tr>
	                  <td>${status.count }</td>
					  <td><input type="checkbox"></td>
	                  <td>${user.loginacct }</td>
	                  <td>${user.username }</td>
	                  <td>${user.email }</td>
	                  <td>
					      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
					      <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
						  <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
					  </td>
	                </tr>
                </c:forEach> --%>
                
              </tbody>
			  <tfoot>
			     <tr>
				    <td colspan="6" align="center">
						<ul class="pagination">
							<%-- <c:if test="${page.pageno==1 }">
								<li class="disabled"><a href="#">上一页</a></li>
							</c:if>
							<c:if test="${page.pageno!=1 }">
								<li><a href="#" onclick="pageChange(${page.pageno-1})">上一页</a></li>
							</c:if>
							
							<c:forEach begin="1" end="${page.totalno }" var="num">
								<li 
									<c:if test="${page.pageno==num }">class="active"</c:if>
								><a href="#" onclick="pageChange(${num})">${num }</a></li>
							</c:forEach>
				
							<c:if test="${page.pageno==page.totalno }">
								<li class="disabled"><a href="#">下一页</a></li>
							</c:if>
							<c:if test="${page.pageno!=page.totalno }">
								<li><a href="#" onclick="pageChange(${page.pageno+1})">下一页</a></li>
							</c:if> --%>								
						 </ul>
					 </td>
				 </tr>		
		  	</tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>

    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/script/docs.min.js"></script>
	<script src="${APP_PATH }/jquery/layer/layer.js"></script>
	<script src="${APP_PATH }/script/menu.js"></script>
	
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
			    
			    if(${empty param.pageno}){
			    	queryPage(1);
			    }else{
			    	queryPage(${param.pageno}); //当前页面被加载,马上分页数据查询
			    }
			    showMenu();
            });
            
            
            
            
            
            $("tbody .btn-success").click(function(){
                window.location.href = "assignRole.html";
            });
            $("tbody .btn-primary").click(function(){
                window.location.href = "edit.html";
            });
            
            function pageChange(pageno){
		         //window.location.href="${APP_PATH }/user/queryPage.do?pageno="+pageno;
		         queryPage(pageno);
		    }
            var obj = {        			
        			"pagesize" :  5       			
        	}
                
            
            $("#queryBtn").click(function(){
            	
            	var queryText = $("#queryText").val();
            	queryText = $.trim(queryText);
            	if(queryText==""){
            		layer.msg("查询关键词不能为空!", {time:1000, icon:5, shift:6},function(){
            			$("#queryText").focus();
            			//return false;
            		});
            		return false;
            	}
            	
            	obj.queryText = queryText ;
            	
            	queryPage(1);
            	
            });
            
            function queryPage(pageno){
        	   obj.pageno = pageno ;
        	   
		        
            	$.ajax({
            		data: obj,
            		url:"${APP_PATH}/user/queryPage.do",
            		type:"POST",
            		beforeSend:function(){
            			return true ;
            		},
            		success:function(result){
            			if(result.success){
            				var page = result.page;
            				var datas = page.datas;
            				var content = "";
            				
            				$.each(datas,function(i,n){
            					content+='<tr>';
                				content+='  <td>'+(i+1)+'</td>';
                				content+='  <td><input type="checkbox" id="'+n.id+'"></td>';
                				content+='  <td>'+n.loginacct+'</td>';
                				content+='  <td>'+n.username+'</td>';
                				content+='  <td>'+n.email+'</td>';
                				content+='  <td>';
                				content+='	  <button type="button" onclick="window.location.href=\'${APP_PATH}/user/toAssgnRole.htm?userid='+n.id+'\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                				content+='	  <button type="button" onclick="window.location.href=\'${APP_PATH}/user/toUpdate.do?pageno='+page.pageno+'&id='+n.id+'\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                				content+='	  <button type="button" onclick="deleteUser('+n.id+',\''+n.loginacct+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                				content+='  </td>';
                				content+='</tr>';
            				});            				
            				
            				$("tbody").html(content);
            				
	      	                
            				var navigator = '';
            				
            				if(page.pageno ==1){
            					navigator += '<li class="disabled"><a href="#">上一页</a></li>';
            				}else{
            					navigator += '<li><a href="#" onclick="pageChange('+(page.pageno-1)+')">上一页</a></li>';
            				}
            				
            				for(var i=1 ; i<= page.totalno ; i++){
            					navigator += '<li ';
            					navigator += page.pageno==i?'class="active"':'';
            					navigator += '><a href="#" onclick="pageChange('+i+')">'+i+'</a></li>';
            				}
            				
							if(page.pageno == page.totalno){
            					navigator += '<li class="disabled"><a href="#">下一页</a></li>';
            				}else{
            					navigator += '<li><a href="#" onclick="pageChange('+(page.pageno+1)+')">下一页</a></li>';
            				}
							
            				$(".pagination").html(navigator);
	      	                
            			}else{ 
            				alert(result.message);
            			}
            		}            		
            		
            	});            	
            	
		    }

           
            function deleteUser(id,loginacct){
            	
            	layer.confirm("您确定要删除["+loginacct+"]用户吗?",  {icon: 3, title:'提示'}, function(cindex){
    			    layer.close(cindex);
    			    var index = -1 ;
    			    $.ajax({
                		data: {
                			id : id
                		},
                		url:"${APP_PATH}/user/doDelete.do",
                		type:"POST",
                		beforeSend:function(){
                			index = layer.msg('正在删除用户数据 ,请稍后...', {icon: 16});
                			return true ;
                		},
                		success:function(result){
                			layer.close(index);
                			if(result.success){
                				window.location.href="${APP_PATH}/user/index.htm";
                			}else{
                				layer.msg(result.message, {time:1000, icon:5, shift:6});
                			}
                		}
                	}); 
    			}, function(cindex){
    			    layer.close(cindex);
    			});            	
            	  
            }
            
            
            $("#selectAllCheckbox").click(function(){
            	var checked = this.checked ;
            	
            	var checkboxList = $("tbody input[type='checkbox']");
            	
            	$.each(checkboxList,function(i,n){
            		n.checked = checked ;
            	});
            });
            
            
            function deleteBatch(){
            	var selectedCheckboxList = $("tbody input:checked");
            	
            	if(selectedCheckboxList.length>0){
            		
                	
                	var obj = {};
                	$.each(selectedCheckboxList,function(i,n){
                		var id = n.id;   
                		obj["userList["+i+"].id"] = n.id ;
                		obj["userList["+i+"].loginacct"] = "xxx"+i;
                		/* 
                		userList[0].id:27
                		userList[0].loginacct:xxx0
                		userList[1].id:26
                		userList[1].loginacct:xxx1 
                		*/
                		//obj."ids[0]" = 22 ;
                		//obj."ids[1]" = 23 ;
                	});
                	
                	
            		
                	layer.confirm("您确定要删除这些用户吗?",  {icon: 3, title:'提示'}, function(cindex){
        			    layer.close(cindex);
        			    var index = -1 ;
        			    $.ajax({
                    		data:obj,
                    		url:"${APP_PATH}/user/doDeleteBatch.do",
                    		type:"POST",
                    		beforeSend:function(){
                    			index = layer.msg('正在删除用户数据 ,请稍后...', {icon: 16});
                    			return true ;
                    		},
                    		success:function(result){
                    			layer.close(index);
                    			if(result.success){
                    				window.location.href="${APP_PATH}/user/index.htm";
                    			}else{
                    				layer.msg(result.message, {time:1000, icon:5, shift:6});
                    			}
                    		}
                    	}); 
        			}, function(cindex){
        			    layer.close(cindex);
        			});     
            	}else{
            		layer.msg("至少选择一个用户,才能进行批量删除!", {time:1000, icon:5, shift:6});
            	}
            	
            }
            
            
            
            
            
            
            
            
            
            
            
            
        </script>
  </body>
</html>
    