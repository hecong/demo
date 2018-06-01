package com.hishop.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.json.JSONUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hishop.entity.Goods;
import com.hishop.service.IGoodsService;
import com.hishop.vo.CategoryTree;
import com.hishop.vo.Option;
import com.hishop.vo.PageResult;
import com.hishop.vo.TreeNode;

@Controller  
@RequestMapping("/goods")  
public class GoodsController {
	
	private static Logger logger =Logger.getLogger(GoodsController.class);
	
	@Autowired
	private IGoodsService goodsService;
	
    @RequestMapping(value="/searchGoods",method=RequestMethod.GET) 
    @ResponseBody
    public PageResult<Goods> searchGoods(HttpServletRequest request,Model model,int page,int rows) throws Exception{  
        String goodsName = (request.getParameter("goodsName") == null || request.getParameter("goodsName").equals("")) ? null : String.valueOf(request.getParameter("goodsName"));
        String goodsCode = request.getParameter("goodsCode") == null ? null : String.valueOf(request.getParameter("goodsCode"));
        Integer categoryId = (request.getParameter("categoryId") == null || request.getParameter("categoryId").equals("")) ? null : Integer.parseInt(request.getParameter("categoryId"));
        if(goodsName != null && !goodsName.isEmpty()) {
        	goodsName = java.net.URLDecoder.decode(goodsName,"UTF-8");
        }else {
        	goodsName = null;
        }
        if(goodsCode != null && !goodsCode.isEmpty()) {
        	goodsCode = java.net.URLDecoder.decode(goodsCode,"UTF-8");
        }else {
        	goodsCode = null;
        }
        PageHelper.startPage(page, rows);
        List<Goods> goods = this.goodsService.searchGoods(goodsName,goodsCode,categoryId);
        PageInfo<Goods> pageInfo = new PageInfo<Goods>(goods);
        PageResult<Goods> result = new PageResult<Goods>();
        result.setRows(goods);
        result.setTotal(pageInfo.getTotal());
        return result;  
    } 
    
    @RequestMapping("/main")  
    public String toIndex(HttpServletRequest request,Model model){  
        return "main";  
    }
    
    @RequestMapping("/goodsList")  
    public String goodsList(HttpServletRequest request,Model model){  
        return "goodsList";  
    }
    
    @RequestMapping("/goodsAdd")  
    public String goodsAdd(HttpServletRequest request,Model model,Goods goods){  
        return "goodsAdd";  
    }
    
    @RequestMapping("/editGoods")  
    public String goodsEdit(HttpServletRequest request,Model model,Goods goods){  
        //查询
        Goods result = goodsService.selectGoods(goods.getId());
        //设置显示
        model.addAttribute("goods", result);
        //返回视图
        return "goodsEdit";
    }
    
    @RequestMapping(value="/getCategoryTree",method=RequestMethod.POST) 
    @ResponseBody
    public List<TreeNode> getCategoryTree(HttpServletRequest request,Model model) throws Exception{  
        List<TreeNode> trees = this.goodsService.getTreeNode("0");
        return trees;  
    } 
    
    @RequestMapping(value="/deleteGoods",method=RequestMethod.POST) 
    @ResponseBody
    public String deleteGoods(HttpServletRequest request,Model model,String ids) throws Exception{
    	String[] idlist = ids.split(",");
    	for (String id : idlist) {
    		int result = goodsService.deleteGoods(id);
    		if(result <= 0) {
    			logger.error("删除商品信息失败");
    			return "FAILE";
    		}
		}
        return "SUCESS";  
    } 

    
    
    @RequestMapping(value="/getCategory",method=RequestMethod.GET) 
    @ResponseBody
    public Option getCategory(HttpServletRequest request,Model model) throws Exception{  
        List<CategoryTree> trees = this.goodsService.getCategoryTree("0");
        Option option = new Option(trees);
        return option;  
    } 
    
    
    @RequestMapping(value="/deleteImage",method=RequestMethod.GET) 
    @ResponseBody
    public Boolean deleteImage(HttpServletRequest request,Model model,String imageName) throws Exception{  
        String uploadFileUrl = request.getSession()  
                .getServletContext().getRealPath("") + "\\uploadFiles"; 
        String fileName = uploadFileUrl + "\\" +imageName;
        File file = new File(fileName);
        if(file.isFile() && file.exists()){
            Boolean succeedDelete = file.delete();
            if(succeedDelete){
                System.out.println("删除单个文件"+fileName+"成功！");
                return true;
            }
            else{
                System.out.println("删除单个文件"+fileName+"失败！");
                return true;
            }
        }else{
            System.out.println("删除单个文件"+fileName+"失败！");
            return false;
        }
    } 
    
    
    
