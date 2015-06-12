describe('flightServiceModule', function () {

	var flightStatusService, httpBackend;

    beforeEach(module('flightServiceModule'));

	beforeEach(function(){
		inject(function(_flightStatusService_, $httpBackend) {
			flightStatusService = _flightStatusService_;
			httpBackend = $httpBackend;
		});
	});

	afterEach(function() {
        httpBackend.verifyNoOutstandingExpectation();
        httpBackend.verifyNoOutstandingRequest();
    });

    it('should have a dummy test', inject(function() {
        expect(true).toBeTruthy();
    }));

	it('should have a flightStatus function', function () { 
		expect(angular.isFunction(flightStatusService.flightList)).toBe(true);
	});

// it('should have an empty array on error for flightList', function () { 
// httpBackend.whenGET('http://redhatairportdemo-fguanlao.rhcloud.com/rest/flightStatus/list')
// .respond(500, 'error');

// flightStatusService.flightList()
// .then(function(result) {
// expect(result).toBe('');
// });
// httpBackend.flush();
// });
});