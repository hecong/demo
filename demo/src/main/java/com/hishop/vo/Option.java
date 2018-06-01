package com.hishop.vo;

import java.io.Serializable;
import java.util.List;

public class Option implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5634389988589428940L;
	
	
	private List<CategoryTree> option;


	public Option(List<CategoryTree> trees) {
		super();
		this.option = trees;
	}


	public List<CategoryTree> getOption() {
		return option;
	}


	public void setOption(List<CategoryTree> trees) {
		this.option = trees;
	}
	
	
	


}
