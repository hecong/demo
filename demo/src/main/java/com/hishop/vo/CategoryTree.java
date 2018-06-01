package com.hishop.vo;

import java.util.List;

public class CategoryTree {

    private String id;
    
    private String name;
    
    private List<CategoryTree> child;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<CategoryTree> getChild() {
        return child;
    }

    public CategoryTree(String id, String name) {
        super();
        this.id = id;
        this.name = name;
    }

    public void setChild(List<CategoryTree> child) {
        this.child = child;
    }

    public CategoryTree() {
        super();
    }
    
    
    
    
}