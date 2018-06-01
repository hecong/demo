<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head id="Head1">  
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
    <title>DEMO</title>  
    
      <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
<!--     <link href="Css/default.css" rel="stylesheet" type="text/css" />   -->
  <!-- 引入JQuery -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/jquery.min.js"></script>
  <!-- 引入EasyUI -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
  <!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
  <!-- 引入EasyUI的样式文件-->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css"/>
  <!-- 引入EasyUI的图标样式文件-->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css"/>
  
	<script type="text/javascript">
		
        
        function addTab(title,url){
            if($('#tabs').tabs('exists',title)){
                $('#tabs').tabs('select',title)
                var currentTab = $('#tabs').tabs('getSelected');
                  RefreshTab(currentTab);
            }else{
                var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
                  $('#tabs').tabs('add',{
                      title:title,
                      content:content,
                      closable:true
                  });
            }
        }
        
        
        function RefreshTab(currentTab) {
        	          var url = $(currentTab.panel('options')).attr('href');
        	          $('#tabs').tabs('update', {
        	              tab: currentTab,
        	               options: {
        	                  href: url
        	              }
        	          });
        	         currentTab.panel('refresh');
        	   }
	</script>
	
	
  
</head>  
<body class="easyui-layout">  
   
        <div region="west" split="true" title="菜单" style="width:280px;padding1:1px;overflow:hidden;">
            <div class="easyui-accordion" fit="true" border="false">
                <div title="商城管理" style="overflow:auto;" selected="true">
                    <p onclick="addTab('商品发布','goodsAdd')">商品发布</p>
                    <p onclick="addTab('商品信息','goodsList')">商品信息</p>
                </div>
            </div>
        </div> 
<div data-options="region:'center',title:''" style="padding:5px;background:#eee;">
	  <div id="tabs" class="easyui-tabs" fit="true" border="false">
	  </div>
</div>
  
</body>  
</html>  