    /** 
     * 多文件上传接收方法 
     *  
     * @param request 
     * @return 
     * @throws IOException 
     */  
    @RequestMapping(value = "/uploadImage", method = RequestMethod.POST)  
    @ResponseBody  
    public Map<String, Object> aadd_worker(  
            MultipartHttpServletRequest multipartRequest,  
            HttpServletResponse response) throws IOException {  
        response.setContentType("text/html;charset=utf-8");  
        String result = "";  
        Map<String, Object> map = new HashMap<String, Object>();
        String basePath  = "";
        String visitUrl  = "";
        String fileName = "";
        // 1-获取多个文件  
        for (Iterator<String> it = multipartRequest.getFileNames(); it.hasNext();) {  
            // a-将读取到的单个文件保存到服务器的 uploadPath 路径下  
            String key = (String) it.next(); // 文件名  
            logger.info("key: " + key);  
            MultipartFile multipartFile = multipartRequest.getFile(key); // 根据key得到文件  
            if (multipartFile.getOriginalFilename().length() > 0) {  
                String originalFileName = multipartFile.getOriginalFilename();  
                // b-截取后缀, 重命名文件, 使用uuid+后缀的方式命名保存到服务器上的文件  
                String suffix = originalFileName.substring(originalFileName  
                        .lastIndexOf("."));  
                logger.info("文件后缀: " + suffix);  
                // KitService.getUUID() 为自己写的自动生成一个UUID方法, 您可以自己写  
                 fileName = UUID.randomUUID() + suffix;  
                logger.info("新文件名: " + fileName);  
                try {  
                    String uploadFileUrl = multipartRequest.getSession()  
                            .getServletContext().getRealPath("") + "\\uploadFiles";  
                    logger.info("保存文件路径: " + uploadFileUrl);  
                    // c- 将文件保存到目标目录下  
                    File uploadFile = saveFileFromInputStream(  
                            multipartFile.getInputStream(), uploadFileUrl,  
                            fileName);  
                    if (uploadFile.exists()) {  
                    	logger.info(originalFileName + "上传成功");  
                    	basePath = uploadFileUrl;
                    	visitUrl = "/uploadFiles".concat("/"+fileName);
                        map.put("state", "SUCCESS");  
                        map.put("url", visitUrl);  
                        map.put("size", multipartFile.getSize());  
                        map.put("original", fileName);  
                        map.put("type", multipartFile.getContentType());  
                        map.put("filename", originalFileName);  
                    } else {  
                    	logger.info(originalFileName + "上传失败");  
                        throw new FileNotFoundException("file write fail: "  
                                + fileName);  
                    }  
                } catch (Exception e) {  
                    logger.info(originalFileName + "上传失败");  
                    e.printStackTrace();  
                }  
                result += fileName + ";";  
            }  
        }  
        // response.getWriter().write(result);  
        map.put("notice", result);  
        return map;  
    }  
    
    
 // 保存文件到指定路径  
    private File saveFileFromInputStream(InputStream stream, String path,  
            String filename) {  
        // 检查保存上传文件的文件夹是否存在  
        File dirFile = new File(path);  
        if (!dirFile.exists()) {  
            dirFile.mkdir();  
        }  
        File file = null;  
        FileOutputStream fs = null;  
        try {  
            file = new File(path + "\\" + filename);  
            fs = new FileOutputStream(file);  
            byte[] buffer = new byte[1024 * 1024];  
            int bytesum = 0;  
            int byteread = 0;  
            while ((byteread = stream.read(buffer)) != -1) {  
                bytesum += byteread;  
                fs.write(buffer, 0, byteread);  
                fs.flush();  
            }  
            fs.close();  
            stream.close();  
        } catch (FileNotFoundException e) {  
            logger.error(e.getMessage());
        } catch (IOException e) {  
        	logger.error(e.getMessage());
        } finally {  
            try {  
                if (fs != null) {  
                    fs.close();  
                }  
                if (stream != null) {  
                    stream.close();  
                }  
            } catch (IOException e) {  
            	logger.error(e.getMessage());
            }  
        }  
        return file;  
    }  
    
    /** 
     * 供读取服务器上传成功的图片显示到jsp上使用(多个图片循环调用) 
     * @param request 
     * @param response 
     * @param imagePath  图片地址 
     * @return 
     */  
    @ResponseBody  
    @RequestMapping(value = "/viewImagesToPage")  
    public String viewImagesToPage(HttpServletRequest request,  
                                   HttpServletResponse response,  
                                   @RequestParam(value = "imagePath", required = false) String imagePath  
                                  ) {  
        System.out.println("imagePath:"+imagePath);  
        ServletOutputStream out = null;  
        FileInputStream ips = null;  
        try {  
            ips = new FileInputStream(new File(imagePath));  
            response.setContentType("multipart/form-data");  
            out = response.getOutputStream();  
            // 读取文件流  
            int i = 0;  
            byte[] buffer = new byte[4096];  
            while ((i = ips.read(buffer)) != -1) {  
                // 写文件流  
                out.write(buffer, 0, i);  
            }  
            out.flush();  
            ips.close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            if (out != null) {  
                try {  
                    out.close();  
                } catch (Exception e) {  
                    e.printStackTrace();  
                }  
            }  
            if (ips != null) {  
                try {  
                    ips.close();  
                } catch (Exception e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
        return null;  
    }
    
    @RequestMapping(value="save", method=RequestMethod.POST) 
    @ResponseBody
    public ModelAndView  doSave(Goods goods, HttpSession session,HttpServletRequest request){
    	String cid = goods.getCid();
    	String[] ids = cid.split(",");
    	goods.setCategoryid(Integer.parseInt(ids[2]));
    	goodsService.saveGoods(goods);
    	Map<String,Object> map = new HashMap<String, Object>();  
    	return new ModelAndView("goodsList",map);  
    }  
    
    @RequestMapping(value="update", method=RequestMethod.POST) 
    @ResponseBody
    public ModelAndView doUpdate(Goods goods, HttpSession session,HttpServletRequest request){
    	String cid = goods.getCid();
    	String[] ids = cid.split(",");
    	goods.setCategoryid(Integer.parseInt(ids[2]));
    	goodsService.update(goods);
    	Map<String,Object> map = new HashMap<String, Object>();  
    	return new ModelAndView("goodsList",map);  
    }  
}  
    
    
    
