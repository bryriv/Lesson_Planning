'use strict';

var lpmtApp = angular.module('lmptApp', [
    'ngRoute',
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
            otherwise({
                redirectTo: '/plans'
            });
    }
]);

