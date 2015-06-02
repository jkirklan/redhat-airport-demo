(function(app) {

    app.config(function ($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.otherwise('/home');
    });

    app.run(function () {});

    app.controller('AppController', function ($scope) {

    });

}(angular.module("digitalSignage", [
    'digitalSignage.home',
    'digitalSignage.about',
    'templates-app',
    'templates-common',
    'ui.router.state',
    'ui.router',
])));
