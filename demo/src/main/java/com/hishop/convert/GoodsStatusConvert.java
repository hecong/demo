package com.hishop.convert;

import org.springframework.core.convert.converter.Converter;

import com.hishop.common.GoodsStatus;

public class GoodsStatusConvert  implements
Converter<String, GoodsStatus> {

	@Override
	public GoodsStatus convert(String source) {
		String value = source.trim();
		if ("".equals(value)) {
		return null;
		}
		GoodsStatus status = GoodsStatus.valueOf(source);
		return status;
	}

}

