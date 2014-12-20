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

lpmtControllers.controller('PlanDetailsCtrl', ['$scope', '$timeout', '$routeParams', '$modal', '$location', 'Message', 
                                                'Plans', 'PlanVerbs', 'PlanResources', 'PlanSections', 'Verbs', 'PS', 'Teks',
    function($scope, $timeout, $routeParams, $modal, $location, Message, Plans, PlanVerbs, 
                    PlanResources, PlanSections, Verbs, PS, Teks) {
        $scope.plan = Plans.get({planId: $routeParams.planId, query_type: 'complete'}, function(plan) {
            // $scope.plan.plan_d = "2014-12-25";
            $scope.verbs = PlanVerbs.query({planId: $routeParams.planId}, function(verbs) {
                $scope.selectedVerbs = $scope.showVerbs(verbs);
                $scope.startingVerbs = [1, 2, 3];
            });
            $scope.sections = PlanSections.query({planId: $routeParams.planId}, function(sections) {
                sections.forEach(function(section) {
                    section.content = (section.content === null) ? '' : section.content;
                });
            });
            $scope.resources = PlanResources.query({planId: $routeParams.planId}, function(getResp) {
                getResp.forEach(function(resource) {
                    resource.complete = (resource.complete=="0") ? false : true;
                    resource.notes = (resource.notes === null) ? 'No Notes' : resource.notes;
                });
            });
        });
        $scope.updateSection = function (id, data) {
            var update = PlanSections.update({planId: $scope.plan.id, sectionId: id}, {content: data}, function(saveResponse) {
                if (saveResponse.message === 'OK') {
                    return true;
                }
            });
        };
        $scope.updateResource = function(id, data) {
            var update = PlanResources.update({planId: $scope.plan.id, resourceId: id}, data, function(saveResponse) {
                if (saveResponse.message === 'OK') {
                    return true;
                }
            });
        };
        $scope.updateVerbs = function(data) {
            var update = PlanVerbs.update({planId: $scope.plan.id}, {verbs: data}, function(saveResponse) {
                if (saveResponse.message === 'OK') {
                    $scope.selectedVerbs = $scope.showVerbs(saveResponse.new_verbs);
                    return true;
                }
            });
        };
        $scope.updateURLcheck = function(id, data) {
            if (data === undefined) {
                return "Not a valid URL";
            }
        };
        $scope.allverbs = [];
        $scope.loadVerbs = function() {
            return $scope.allverbs.length ? null : Verbs.query({}, function(data) {
                var updatedVerbs = [];
                data.forEach(function(allverb) {
                    updatedVerbs.push({id: parseInt(allverb.id, 10), verb: allverb.verb});
                });
                $scope.allverbs = updatedVerbs;
            });
        };
        $scope.showVerbs = function(verbs) {
            var planVerbs = [];
            var planVerbIds = [];
            verbs.forEach(function(verb) {
                planVerbs.push(verb.verb);
                planVerbIds.push(parseInt(verb.verb_id, 10));
            });
            $scope.planVerbIds = planVerbIds;
            return planVerbs.length ? planVerbs.join(', ') : 'No Verbs';
        };

        $scope.procStandards = [];
        $scope.loadProcStandards = function() {
            return $scope.procStandards.length ? null : PS.query({}, function(data) {
                $scope.procStandards = data;
            });
        };
        $scope.teks = [];
        $scope.loadTeks = function() {
            return $scope.teks.length ? null : Teks.query({}, function(data) {
                $scope.teks = data;
            });
        };
        $scope.updatePlan = function(data) {
            var update = Plans.update({planId: $scope.plan.id}, data, function(saveResponse) {
                if (saveResponse.message === 'OK') {
                    $scope.plan = saveResponse.plan;
                    // $scope.plan.ps = saveResponse.plan.ps;
                    // $scope.plan.ps_alpha = saveResponse.plan.ps_alpha;
                    // $scope.plan.ps_id = saveResponse.plan.ps_id;
                    // $scope.plan.tek_label = saveResponse.plan.tek_label;

                    return true;
                }
            });
        };

        $scope.deleteConfirm = function() {
            var deleteConfirmModal = $modal.open({
                templateUrl: 'tpl/deleteConfirmModal.html',
                controller: 'DeleteConfirmCtrl',
                resolve: {
                    tek_label: function() {
                        return $scope.plan.tek_label;
                    }
                }
            });

            deleteConfirmModal.result.then(function (confirmation) {
                var delPlan = Plans.deletePlan({planId: $scope.plan.id}, function(delResponse) {
                    Message.prep('newMessage', "Plan deleted");
                    $location.path("/plans");
                });
            }, function () {
                console.log("delete canceled");
            });
        };

        // date picker hack 
        $scope.picker = {opened: false};
        $scope.openpicker = function() {
            $timeout(function() {
                $scope.picker.opened = true;
            });
        };
        $scope.closepicker = function() {
            $timeout(function() {
                $scope.picker.opened = false;
            });
        };

        $scope.$on('newVerb', function() {
            $scope.allverbs = [];
            $scope.loadVerbs();
        });
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
            console.log('form submitted');
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
            payload.proc_standard_id = $scope.plan.ps.id;
            payload.create_d = $filter('date')(new Date(), 'yyyy-MM-dd');

            // extra data
            payload.sections = $scope.plan.sections;
            payload.verb_plan_maps = $scope.plan.verbs;
            payload.resources = $scope.plan.resources;

            // console.log(payload.sections);
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

lpmtControllers.controller('DeleteConfirmCtrl', function($scope, $modalInstance, tek_label) {
    $scope.tek_label = tek_label;
    $scope.deletePlan = function() {
        $modalInstance.close('delete');
    };
    $scope.cancelDelete = function() {
        $modalInstance.dismiss('cancel');
    };
});

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
