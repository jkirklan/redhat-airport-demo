package com.redhat.airport.rest;

import java.util.HashMap;
import java.util.Map;

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

	private int updateSign = 0;

	@POST
	public Response updateDigitalSignage(@FormParam("showDetails") int updateSign) {

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

		String signMessage = null;
		Map<String, Object> signResponse = new HashMap<String, Object>();

		signResponse.put("demo", updateSign);
		if (updateSign > 0) {
			switch (updateSign) {
			case 1:
				signMessage = "Flight is delayed";
				break;
			case 2:
				signMessage = "Your gate has been changed. We apologize for the inconvenience. Approximate travel time to your gate is 00:05:43 minutes";
				break;
			case 3:
				signMessage = "Your flight is boarding in 10 minutes. Approximate travel time to your gate is 00:05:00 minutes";
				break;
			default:
				logger.error("Invalid demo number");
				break;
			}
		}

		signResponse.put("message", signMessage);

		return Response.status(200).header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization").header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD").header("Access-Control-Max-Age", "1209600")
				.entity(signResponse).build();
	}
}
