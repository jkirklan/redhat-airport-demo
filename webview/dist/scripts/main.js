var home=function(t,i,a){"use strict";var e={init:function(){this.flightData=this.getFlightData(),this.parseDepartureTime(),this.compileHandlebarsTemplate(),this.checkFlightStatus()},getFlightData:function(){var t={flight:{flightNo:70,airlineCode:"AC",departure:"2015-06-02T12:00",arrival:"2015-06-04T13:45",boarding:"2015-06-02T11:40",startingAirport:"BOS",destinationAirport:"YYZ",startingCity:"Boston",destinationCity:"Toronto",flightStatus:"On time",startingGate:1,destinationGate:1},coupon:{}};return t},compileHandlebarsTemplate:function(){var i=t("#current-flight-tmpl").html(),a=Handlebars.compile(i),e=a(this.flightData);t(".current-flight").append(e)},parseDepartureTime:function(){this.flightData.flight.departureTime=moment(this.flightData.flight.departure).calendar(new Date)},checkFlightStatus:function(){var i=t(".current-flight-departure"),a=t(".current-flight-status");"On time"===this.flightData.flight.flightStatus?(i.addClass("success"),a.addClass("success")):"Delayed"===this.flightData.flight.flightStatus?(i.addClass("failure"),a.addClass("failure")):"Changed"===this.flightData.flight.flightStatus&&(i.addClass("failure"),a.addClass("failure"))}};return e}(jQuery,window,document),flightDetails=function(t,i,a){"use strict";var e={init:function(){this.flightData=this.getFlightData(),this.parseFlightDate(),this.parseFlightTimes(),this.compileHandlebarsTemplate(),this.checkFlightStatus()},getFlightData:function(){var t={flight:{flightNo:70,airlineCode:"AC",departure:"2015-06-02T12:00",arrival:"2015-06-04T13:45",boarding:"2015-06-02T11:40",startingAirport:"BOS",destinationAirport:"YYZ",startingCity:"Boston",destinationCity:"Toronto",flightStatus:"On time",startingGate:1,destinationGate:1},coupon:{}};return t},compileHandlebarsTemplate:function(){var i=t("#flight-details-tmpl").html(),a=Handlebars.compile(i),e=a(this.flightData);t(".main-container").append(e)},parseFlightDate:function(){this.flightData.flight.flightDate=moment(this.flightData.flight.departure).format("ddd, MMM DD YYYY")},parseFlightTimes:function(){this.flightData.flight.departureTime=moment(this.flightData.flight.departure).format("HH:mm"),this.flightData.flight.arrivalTime=moment(this.flightData.flight.arrival).format("HH:mm"),this.flightData.flight.boardingTime=moment(this.flightData.flight.boarding).format("HH:mm")},checkFlightStatus:function(){var i=t(".flight-status");"On time"===this.flightData.flight.flightStatus?i.addClass("success"):"Delayed"===this.flightData.flight.flightStatus?i.addClass("failure"):"Changed"===this.flightData.flight.flightStatus&&i.addClass("failure")}};return e}(jQuery,window,document);