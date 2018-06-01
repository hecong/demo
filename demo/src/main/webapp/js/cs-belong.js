/** 
 *	项目独有的 初始化上传空间, 图片显示, 删除等功能方法
 **/

/**
 * 初始化上传图片路径
 * id-按钮控件的id, 只所以加上这个参数, 是因为原来的项目中 一个页面有多个上传按钮存在的缘故
 * btnValue-上传按钮上的位子
 * return_input_id-返回的图片id放置的input控件id
 */
function initUploadfile(btnId,btnValue,returnInputId){
	$('#' + btnId).diyUpload({
		url: esd.common.server + 'security/filegags/upload',
		success:function( returndata ) {
			var data = returndata.notice;
			// 提取提示文字
			var notice = data.substring(0,data.indexOf('!'));
			if(notice == 'success'){
				var result = data.substring(data.indexOf('!') + 1);
				var preValue = $('#'+returnInputId).val();
				$('#'+returnInputId).val(preValue + result);
			}
		},
		error:function( err ) {
			alert('上传图片发生错误, 请刷新页面重新尝试, 或者联系管理员.');
		},
		buttonText : btnValue,
		chunked:true,
		// 分片大小
		chunkSize:512 * 1024,
		//最大上传的文件数量, 总文件大小,单个文件大小(单位字节);
		fileNumLimit:50,
		fileSizeLimit:500000 * 1024,
		fileSingleSizeLimit:50000 * 1024,
		accept: {}
	});
}

/**
 * 处理 存在的图片字符串, 分割, 并使之在前台显示出来~~
 * containerDiv-存放图片的div
 * filestr-取出来的图片名称组字符串, 其中是用 | 链接
 * filelistinput-图片文件名保存的隐藏input id
 **/
function initImg(containerDiv,filestr,filelistinput){
	// 分割字符串
	if(filestr == null || filestr == '' || filestr == undefined){
		return;
	}
	var fileNameArray = filestr.split('|');
	// 循环其中每个文件名, 组装成对应图片路径, 放到对应img的src中
	var content = '';
	$.each(fileNameArray,function(index,item){
		if(item == null || item == undefined || item == ''){
			
		}else{
			//图片, 单击查看, 双击删除
			content += '<img src="' + esd.common.server + 'upload/' + item + '" style="width:50px;" onmousedown="operateImg(event,this,\'' + filelistinput + '\')" />';
		}
	});
	$('#'+containerDiv).html(content).addClass('preImgList');
}

 
 /**
  * 图片点击事件, 左键查看, 右键删除
  **/
function operateImg(event,obj,filelistinput){
	// 右键
	if(event.button=='2'){  
		delImg(obj,filelistinput);
	}else{
	//左键
		showImg(obj); 
	}  
}

/**
 * 查看单张图片方法
 **/
function showImg(obj){
	var content = '<input type="button" value="关闭" onclick="hidediv()"/><br/><img src="' + $(obj).attr('src') + '" />';
	$('#bgDiv').show();
	$('#imgShowDiv').html(content).show();
}
/**
 * 删除单张图片方法
 **/
function delImg(obj,filelistinput){
	if(filelistinput == null  || filelistinput =='' || filelistinput == undefined){
		return;
	}
	if(!window.confirm('确实要删除该张图片么,此操作不可恢复, 点 “是” 继续删除, 点 “否” 取消。 ')){
		return;
	}else{
		//将对应的图片url从隐藏的input中删除
		// 1-取得图片名并加上 |
		var preurl = $(obj).attr('src');	//图片url
		var imgname = preurl.substring(preurl.lastIndexOf('/')+1) + '|'; //图片文件名
		// 2-从 隐藏input中 将imgname 删除掉~~
		var tt = $('#'+filelistinput).val();
		var targetvalue = $('#'+filelistinput).val().replace(imgname,'');
		// 3-新值赋给隐藏input
		$('#'+filelistinput).val(targetvalue);
		// 4-将该图片元素去除掉
		$(obj).remove();
	}
}

// 隐藏遮罩层
function hidediv() {
	$('#bgDiv').hide();
	$('#imgShowDiv').hide();
}