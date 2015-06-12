package com.redhat.airport.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.redhat.airport.data.CouponProducer;
import com.redhat.airport.model.Flight;

@RequestScoped
public class FlightInformationService {

	private static final Logger logger = LoggerFactory.getLogger(FlightInformationService.class);

	@Inject
	private CouponProducer cProducer;

	/*
	 * Service for mobile app
	 */
	public Flight getFlightInfo(int flightNo) {
		logger.info("Retrieving Flight Info...");
		List<Flight> flightList = parseFlightInformation(false);
		Flight flight = flightList.get(0);
		return flight;
	}

	/*
	 * Service for digital signage
	 */
	public List<Flight> getFlightList() {
		logger.info("Retrieving Flight List...");
		List<Flight> flightList = new ArrayList<Flight>();
		flightList = parseFlightInformation(true);
		return flightList;

	}

	/*
	 * Parse JSON files for dummy data
	 */
	public List<Flight> parseFlightInformation(boolean flightList) {
		List<Flight> flightInfo = new ArrayList<Flight>();
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);
		String jsonName = flightList ? "flightList.json" : "flight.json";
		try {
			flightInfo = mapper.readValue(this.getClass().getClassLoader().getResource(jsonName), new TypeReference<List<Flight>>() {
			});

		} catch (JsonParseException e) {
			logger.error("Error parsing JSON");
		} catch (JsonMappingException e) {
			logger.error("Error mapping JSON");
		} catch (IOException e) {
			logger.error("Couldn't load file");
		}
		logger.info("Flight Info Found");
		return flightInfo;

	}
}