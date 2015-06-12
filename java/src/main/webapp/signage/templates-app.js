angular.module('templates-app', ['about/about.tpl.html', 'flightStatus/flightStatus.tpl.html', 'home/home.tpl.html']);

angular.module("about/about.tpl.html", []).run(["$templateCache", function($templateCache) {
  $templateCache.put("about/about.tpl.html",
    "<h1>About</h1>\n" +
    "\n" +
    "<p>This is what this is about.</p>");
}]);

angular.module("flightStatus/flightStatus.tpl.html", []).run(["$templateCache", function($templateCache) {
  $templateCache.put("flightStatus/flightStatus.tpl.html",
    "<div class=\"row flight-s\" style=\"height:100%\">\n" +
    "	<div class=\"col-xs-7 flight-status-details-section\" style=\"height:100%;\">\n" +
    "	    <div class=\"row\" style=\"height:20%;\">\n" +
    "			<div class=\"col-xs-3\">\n" +
    "				<span class=\"flight-status-details-header\">FLIGHT</span> </br>\n" +
    "				<span class=\"flight-status-details-label1\">{{model.flight.airlineCode+' '+model.flight.flightNo}}</span> </br>\n" +
    "				<span class=\"flight-status-details-label2\">{{model.destinationCity}}</span>\n" +
    "			</div>\n" +
    "			<div class=\"col-xs-3\">\n" +
    "				<span class=\"flight-status-details-header\">BOARDING TIME</span> </br>\n" +
    "				<span class=\"flight-status-details-label1\">20:35</span>\n" +
    "			</div>\n" +
    "			<div class=\"col-xs-3\">\n" +
    "				<span class=\"flight-status-details-header\">GATE</span> </br>\n" +
    "				<span class=\"flight-status-details-label1\">{{model.flight.startingGate}}</span>\n" +
    "			</div>\n" +
    "			<div class=\"col-xs-3\">\n" +
    "				<span class=\"flight-status-details-header\">STATUS</span> </br>\n" +
    "				<span class=\"flight-status-details-label1\"\n" +
    "				ng-class=\"{'flight-status-on-time': (model.status == 0 || model.status == 3 || model.status == 1), 'flight-status-changed': model.status == 2}\">{{model.flight.flightStatus}}</span>\n" +
    "			</div>\n" +
    "	    </div>\n" +
    "	    <div class=\"row\">\n" +
    "	    	<div class=\"col-xs-10\">\n" +
    "				<span class=\"flight-status-danger-label\">{{model.signHeader}}</span></br>\n" +
    "				<span class=\"flight-status-late-description\">{{model.signMessage}}</span>\n" +
    "	    	</div>\n" +
    "	    </div>\n" +
    "	    <div class=\"row\">\n" +
    "	    	<div class=\"col-xs-8\">\n" +
    "				<span class=\"flight-status-details-label3\">Approximate Time to Gate</span></br>\n" +
    "				<span class=\"flight-status-danger-label\">5 minutes</span>\n" +
    "	    	</div>\n" +
    "	    </div>\n" +
    "	    <div class=\"row\">\n" +
    "	    	<div class=\"col-xs-8\">\n" +
    "				<span class=\"flight-status-details-label3\">CURRENT TIME</span></br>\n" +
    "				<span class=\"flight-status-details-label1\">20:40</span>\n" +
    "	    	</div>\n" +
    "	    </div>\n" +
    "	</div>\n" +
    "	<div class=\"col-xs-5\" style=\"height:100%\">\n" +
    "		<div class=\"text-center home-model-container\" style=\"height:100%\">\n" +
    "			<img src=\"assets/airport_model.png\">\n" +
    "		</div>\n" +
    "	</div>\n" +
    "</div>");
}]);

angular.module("home/home.tpl.html", []).run(["$templateCache", function($templateCache) {
  $templateCache.put("home/home.tpl.html",
    "<div class=\"row home-screen\" style=\"height:100%\">\n" +
    "	<div class=\"col-xs-7\" style=\"height:100%;\">\n" +
    "	    <table class=\"table\" cellspacing=\"0\" cellpadding=\"0\">\n" +
    "	      <thead>\n" +
    "		    <tr>\n" +
    "	          <th colspan=\"100\" class=\"text-center departure-label\">DEPARTURES</th>		\n" +
    "	        </tr>\n" +
    "	      </thead>\n" +
    "	      <tbody class=\"flight-table-body\">\n" +
    "	        <tr>\n" +
    "	          <th colspan=\"40\">DESTINATION</th>\n" +
    "	          <th colspan=\"15\">FLIGHT</th>\n" +
    "	          <th colspan=\"15\">TIME</th>\n" +
    "	          <th colspan=\"15\">STATUS</th>\n" +
    "	          <th colspan=\"15\">GATE</th>\n" +
    "	        </tr>\n" +
    "			<tr ng-repeat=\"item in model.paginatedFlights\" class=\"departure-row-bg-color departure-row-animation departure-row\"> \n" +
    "				<td colspan=\"40\" scope=\"row\" style=\"text-overflow: ellipsis; white-space: nowrap; overflow: hidden;\">\n" +
    "						{{item.destinationCity}}\n" +
    "				</td>\n" +
    "				<td colspan=\"15\">{{item.airlineCode+' '+item.flightNo}}</td>\n" +
    "				<td colspan=\"15\">{{item.departure | date:'h:mma'}}</td>\n" +
    "				<td colspan=\"15\" ng-class=\"{'delayed-status': item.flightStatus == 'Delayed', 'onTime-status': item.flightStatus == 'On Time', 'changed-status': item.flightStatus == 'Changed' }\">{{item.flightStatus}}</td>\n" +
    "				<td colspan=\"15\">{{item.startingGate}}</td>\n" +
    "			</tr>\n" +
    "	      </tbody>\n" +
    "	    </table>\n" +
    "	</div>\n" +
    "	<div class=\"col-xs-5\" style=\"height:100%\">\n" +
    "		<div class=\"text-center home-model-container\" style=\"height:100%\">\n" +
    "			<img src=\"assets/airport_model_no_directions.png\">\n" +
    "		</div>\n" +
    "	</div>\n" +
    "</div>");
}]);
