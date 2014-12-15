'use strict';

var lpmtControllers = angular.module('lpmtControllers', ['ui.bootstrap']);

lpmtControllers.controller('PlansCtrl', ['$scope', 'Plans',
    function($scope, Plans) {
        $scope.plans = Plans.query();
        console.log('in plan controller');
    }
]);

lpmtControllers.controller('PlanDetailsCtrl', ['$scope', '$routeParams', 'Plans', 'Teks',
    function($scope, $routeParams, Plans, Teks) {
        $scope.plan = Plans.get({planId: $routeParams.planId}, function(plan) {
            $scope.tek = Teks.get({tekId: $scope.plan.tek_id});
        })
    }
]);

lpmtControllers.controller('PlanNewCtrl', ['$scope', 'Plans', 'Teks',
    function($scope, Plans, Teks) {
        $scope.teks = Teks.query();
        console.log('in new plan controller');


        // Date Picker
        $scope.open = function($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };
        $scope.disabled = function(date, mode) {
            return ( mode === 'day' && ( date.getDay() === 0 || date.getDay() === 6 ) );
        };
        $scope.dateOptions = {
            showWeeks: false
        };
    }
]);
