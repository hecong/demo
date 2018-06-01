<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
      <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";}
body{padding:20px;}
    .select-res span {
        display: inline-block;
        width:180px;
        height:14px;
        line-height:14px;
        padding:7px 15px 7px 5px;
        border:solid 1px #c0c0c0;
        background:url(${pageContext.request.contextPath}/images/select_box_bg.gif) no-repeat 190px center;
        cursor: pointer;
        color:#c2c2c2;
        text-overflow:ellipsis;
        white-space:nowrap;
        overflow:hidden;
    }
    .select-res p {
        position:relative;
        width: 200px;
        height:28px;
        line-height:28px;
        border-bottom:dashed 1px #c0c0c0;
        padding:0 5px;
        text-overflow:ellipsis;
        white-space:nowrap;
        overflow:hidden;
        padding-right:20px;
    }
    .select-res a {
        position:absolute;
        top:0;
        right:0;
        display: block;
        width:28px;
        height:28px;
        background:url(${pageContext.request.contextPath}/images/close_btn.jpg) no-repeat center;
        cursor:pointer;
    }
    .select-res input {
        width:172px;
        height:14px;
        line-height:14px;
        margin-left:4px;
        padding:7px 5px;
        border:solid 1px #c0c0c0;
        color:#2c2c2c;
    }
    .select-res span.selected {
        color:#626262;
    }
    .select-box {
        border:solid 1px #fd8340;
        width:480px;
        height:220px;
/*         padding:20px 20px 10px; */
        position:absolute;
        display:none;
        z-index:5;
        background: #fff;
    }
    .select-box .close-btn {
        position:absolute;
        right:5px;
        top:5px;
        cursor: pointer;
    }
    .select-box .wrap {
        height:200px;
        border:solid 1px #ddd;
        margin-top:5px;
    }
    .select-box ul {
        float:left;
        width:158px;
        height:200px;
        overflow-y: scroll;
    }
    .select-box ul li {
        height:25px;
        line-height:25px;
        padding:0 10px;
        background: url(${pageContext.request.contextPath}/images/arr.gif) no-repeat 152px center;
        color:#626262;
        cursor: pointer;
    }
    .select-box ul li.selected {
        background:url(${pageContext.request.contextPath}/images/arr_selected.gif) no-repeat 152px center #fd8340;
        color:#fff;
    }


