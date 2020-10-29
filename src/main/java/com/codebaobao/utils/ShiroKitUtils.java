package com.codebaobao.utils;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

public class ShiroKitUtils {

    private static final String NAMES_DELIMETER = ",";

    /**
     加盐参数
     */
    public static final  String  HASH_ALGORITHM_NAME = "MD5";

    /**
     循环次数
     */
    public static final  int  HASH_ITERATIONS = 1024;

    /**
     shiro密码加密工具类
     @param credentials 密码
     @param saltSource 密码盐
     @return
     */
    public static String md5(String credentials, String saltSource) {
        ByteSource salt = new Md5Hash(saltSource);
        return new SimpleHash(HASH_ALGORITHM_NAME, credentials, salt, HASH_ITERATIONS).toString();
    }

    /**
     获取随机盐值
     @param length
     @return
     */
    public static String getRandomSalt(int length) {
        return ToolUtil.getRandomString(length);
    }

}
