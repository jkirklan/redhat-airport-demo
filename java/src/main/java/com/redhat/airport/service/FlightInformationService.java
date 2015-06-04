package com.redhat.airport.service;

import javax.inject.Inject;

import com.redhat.airport.data.CouponProducer;
import com.redhat.airport.model.Flight;

public class FlightInformationService {

	@Inject
	private CouponProducer cProducer;

	public Flight getFlightInfo(int flightNo) {
		Flight flight = demoFlightInformation();

		return flight;
	}

	/*
	 * Method for providing dummy data not used for production
	 */
	public Flight demoFlightInformation() {
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

		return flight;
	}
}
