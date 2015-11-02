/* 
 * Copyright (c) 2015, S.F. Express Inc. All rights reserved.
 */
package com.house.building;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.house.building.param.BuildingQueryParam;
import com.house.building.service.IBuildingService;

/**
 * ÃèÊö£º
 * 
 * <pre>HISTORY
 * ****************************************************************************
 *  ID   DATE           PERSON          REASON
 *  1    2015Äê11ÔÂ2ÈÕ      608279         Create
 * ****************************************************************************
 * </pre>
 * @author 608279
 * @since 1.0
 */
public class Test {

	public static void main(String[] args) {
		ApplicationContext ac = new ClassPathXmlApplicationContext("hessian-client.xml");
		IBuildingService buildingService = (IBuildingService) ac.getBean("buildingServiceClient");
		BuildingQueryParam param = new BuildingQueryParam(); 
		buildingService.query(param, 1, 30);
	}

}
