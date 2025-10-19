package com.app.model;

public class Factory {
    private Long id;
    private String code;
    private String name;
    private Long companyId;

    public Factory() {}

    public Factory(Long id, String code, String name, Long companyId) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.companyId = companyId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Long companyId) {
        this.companyId = companyId;
    }
}


