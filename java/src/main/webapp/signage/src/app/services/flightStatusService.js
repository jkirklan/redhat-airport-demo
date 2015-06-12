(function(module) {

	module.factory('flightStatusService', ['$http', '$q', function($http, $q){
		return {
			flightList: function(){
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
			},

			updateSign: function(){
				var deferred = $q.defer();
				$http.get('http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage/updateSign').
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
	}]);
}(angular.module("flightServiceModule", [])));