#wizard {border:5px solid #789;font-size:12px;height:620px;margin:20px auto;width:570px;overflow:hidden;position:relative;-moz-border-radius:5px;-webkit-border-radius:5px;}
#wizard .items{width:20000px; clear:both; position:absolute;}
#wizard .right{float:right;}
#wizard #status{height:35px;background:#123;padding-left:25px !important;}
#status li{float:left;color:#fff;padding:10px 30px;}
#status li.active{background-color:#369;font-weight:normal;}
.input{width:240px; height:18px; margin:10px auto; line-height:20px; border:1px solid #d3d3d3; padding:2px}
.page{padding:20px 30px;width:500px;float:left;}
.page h3{height:42px; font-size:16px; border-bottom:1px dotted #ccc; margin-bottom:20px; padding-bottom:5px}
.page h3 em{font-size:12px; font-weight:500; font-style:normal}
.page p{line-height:24px;}
.page p label{font-size:14px; display:block;}
.btn_nav{height:36px; line-height:36px; margin:20px auto;}
.prev,.next{width:100px; height:32px; line-height:32px; border:1px solid #d3d3d3; cursor:pointer}
.sub{float:right;width:100px; height:32px; line-height:32px; border:1px solid #d3d3d3; cursor:pointer}
imageBox{ margin:2px auto; width:120px; min-height:20px; background:#FF9}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/scrollable.js"></script>
 <!-- 引入EasyUI -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
  <!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
  <!-- 引入EasyUI的样式文件-->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css"/>
  <!-- 引入EasyUI的图标样式文件-->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tinyImgUpload.css" type="text/css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
  <script src="${pageContext.request.contextPath}/js/tinyImgUpload.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/webuploader.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/diyUpload.css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/webuploader.html5only.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/diyUpload.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>

</head>
<body>


<form:form action="${pageContext.request.contextPath}/goods/update" method="post" modelAttribute="goods">
<div id="wizard">
	<ul id="status">
		<li class="active"><strong>1.</strong>选择商品分类</li>
		<li><strong>2.</strong>编辑商品信息</li>
		<li><strong>3.</strong>编辑商品详情</li>
	</ul>
	<div class="items">
		<div class="page">
		       <div class="select-res">
			        <span>请选择您主营的品类名称</span>
			    </div>
		    <div class="select-box">
		        <span class="close-btn">
		            <img src="${pageContext.request.contextPath}/images/close_btn.jpg" />
		        </span>
		        <div class="wrap">
		            <ul class="first"></ul>
		            <ul class="second"></ul>
		            <ul class="third"></ul>
		        </div>
		    </div>
		    <div class="btn_nav">
			  <input type="button" class="next right" value="下一步&raquo;" />
		   </div>
		</div>
		<div class="page">
		   <div class="selectCa"> <p><label>所属商品分类：</label></p> </div>
		    <form:hidden path="id"/>
		   <p><label>商品名称：</label><form:input path="goodsname" type="text" class="input" name="goodsname" /></p>
		   <p><label>商家编码：</label><form:input path="goodscode" type="text" class="input" name="goodscode" /></p>
		   <p><label>成本价：</label><form:input path="costprice" type="text" class="input" name="costprice" /></p>
		   <p><label>一口价：</label><form:input path="fixedprice" type="text" class="input" name="fixedprice" /></p>
		   <p><label>市场价：</label><form:input path="marketprice" type="text" class="input" name="marketprice" /></p>
		   <p><label>库存：</label><form:input path="inventory" type="text" class="input" name="inventory" /></p>
		   <p><label>商品状态：</label>
		   
		      <span class="radioSpan">
                <form:radiobutton name="goodStatus" path="goodStatus" value="0" checked="checked" />出售中
                <form:radiobutton name="goodStatus" path="goodStatus" value="1" />下架区
                <form:radiobutton name="goodStatus" path="goodStatus" value="2" />仓库中
            </span>
		   </p>
		   <div class="btn_nav">
			  <input type="button" class="prev" style="float:left" value="&laquo;上一步"/>
			  <input type="button" class="next right" value="下一步&raquo;" />
		   </div>
		</div>
		<div class="page">
		   <h3>图片和描述<br/></h3>
		   <p><label>商品主图：</label>
		   <div id="imageBox">
				<div id="imageUpload" ></div>
				<form:input path="image" type="hidden" id="image" name="image" />  
			</div>
		   </p>
		  <p><label>商品描述：</label>
		   <div id="goodsDsc">
				<div id="myEditor" name="content" style="width:100%;height:200px;"></div>
			</div>
		   </p>
		   <div class="btn_nav">
			  <input type="button" class="prev" style="float:left" value="&laquo;上一步" />
			  <input type="submit" id="submit" value="确定" class="sub"/>
		   </div>
		</div>
	</div>
</div>
</form:form>

<script type="text/javascript">
var dataJson = null;


function deleteImage(data){
	var value = data.attributes.value.value;
	var id = data.attributes.id.value;
	debugger;

	var i = $('#image').val();
	i = i.replace(value+";","");
	 $('#image').val(i);
	 $("#imageUpload").find("img[id='"+id+"']").remove();
	$.ajax({
        url:"${pageContext.request.contextPath}/goods/deleteImage",
        type:"GET",
        data:{"imageName":value},
        success:function(data){
//         	var i = $('#image').value;
//         	i = i.replace(value+";","");
//         	 $('#image').val(i);
//         	 $("#imageUpload").find("img[id='"+id+"']").remove();
        },
        error:function(data){
            alert("请求错误");
        },
        dataType:"json"

    });
}

/**
 * 文件上传
 */
$('#imageUpload').diyUpload({
	url:'${pageContext.request.contextPath}/goods/uploadImage',
	success:function( data ) {
		var notice = data.notice;
		var source = $("#image").val();
		if(source != null && source != ""){
			notice = source + notice;
		}
		$("#image").val(notice);
	},
	error:function( err ) {
		console.info( err );	
	}
});



$(function(){

	
	/* 表单滚动效果*/
	$("#wizard").scrollable({
		onSeek: function(event,i){
			$("#status li").removeClass("active").eq(i).addClass("active");
		},
		onBeforeSeek:function(event,i){
			if(i==1){
				var user = $("#user").val();
				if(user==""){
					alert("请输入用户名！");
					return false;
				}
				var pass = $("#pass").val();
				var pass1 = $("#pass1").val();
				if(pass==""){
					alert("请输入密码！");
					return false;
				}
				if(pass1 != pass){
					alert("两次密码不一致！");
					return false;
				}
			}
		}
	});
	
	
	var ue = UE.getEditor("myEditor",{
		   toolbars: [
		        ['fullscreen', 'source','bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|',
		        	'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|','simpleupload']
		    ],
		    scaleEnabled:true//设置不自动调整高度
	});
	UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;  
    UE.Editor.prototype.getActionUrl = function(action) {  
        if (action == 'uploadimage') {  
            return '<%=basePath%>/goods/uploadImage';  
        } else {  
            return this._bkGetActionUrl.call(this, action);  
        }  
    }  
    
	//编辑器
	
    //初始化编辑框内容  
    var htmlStr = '${goods.content}';
    ue.ready(function() {  
        ue.setContent(htmlStr, false);  
    });  
});


	var l1 = 0, l2 = 0;
	var cname1, cname2, cname3;
	var cid1, cid2, cid3;
	var canClick = !0;
	var canClose = !1;
	$('.select-box').css(
			{
				// left: $('.select-res').offset().left,
				top : $('.select-res').offset().top
						+ $('.select-res').outerHeight(true)
			});
	$('span', $('.select-res')).on('click', function() {
		$('.select-box').show();
		if (canClick) {
			$('ul', $('.select-box')).html('');
			fillData();
			canClick = !1;
		}
	});
	$('span', $('.select-box')).on("click", function() {
		canClose ? $('.select-box').hide() : alert('请选择下级品类！');
		canClick = !0;
	});

	$('.select-res').on(
			'click',
			'a',
			function() {
				$(this).parent().remove();
				$('.select-box').css(
						{
							top : $('.select-res').offset().top
									+ $('.select-res').outerHeight(true)
						});
			})

	$('ul.first', $('.select-box')).on('click', 'li', function() {
		$(this).addClass('selected').siblings().removeClass('selected');
		$('ul.third').html('');
		fillData($(this).index());
		l1 = $(this).index();
		cname1 = $(this).text();
		cid1 = $(this).attr('val');
		canClose = !1;
		$('input.cid', $('.select-res')).val(cid1);
		$('input.cname', $('.select-res')).val(cname1);
	});
	$('ul.second', $('.select-box')).on('click', 'li', function() {
		$(this).addClass('selected').siblings().removeClass('selected');
		fillData(l1, $(this).index());
		l2 = $(this).index();
		cname2 = $(this).text();
		cid2 = $(this).attr('val');
		canClose = !1;
		$('input.cid', $('.select-res')).val(cid1 + ',' + cid2);
		$('input.cname', $('.select-res')).val(cname1 + ',' + cname2);
	});
	$('ul.third', $('.select-box'))
			.on(
					'click',
					'li',
					function() {
						$(this).addClass('selected').siblings().removeClass(
								'selected');
						cname3 = $(this).text();
						cid3 = $(this).attr('val');
						canClose = !0;
						var hasExist = !1;
						$('.selectCa').find("p").each(function() {
							if($(this).text().split(' > ')[2] != null){
// 							if ($(this).text().split(' > ')[2] == cname3)
								hasExist = !0;
							$('.selectCa').children("p")[1].remove();
							}
						})
						
						$('.selectCa')
						.append(
								'<p>'
										+ cname1
										+ ' > '
										+ cname2
										+ ' > '
										+ cname3
										+ '<input type="hidden" value="' + cid1 + ',' + cid2 + ',' + cid3 + '" name="cid" /><input type="hidden" value="' + cname1 + ',' + cname2 + ',' + cname3 + '" name="cname" /></p>');
						$('.select-box').css(
								{
									top : $('.select-res').offset().top
											+ $('.select-res')
													.outerHeight(true)
								});
						$('input.cid', $('.selectCa')).val(
								cid1 + ',' + cid2 + ',' + cid3);
						$('input.cname', $('.selectCa')).val(
								cname1 + ',' + cname2 + ',' + cname3);
					});

	//填充级联数据

	function fillData(l1, l2) {
		if(dataJson == null){
			dataJson = $.ajax({url:"getCategory", async:false}).responseText;
			dataJson = JSON.parse(dataJson);
		}
		var temp_html = "";
		if (typeof (dataJson.option) != 'undefined' && arguments.length == 0) {
			$.each(dataJson.option, function(i, pro) {
				temp_html += '<li val="' + pro.id + '">' + pro.name + '</li>';
			});
		} else if (typeof (dataJson.option[l1].child) != 'undefined'
				&& arguments.length == 1) {
			$.each(dataJson.option[l1].child, function(i, pro) {
				temp_html += '<li val="' + pro.id + '">' + pro.name + '</li>';
			});
		} else if (typeof (dataJson.option[l1].child[l2].child) != 'undefined'
				&& arguments.length == 2) {
			$.each(dataJson.option[l1].child[l2].child, function(i, pro) {
				temp_html += '<li val="' + pro.id + '">' + pro.name + '</li>';
			});
		}
		$('.select-box ul:eq(' + arguments.length + ')').html(temp_html);
	}
	
	$(document).ready(function(){
		var gs = '${goods.cname}';
		var array;
		array =  gs.split(",");
		$('span', $('.select-res')).click();
		var firstArray = $('li', $('.first'));
		for (var index in firstArray){
			if(firstArray[index].innerText == array[0]){
				firstArray[index].click();
				break;
			}
		}
		var secondArray = $('li', $('.second'));
		for (var index in secondArray){
			if(secondArray[index].innerText == array[1]){
				secondArray[index].click();
				break;
			}
		}
		var thirdArray = $('li', $('.third'));
		for (var index in thirdArray){
			if(thirdArray[index].innerText == array[2]){
				thirdArray[index].click();
				break;
			}
		}
		
		//图片
		var st ='${pageContext.request.contextPath}';
		var imageName = $('#image').val();
		debugger;
		if(imageName != ""){
			debugger;
			 var divshow = $("#imageUpload");
			 var imageArray = imageName.split(";");
			 for (var index in imageArray){
				 var imageIndex = imageArray[index];
				 imageIndex = imageIndex.substring(0,imageIndex.length);
				 if(imageIndex == null || imageIndex == ""){
					 continue;
				 }
			 var h="<img id=\"image" +index+"\" onclick='javascript:deleteImage(this)' value='"+imageIndex+"' src='${pageContext.request.contextPath}/uploadFiles/"+imageIndex+"' style=\"width:40px;height:40px;margin-right:-4px;\"/>";
			 divshow.append(h);
			 }
		}
	});
	
	
</script>

</body>
</html>  