<ul style="padding-left:0px;" class="list-group">
	
	<#list permissionRoot.children as  permission>
		
		<#if permission.children?size == 0 >
			<li class="list-group-item tree-closed" >
				<a href="${APP_PATH }/${permission.url }"><i class="${permission.icon}"></i> ${permission.name }</a> 
			</li>
		<#else>
			<li class="list-group-item tree-closed">
				<span><i class="${permission.icon}"></i> ${permission.name } <span class="badge" style="float:right">${permission.children?size}</span></span> 
				<ul style="margin-top:10px;display:none;">
				
					<#list permission.children as innerPermission>
						<li style="height:30px;">					
							<a href="${APP_PATH }/${innerPermission.url}"><i class="${innerPermission.icon }"></i> ${innerPermission.name }</a> 
						</li>
					</#list>
				</ul>
			</li>
		</#if>
		
	</#list>
	
	
	<#-- 
	
		
			<li class="list-group-item tree-closed">
				<span><i class="${permission.icon}"></i> ${permission.name } <span class="badge" style="float:right">${fn:length(permission.children)}   <%--  ${permission.children.size() } --%></span></span> 
				<ul style="margin-top:10px;display:none;">
					<c:forEach items="${permission.children }" var="innerPermission">
						<li style="height:30px;">					
							<a href="${APP_PATH }/${innerPermission.url}"><i class="${innerPermission.icon }"></i> ${innerPermission.name }</a> 
						</li>
					</c:forEach>
				</ul>
			</li>
		
	
	 -->
</ul>
