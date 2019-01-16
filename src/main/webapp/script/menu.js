function showMenu(){
	var url = window.location.href ;
	var host = window.location.host ; //   localhost
	
	var contextPath = "${APP_PATH}";
	
	var path = url.substring(url.indexOf(host) + host.length); //   /atcrowdfunding-main/cert/index.htm?pageno=1
	
	path = path.substring(contextPath.length); //  /cert/index.htm?pageno=1
	
	if(path.indexOf("?")!=-1){
		path = path.substring(0, path.indexOf("?"));
	}
	
	var linkObj = $(".list-group a[href*=\'"+path+"\']");
	
	
	linkObj.css("color","red");
	
	linkObj.parent().parent().show();
	linkObj.parent().parent().parent().removeClass("tree-closed");

}