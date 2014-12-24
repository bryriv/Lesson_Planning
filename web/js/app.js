'use strict';

var lpmtApp = angular.module('lmptApp', [
    'ngRoute',
    'xeditable',
    'ui.bootstrap',
    'angularUtils.directives.dirPagination',
    'lpmtControllers',
    'lpmtFilters',
    'lpmtServices'
]);

lpmtApp.config(['$routeProvider', '$locationProvider',
    function($routeProvider, $locationProvider) {
        // $locationProvider.hashPrefix('#');
        $routeProvider.
            when('/plans', {
                templateUrl: 'tpl/plans.html',
                controller: 'PlansCtrl'
            }).
            when('/plans/:planId', {
                templateUrl: 'tpl/plan-details.html',
                controller: 'PlanDetailsCtrl'
            }).
            when('/new', {
                templateUrl: 'tpl/plan-new.html',
                controller: 'PlanNewCtrl'
            }).
            when('/export/:planId', {
                controller: 'ExportPlanCtrl'
            }).
            otherwise({
                redirectTo: '/plans'
            });
    }
]);

lpmtApp.run(function(editableOptions) {
  editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});
