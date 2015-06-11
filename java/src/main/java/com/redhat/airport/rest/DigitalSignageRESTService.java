package com.redhat.airport.rest;

import javax.enterprise.context.ApplicationScoped;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@ApplicationScoped
@Path("/digitalSignage")
public class DigitalSignageRESTService {

	private static final Logger logger = LoggerFactory.getLogger(DigitalSignageRESTService.class);

	private boolean updateSign = false;

	@POST
	public Response updateDigitalSignage(@FormParam("showDetails") boolean updateSign) {

		this.updateSign = updateSign;
		logger.info("Digital Signage Call: {}", updateSign);

		return Response.status(200).header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization").header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD").header("Access-Control-Max-Age", "1209600").entity(updateSign)
				.build();
	}

	@GET
	@Path("/updateSign")
	public Response retrieveDigitalSignageUpdate() {

		return Response.status(200).header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization").header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD").header("Access-Control-Max-Age", "1209600").entity(updateSign)
				.build();
	}
}
