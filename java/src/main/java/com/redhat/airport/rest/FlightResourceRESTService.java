package com.redhat.airport.rest;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.enterprise.context.RequestScoped;
import javax.enterprise.event.Event;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.redhat.airport.data.CouponProducer;
import com.redhat.airport.model.Coupon;
import com.redhat.airport.model.Flight;
import com.redhat.airport.service.FlightInformationService;

/*
 * Service for retrieving any flight data for mobile app and digital signage
 */
@Path("/flightStatus")
@RequestScoped
public class FlightResourceRESTService {

	private static final Logger logger = LoggerFactory.getLogger(FlightResourceRESTService.class);

	@Inject
	private FlightInformationService flightService;

	@Inject
	private CouponProducer cProducer;

	@Inject
	Event<Integer> event;

	/*
	 * API for Mobile App (Demo Mode)
	 */
	@GET
	@Path("/{flightNo:[0-9][0-9]*}")
	@Produces({ "application/json" })
	public Response getFlightStatus(@PathParam("flightNo") int flightNo, @QueryParam("demoMode") int demoMode) {
		Flight flight = new Flight();
		flight = flightService.getFlightInfo(flightNo);
		Coupon coupon;
		/*
		 * Only used during demo
		 */
		if (demoMode > 0) {
			switch (demoMode) {
			case 1:
				flight.setFlightStatus("On time");
				coupon = cProducer.demoCouponOnDelay();
				flight.setCoupon(coupon);
				logger.info("Firing event for Delayed Push Notification...");
				event.fire(demoMode);
				break;
			case 2:
				flight.setFlightStatus("Delayed");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
				Calendar c = Calendar.getInstance();
				try {
					c.setTime(sdf.parse(flight.getDeparture()));
					c.add(Calendar.MINUTE, 20);
					flight.setDeparture(sdf.format(c.getTime()));
				} catch (ParseException e) {
					logger.error("Error parsing time.");
				}
				flight.setStartingGate(5);
				coupon = cProducer.demoCouponOnDelay();
				flight.setCoupon(coupon);
				logger.info("Firing event for Changed Push Notification...");
				event.fire(demoMode);
				break;
			case 3:
				flight.setFlightStatus("On Time");
				logger.info("Firing event for On time Push Notification...");
				event.fire(demoMode);
				break;
			case 4:
				flight.setFlightStatus("Delayed");
				coupon = cProducer.demoCouponOnDelay();
				flight.setCoupon(coupon);
				break;
			default:
				logger.error("Invalid Demo number");
				break;
			}
		} else {
			flight.setFlightStatus("On Time");
			flight.setCoupon(null);
		}
		return Response.status(200).header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization").header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD").header("Access-Control-Max-Age", "1209600").entity(flight)
				.build();
	}

	/*
	 * API for Digital Signage
	 */
	@GET
	@Path("/list")
	@Produces("application/json")
	public Response getFlightList() {
		List<Flight> flightList = new ArrayList<Flight>();

		flightList = flightService.getFlightList();

		return Response.status(200).header("Access-Control-Allow-Origin", "*")
				.header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization").header("Access-Control-Allow-Credentials", "true")
				.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD").header("Access-Control-Max-Age", "1209600").entity(flightList)
				.build();
	}

}