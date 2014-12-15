'use strict';


var lpmtServices = angular.module('lpmtServices', ['ngResource']);

// lpmtServices.factory('Plans', ['$resource',
//     function($resource) {
//         return $resource('http://192.168.1.167/api/plans/:planId');
//     }
// ]);

lpmtServices.factory('Plans', ['$resource',
    function($resource) {
        return $resource('http://192.168.1.167/api/plans/:planId', {}, {
            query: { method: 'GET', isArray: true},
            create: { method: 'POST'}
        });
    }
]);


lpmtServices.factory('Teks', ['$resource',
    function($resource) {
        return $resource('http://192.168.1.167/api/teks/:tekId');
    }
]);

lpmtServices.factory('PS', ['$resource',
    function($resource) {
        return $resource('http://192.168.1.167/api/ps/:psId');
    }
]);

lpmtServices.factory('Verbs', ['$resource',
    function($resource) {
        return $resource('http://192.168.1.167/api/verbs/:verbId');
    }
]);