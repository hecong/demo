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
		
		var url;  

        function searchGoods() {
        	var name =  $("#s_goodsName").val() == null ? null :  encodeURI($("#s_goodsName").val());
        	var code = $("#s_goodsCode").val() == null ? null :  encodeURI($("#s_goodsCode").val());
        	 var tCpt = $('#s_categoryId').combotree('tree');	// get the tree object
        	 var n = tCpt.tree('getSelected');		// get selected node	 
            $("#dg").datagrid('load', {  
                "goodsName" : name,
                "goodsCode"	: code,
                "categoryId" : n == null ? null : n.id
            });  
        }  

        function deleteGoods() {  
            var selectedRows = $("#dg").datagrid("getSelections");  
            if (selectedRows.length == 0) {  
                $.messager.alert("系统提示", "请选择要删除的数据！");  
                return;  
            }  
            var strIds = [];  
            for ( var i = 0; i < selectedRows.length; i++) {  
                strIds.push(selectedRows[i].id);  
            }  
            var ids = strIds.join(",");  
            $.messager.confirm("系统提示", "您确定要删除这<font color=red>"  
                    + selectedRows.length + "</font>条数据吗？", function(r) {  
                if (r) {  
                    $.post("${pageContext.request.contextPath}/goods/deleteGoods", {  
                        ids : ids  
                    }, function(result) {
                        if (result == "SUCESS") {  
                            $.messager.alert("系统提示", "数据已成功删除！");  
                            $("#dg").datagrid("reload");  
                        } else {  
                            $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");  
                        }  
                    });  
                }  
            });  
        }  
        
        $(function(){
            
            $('#dg').datagrid({
                url:'searchGoods',
                title:"全部商品", 
                pagination:"true",
                method:"get",
                fitColumns:"true",
                columns:[[
            		{field:'cb',checkbox:"true",align:"center"},
            		{field:'id',title:'编号',width:50,align:"center"},
            		{field:'goodsname',title:'商品',width:50,align:"center"},
            		{field:'goodscode',title:'商家编码',width:50,align:"center"},
            		{field:'fixedprice',title:'商品价格',width:50,align:"center"},
            		{field:'goodsStatus',title:'状态',width:50,align:"center",
             			formatter: function(value,row,index){
             				if(row.goodStatus == 0){
             					return "售卖中";
             				}else if(row.goodStatus == 1){
             					return "下架";
             				}else{
             					return "仓库中";
             				}
            			}	
            		},
            		{field:'inventory',title:'库存',width:50,align:"center"},
            		{field:'operation',title:'操作',width:50,align:"center",
            			formatter: function(value,row,index){
            				var estr = '<a href="${pageContext.request.contextPath}/goods/editGoods?id=' + row.id;
            				var str = estr + '" name="edit">编辑</a>' +'&nbsp&nbsp&nbsp'+ '<a href="javascript:deleteGoods()" name="delete">删除</a>';
    					return str;
            			}
            		}
                ]]
            });
        })

        
        
	</script>
	
	
  
</head>  
<body class="easyui-layout">  
<div data-options="region:'center',title:''" style="padding:5px;background:#eee;">
	<div id="tb">  
            <a href="javascript:deleteGoods()" class="easyui-linkbutton"  
            iconCls="icon-remove" plain="true">删除</a>  
        <div>
        <table>
				<tr>
					     商品名称： <input type="text" id="s_goodsName" size="20" onkeydown="if(event.keyCode == 13)searchUser()" /> 
				</tr>
				<tr>
            		 商家编码： <input type="text" id="s_goodsCode" size="20" onkeydown="if(event.keyCode == 13)searchUser()" /> 
				</tr>
				<tr>
             		商品分类： <select class="easyui-combotree" url="getCategoryTree" id="s_categoryId" style="width:156px;"/>
				</tr>
				<tr>
           <a href="javascript:searchGoods()" class="easyui-linkbutton"  
                iconCls="icon-search" plain="true">查询</a>  
				</tr>
		</table>
        </div>  
    </div> 
	<table id="dg" >
	</table> 
</div>
  
</body>  
</html>  