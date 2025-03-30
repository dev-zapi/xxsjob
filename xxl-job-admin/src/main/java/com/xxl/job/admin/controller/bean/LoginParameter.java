package com.xxl.job.admin.controller.bean;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class LoginParameter {

    @NotBlank
    private String userName;
    @NotBlank
    private String password;
    @NotBlank
    private String ifRemember;

    public boolean remember() {
        String ifRemember = getIfRemember();
        return ifRemember != null && !ifRemember.trim().isEmpty() && "on".equals(ifRemember);
    }
}
