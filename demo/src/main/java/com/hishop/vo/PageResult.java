package com.hishop.vo;

import java.util.List;

public class PageResult<T> {
	private long total;
    private List<T> rows;

    public long getTotal() {
        return total;
    }
    public void setTotal(long total) {
        this.total = total;
    }
    public List<?> getRows() {
        return rows;
    }
    public void setRows(List<T> rows) {
        this.rows = rows;
    }   
}
