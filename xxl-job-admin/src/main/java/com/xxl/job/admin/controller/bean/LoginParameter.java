package com.xxl.job.admin.controller.bean;

import lombok.Data;

@Data
public class LoginParameter {

    private final String userName;
    private final String password;
    private final String ifRemember;

    public LoginParameter(String userName, String password, String ifRemember) {
        this.userName = userName;
        this.password = password;
        this.ifRemember = ifRemember;
    }

    public boolean remember() {
        String ifRemember = getIfRemember();
        return ifRemember != null && !ifRemember.trim().isEmpty() && "on".equals(ifRemember);
    }
}
