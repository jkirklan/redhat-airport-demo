(function(module) {

module.controller('FlightStatusController', function ($state, $interval, flightStatusService) {
	var model = this;

	init();

	function init() {
		checkSignStatus();
		model.checkSignStatusInterval = $interval(checkSignStatus, 3000);
	}

	function checkSignStatus(){
		flightStatusService.updateSign()
		.then(function(result){
			model.signHeader = result.signHeader;
			model.signMessage = result.signMessage;
			model.flight = result.flight;
			model.status = result.demoSign;
			if (result.demoSign === 0){
				$state.go('home');
			}
		});
	}
});

}(angular.module("digitalSignage.flightStatus")));