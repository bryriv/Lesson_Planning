'use strict';

var lpmtControllers = angular.module('lpmtControllers', ['ui.bootstrap']);

lpmtControllers.controller('PlansCtrl', ['$scope', '$filter', 'Plans',
    function($scope, $filter, Plans) {
        $scope.plans = Plans.query();
        // $scope.plans.create_dt = new Date($scope.plans.create_dt).toISOString();
        // console.log($scope.plans);
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

lpmtControllers.controller('PlanNewCtrl', ['$scope', '$location', '$filter', '$rootScope', 'Message', 'Plans', 'Teks', 'PS', 'Verbs',
    function($scope, $location, $filter, $rootScope, Message, Plans, Teks, PS, Verbs) {
        $scope.message = Message;
        $scope.teks = Teks.query();
        $scope.ps = PS.query();
        $scope.verbs = Verbs.query();
        $scope.selectedVerbs = [];
        $scope.update = function() {
        };

        $scope.createNewPlan = function() {
            // $scope.plan.payload = {};
            // $scope.plan.payload.plan_d = $filter('date')($scope.plan.plan_date, 'yyyy-MM-dd');
            // $scope.plan.payload.tek_id = $scope.plan.tek.id;
            // $scope.plan.payload.grade = $scope.plan.tek.grade;
            // $scope.plan.payload.tek_label = $scope.plan.tek.label;
            // $scope.plan.payload.ps_id = $scope.plan.ps.id;

            var payload = {};
            // plan data
            payload.plan_d = $filter('date')($scope.plan.plan_date, 'yyyy-MM-dd');
            payload.tek_id = $scope.plan.tek.id;
            payload.grade = $scope.plan.tek.grade;
            payload.tek_label = $scope.plan.tek.label;
            payload.ps_id = $scope.plan.ps.id;
            payload.create_d = $filter('date')(new Date(), 'yyyy-MM-dd');

            // section data
            payload.sections = $scope.plan.sections;

            var response = Plans.create(payload, function(saveResponse) {
                if (saveResponse.message === 'OK') {
                    Message.prep("New plan created");
                    $location.path("/plans");
                }
            });
        };

        $scope.resetForm = function() {
            $scope.plan.tek = '';
            $scope.plan.ps = '';
        };

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

lpmtControllers.controller('MessageCtrl', ['$scope', '$timeout', 'Message',
    function($scope, $timeout, Message) {
        $scope.$on('newMessage', function() {
            $scope.alerts = [];
            var alert = {
                msg: Message.message,
                type: 'success'
            };
            alert.close = function(){
                $scope.alerts.splice($scope.alerts.indexOf(this), 1);
            }
            $scope.alerts.push(alert);
            $timeout(function(){
                $scope.alerts.splice($scope.alerts.indexOf(alert), 1);
            }, 3000);
        });
    }
]);
