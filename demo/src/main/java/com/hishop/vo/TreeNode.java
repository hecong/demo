package com.hishop.vo;

import java.util.List;

public class TreeNode {

    private String id;
    
    private String text;
    
    private List<TreeNode> children;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<TreeNode> getChildren() {
        return children;
    }

    public TreeNode(String id, String text) {
        super();
        this.id = id;
        this.text = text;
    }

    public void setChildren(List<TreeNode> children) {
        this.children = children;
    }

    public TreeNode() {
        super();
    }
    
    
    
    
}