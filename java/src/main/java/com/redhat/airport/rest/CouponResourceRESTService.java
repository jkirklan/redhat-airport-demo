package com.redhat.airport.rest;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

import com.redhat.airport.data.CouponProducer;
import com.redhat.airport.data.CouponRepository;
import com.redhat.airport.model.Coupon;

@Path("/flightStatus")
@RequestScoped
public class CouponResourceRESTService {

	@Inject
	private CouponRepository repository;

	private CouponProducer producer;

	private FlightInformationService flightService;

	@GET
	@Path("{flightNo:[0-9][0-9]*}")
	public Coupon getFlightStatus() {
		repository.findCouponByStatusSeverity()
		return coupon;
	}
}
