(function(module) {

    module.config(['$stateProvider', function ($stateProvider) {
        $stateProvider.state('flightStatus', {
            url: '/flightstatus',
            views: {
                "main": {
                    controller: 'FlightStatusController as model',
                    templateUrl: 'flightStatus/flightStatus.tpl.html'
                }
            },
            data:{ pageTitle: 'FlightStatus' }
        });
    }]);

}(angular.module("digitalSignage.flightStatus", [
    'ui.router'
])));

(function(module) {

    module.config(['$stateProvider', function ($stateProvider) {
        $stateProvider.state('flightStatus', {
            url: '/flightstatus',
            views: {
                "main": {
                    controller: 'FlightStatusController as model',
                    templateUrl: 'flightStatus/flightStatus.tpl.html'
                }
            },
            data:{ pageTitle: 'FlightStatus' }
        });
    }]);

}(angular.module("digitalSignage.flightStatus", [
    'ui.router'
])));
