describe('flightServiceModule', function () {

	var flightStatusService;

    beforeEach(module('flightServiceModule'));

	beforeEach(function(){
		inject(function(_flightStatusService_) {
			flightStatusService = _flightStatusService_;
		});
	});

    it('should have a dummy test', inject(function() {
        expect(true).toBeTruthy();
    }));

	it('should have a flightStatus function', function () { 
		expect(angular.isFunction(flightStatusService.flightStatus)).toBe(true);
	});
});