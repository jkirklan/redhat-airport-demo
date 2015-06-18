/**
 * Each section of the site has its own module. It probably also has
 * submodules, though this boilerplate is too simple to demonstrate it. Within
 * 'src/app/home', however, could exist several additional folders representing
 * additional modules that would then be listed as dependencies of this one.
 * For example, a 'note' section could have the submodules 'note.create',
 * 'note.delete', 'note.edit', etc.
 *
 * Regardless, so long as dependencies are managed correctly, the build process
 * will automatically take take of the rest.
 */
(function(module) {

    // As you add controllers to a module and they grow in size, feel free to place them in their own files.
    //  Let each module grow organically, adding appropriate organization and sub-folders as needed.
    module.controller('HomeController', function ($http, $interval, flightStatusService, $state, $scope) {
        // The top section of a controller should be lean and make it easy to see the "signature" of the controller
        //  at a glance.  All function definitions should be contained lower down.
        var model = this;
        model.currentPage = 0;
        model.maxPageSize = 6;

        init();

        function init() {

            stopInterval();
            // A definitive place to put everything that needs to run when the controller starts. Avoid
            //  writing any code outside of this function that executes immediately.
            flightStatusService.flightList()
            .then(function(result) {
                model.flights = result;
                model.paginatedFlights = model.flights.splice(0,model.maxPageSize);
         //       model.paginateInterval = $interval(paginateInterval,3000);
                model.checkSignStatusInterval = $interval(checkSignStatus, 3000);
            });
        }

        function paginateInterval() {
            if (model.flights.length > model.maxPageSize){
                var startingFlight = model.currentPage*model.maxPageSize;
                model.paginatedFlights = model.flights.slice(startingFlight,startingFlight+model.maxPageSize);
                ++model.currentPage;
                if ((startingFlight + model.maxPageSize) > model.flights.length){
                    model.currentPage = 0 ;
                }
            }
        }

        function checkSignStatus(){
            flightStatusService.updateSign()
            .then(function(result){
                if (result.demoSign >0){
                    $state.go('flightStatus');
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

// The name of the module, followed by its dependencies (at the bottom to facilitate enclosure)
}(angular.module("digitalSignage.home")));