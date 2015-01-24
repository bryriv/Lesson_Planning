'use strict';


var lpmtServices = angular.module('lpmtServices', ['ngResource']);

// lpmtServices.factory('Plans', ['$resource',
//     function($resource) {
//         return $resource('http://192.168.1.167/api/plans/:planId');
//     }
// ]);

lpmtServices.factory('Plans', ['$resource',
    function($resource) {
        return $resource('/api/plans/:planId', {}, {
            query: { method: 'GET', isArray: false},
            create: { method: 'POST'},
            update: { method: 'PUT'},
            deletePlan: { method: 'DELETE'}
        });
    }
]);


lpmtServices.factory('Teks', ['$resource',
    function($resource) {
        return $resource('/api/teks/:tekId');
    }
]);

lpmtServices.factory('PS', ['$resource',
    function($resource) {
        return $resource('/api/ps/:psId');
    }
]);

lpmtServices.factory('Verbs', ['$resource',
    function($resource) {
        return $resource('/api/verbs/:verbId', {}, {
            query: { method: 'GET', isArray: true},
            create: { method: 'POST'}
        });
    }
]);

lpmtServices.factory('PlanVerbs', ['$resource',
    function($resource) {
        return $resource('/api/plans/:planId/verbs', {}, {
            query: { method: 'GET', isArray: true},
            update: { method: 'PUT'}
        });
    }
]);

lpmtServices.factory('PlanResources', ['$resource',
    function($resource) {
        return $resource('/api/plans/:planId/resources/:resourceId', {}, {
            query: { method: 'GET', isArray: true},
            update: { method: 'PUT'}
        });

    }
]);

lpmtServices.factory('PlanSections', ['$resource',
    function($resource) {
        return $resource('/api/plans/:planId/sections/:sectionId', {}, {
            query: { method: 'GET', isArray: true},
            update: { method: 'PUT'}
        });
    }
]);

lpmtServices.factory('PlanSectionTypes', ['$resource',
    function($resource) {
        return $resource('/api/section_types', {}, {
            query: { method: 'GET', isArray: true},
        });
    }
]);

lpmtServices.factory('PlanResourceTypes', ['$resource',
    function($resource) {
        return $resource('/api/resource_types', {}, {
            query: { method: 'GET', isArray: true},
        });
    }
]);

lpmtServices.factory('Grades', ['$resource',
    function($resource) {
        return $resource('/api/grades', {}, {
            query: { method: 'GET', isArray: true},
        });
    }
]);

lpmtServices.factory('Links', ['$resource',
    function($resource) {
        return $resource('/api/links/:linkId', {}, {
            query: { method: 'GET', isArray: true},
            create: { method: 'POST'},
            update: { method: 'PUT'},
            deleteLink: { method: 'DELETE'}
        });
    }
]);

lpmtServices.factory("Message", function($rootScope) {
    var appMessage = {};
    appMessage.message = '';
    appMessage.prep = function(event, content) {
        this.message = content;
        this.broadcastMessage(event);
    };
    appMessage.broadcastMessage = function(event) {
        $rootScope.$broadcast(event);
    };
    return appMessage;
});
