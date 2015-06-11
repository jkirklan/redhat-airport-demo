package com.redhat.airport.rest;

import java.util.Collections;
import java.util.Set;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

@ApplicationPath("/rest")
public class BaseApplication extends Application {

	@Override
	public Set<Class<?>> getClasses() {

		return Collections.emptySet();

	}

}