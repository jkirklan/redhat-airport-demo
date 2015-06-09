(function(module) {

	module.factory('flightStatusService', function($http, $q){
		// this.users = ['John', 'James', 'Jake'];
		// return this;

		return {
			flightStatus: function(){
				var deferred = $q.defer();
				$http.get('http://redhatairportdemo-fguanlao.rhcloud.com/rest/flightStatus/list').
				success(function(data, status, headers, config) {
					if (status===200){
						deferred.resolve(data);
					}else{
						return [];
					}
				}).
				error(function(data, status, headers, config) {
					return [];
				});

				return deferred.promise;
			}
		};
	});

}(angular.module("service", [])));