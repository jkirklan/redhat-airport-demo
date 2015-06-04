package com.redhat.airport.rest;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import com.redhat.airport.data.CouponProducer;
import com.redhat.airport.model.Coupon;
import com.redhat.airport.model.Flight;
import com.redhat.airport.service.FlightInformationService;

@Path("/flightStatus")
@RequestScoped
public class FlightResourceRESTService {
	@Inject
	private FlightInformationService flightService;

	@Inject
	private CouponProducer cProducer;

	// DemoMode variable only necessary for demo.
	@GET
	@Path("/{flightNo:[0-9][0-9]*}")
	@Produces({ "application/json" })
	public Flight getFlightStatus(@PathParam("flightNo") int flightNo, @QueryParam("demoMode") boolean demoMode) {
		Flight flight = new Flight();
		flight = flightService.getFlightInfo(flightNo);
		if (demoMode) {
			flight.setFlightStatus("Delayed");
			Coupon coupon;
			coupon = cProducer.demoCouponOnDelay();
			flight.setCoupon(coupon);
		} else {
			flight.setFlightStatus("On Time");
			flight.setCoupon(null);
		}
		return flight;
	}

}
