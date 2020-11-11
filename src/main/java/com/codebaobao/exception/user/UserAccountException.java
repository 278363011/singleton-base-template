package com.codebaobao.exception.user;

public class UserAccountException extends  RuntimeException{

    public UserAccountException(){
        super();
    }
    public UserAccountException(String message){
        super(message);
    }
}
