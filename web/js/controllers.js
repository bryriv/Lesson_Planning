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

lpmtControllers.controller('PlanDetailsCtrl', ['$scope', '$routeParams', 'Plans', 'PlanVerbs', 'PlanResources', 'PlanSections',
    function($scope, $routeParams, Plans, PlanVerbs, PlanResources, PlanSections) {
        $scope.plan = Plans.get({planId: $routeParams.planId}, function(plan) {
            $scope.verbs = PlanVerbs.query({planId: $routeParams.planId});
            $scope.resources = PlanResources.query({planId: $routeParams.planId});
            $scope.sections = PlanSections.query({planId: $routeParams.planId});
        })
    }
]);

lpmtControllers.controller('PlanNewCtrl', ['$scope', '$location', '$filter', '$rootScope', 'Message', 'Plans', 'Teks', 'PS', 'Verbs',
    function($scope, $location, $filter, $rootScope, Message, Plans, Teks, PS, Verbs) {
        $scope.message = Message;
        $scope.teks = Teks.query();
        $scope.ps = PS.query();
        $scope.verbs = Verbs.query();
        $scope.update = function() {
        };

        $scope.createNewPlan = function() {
            // $scope.plan.payload = {};
            // $scope.plan.payload.plan_d = $filter('date')($scope.plan.plan_date, 'yyyy-MM-dd');
            // $scope.plan.payload.tek_id = $scope.plan.tek.id;
            // $scope.plan.payload.grade = $scope.plan.tek.grade;
            // $scope.plan.payload.tek_label = $scope.plan.tek.label;
            // $scope.plan.payload.ps_id = $scope.plan.ps.id;

            // console.log($scope.plan);
            var payload = {};
            // plan data
            payload.plan_d = $filter('date')($scope.plan.plan_date, 'yyyy-MM-dd');
            payload.tek_summary_id = $scope.plan.tek.id;
            payload.grade = $scope.plan.tek.grade;
            payload.tek_label = $scope.plan.tek.label;
            payload.proc_standard_id = $scope.plan.ps.id;
            payload.create_d = $filter('date')(new Date(), 'yyyy-MM-dd');

            // extra data
            payload.sections = $scope.plan.sections;
            payload.verb_plan_maps = $scope.plan.verbs;
            payload.resources = $scope.plan.resources;

            var response = Plans.create(payload, function(saveResponse) {
                if (saveResponse.message === 'OK') {
                    Message.prep('newMessage', "New plan created");
                    $location.path("/plans");
                }
            });
        };

        $scope.$on('newVerb', function() {
            console.log('new verb added, refreshing list');
            $scope.verbs = Verbs.query();
        });

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

lpmtControllers.controller('VerbNewCtrl', ['$scope', 'Verbs', 'Message',
    function($scope, Verbs, Message) {
        $scope.addVerb = function() {
            var response = Verbs.create($scope.verb, function(saveResponse) {
                if (saveResponse.message === 'OK') {
                    Message.prep('newVerb');
                    Message.prep('newMessage', "Added verb '" + $scope.verb.verb + "'");
                    $scope.verb = '';
                }
            });
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
