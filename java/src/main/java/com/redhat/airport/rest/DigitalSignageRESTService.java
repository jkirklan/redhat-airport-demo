package com.redhat.airport.rest;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.redhat.airport.model.DigitalSignage;
import com.redhat.airport.model.Flight;
import com.redhat.airport.service.FlightInformationService;

@ApplicationScoped
@Path("/digitalSignage")
public class DigitalSignageRESTService {

	private static final Logger logger = LoggerFactory.getLogger(DigitalSignageRESTService.class);

	private int updateSign = 0;

	@Inject
	private FlightInformationService flightService;

	/*
	 * API to receive demo scenario to change sign
	 */
	@GET
	@Path("/{showDetails:[0-9]*}")
	public Response updateDigitalSignage(@PathParam("showDetails") int updateSign) {
		this.updateSign = updateSign;
		logger.info("Digital Signage Call: {}", updateSign);

		return Response.status(200).header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization").header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD").header("Access-Control-Max-Age", "1209600").entity(updateSign)
				.build();
	}

	/*
	 * API to update sign
	 */
	@GET
	@Path("/updateSign")
	@Produces("application/json")
	public Response retrieveDigitalSignageUpdate() {
		DigitalSignage ds = new DigitalSignage();
		Flight flight = new Flight();
		ds.setDemoSign(updateSign);
		if (updateSign > 0) {
			flight = flightService.getFlightInfo(70);
			ds.setFlight(flight);
			switch (updateSign) {
			case 1:
				ds.setSignHeader("You are late!");
				ds.setSignMessage("Your boarding gate staff have been notified that you are on your way.");
				break;
			case 2:
				ds.setSignHeader("Your gate has been changed.");
				ds.setSignMessage("We apologize for the inconvenience.");
				ds.getFlight().setFlightStatus("Delayed");
				ds.getFlight().setStartingGate(5);
				break;
			case 3:
				ds.setSignHeader("Your flight is boarding in 10 minutes.");
				break;
			case 4:
				break;
			default:
				logger.error("Invalid demo number");
				break;
			}
		}

		return Response.status(200).header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization").header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD").header("Access-Control-Max-Age", "1209600").entity(ds).build();
	}

}
