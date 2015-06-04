package com.redhat.airport.rest;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import com.redhat.airport.model.Flight;
import com.redhat.airport.service.FlightInformationService;

@Path("/flightStatus")
@RequestScoped
public class FlightResourceRESTService {
	@Inject
	private FlightInformationService flightService;

	@GET
	@Path("/{flightNo:[0-9][0-9]*}")
	@Produces({ "application/json" })
	public Flight getFlightStatus(@PathParam("flightNo") int flightNo, @QueryParam("demoMode") boolean demoMode) {
		Flight flight = this.flightService.getFlightInfo(flightNo, demoMode);

		return flight;
	}
}
