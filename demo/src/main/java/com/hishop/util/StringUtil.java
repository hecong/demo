package com.hishop.util;

/** 
 * 字符串工具类 
 * 
 */  
public final class StringUtil {  
      
    /** 
     * 判断字符串是否为空 
     * @param str 
     * @return 
     */  
    public static boolean isEmpty(String str){  
        return (str == null || "".equals(str.trim()));  
    }  
      
    /** 
     * 获取名称后缀 
     * @param name 
     * @return 
     */  
    public static String getExt(String name){  
        if(name == null || "".equals(name) || !name.contains("."))  
            return "";  
        return name.substring(name.lastIndexOf(".")+1);  
    }
    
    
//    
//    public static void main(String[] args) {
//		String a = "asdasdasda";
//		a = a.substring(1, a.length());
//		System.err.println(a);
//	}
}