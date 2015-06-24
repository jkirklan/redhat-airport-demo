(function(app) {

    app.controller('AboutController', function ($scope, $state, $interval, flightStatusService) {
        var model = this;

        init();

        function init() {
            stopInterval();
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


		function stopInterval(){
			$interval.cancel(model.checkSignStatusInterval);
		}

		$scope.$on('$destroy', function() {
			stopInterval();
		});


	});

}(angular.module("digitalSignage.about")));