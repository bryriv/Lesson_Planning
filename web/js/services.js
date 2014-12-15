'use strict';


var lpmtServices = angular.module('lpmtServices', ['ngResource']);

lpmtServices.factory('Plans', ['$resource',
    function($resource) {
        return $resource('http://192.168.1.167/api/plans/:planId');
    }
]);

lpmtServices.factory('Teks', ['$resource',
    function($resource) {
        return $resource('http://192.168.1.167/api/teks/:tekId');
    }
]);
