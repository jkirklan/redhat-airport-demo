package com.redhat.airport.service;

import javax.inject.Inject;

import com.redhat.airport.data.CouponProducer;
import com.redhat.airport.model.Coupon;
import com.redhat.airport.model.Flight;

public class FlightInformationService {

	@Inject
	private CouponProducer cProducer;

	public Flight getFlightInfo(int flightNo, boolean demoMode) {
		Flight flight = retrieveFlightInformation(demoMode);

		return flight;
	}

	public Flight retrieveFlightInformation(boolean demoMode) {
		Flight flight = new Flight();
		flight.setFlightNo(70);
		flight.setAirlineCode("AC");
		flight.setDeparture("2015-06-02T12:00");
		flight.setArrival("2015-06-02T13:45");
		flight.setBoarding("2015-06-02T11:40");
		flight.setStartingAirport("BOS");
		flight.setDestinationAirport("YYZ");
		flight.setStartingCity("Boston");
		flight.setDestinationCity("Toronto");
		flight.setStartingGate(1);
		flight.setDestinationGate(1);
		if (demoMode) {
			Coupon coupon;
			flight.setFlightStatus("Delayed");
			coupon = cProducer.getCouponOnDelay();
			flight.setCoupon(coupon);
		} else {
			flight.setFlightStatus("On Time");
			flight.setCoupon(null);
		}
		return flight;
	}

}
