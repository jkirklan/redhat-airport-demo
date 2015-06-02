package com.redhat.airport.rest;

import com.redhat.airport.model.Flight;
import com.redhat.airport.service.FlightInformationService;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/flightStatus")
@RequestScoped
public class FlightResourceRESTService
{
  @Inject
  private FlightInformationService flightService;
  
  @GET
  @Path("/{flightNo:[0-9][0-9]*}")
  public Flight getFlightStatus(@PathParam("flightNo") int flightNo)
  {
    Flight flight = this.flightService.getFlightInfo(flightNo);
    
    return flight;
  }
}
