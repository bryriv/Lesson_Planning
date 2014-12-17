'use strict';

var lpmtFilters = angular.module('lpmtFilters', []);

lpmtFilters.filter('capitalize', function() {
    return function(input, scope) {
        if(input!=null) {
            return input.substring(0,1).toUpperCase()+input.substring(1);
        }
    };
});

lpmtFilters.filter('dateToISO', function() {
    return function(input) {
        if(input!=null) {
            input = '2014-12-15T00:34:39';
            input = new Date(input);
            input = input.toISOString();
            return input;
        }
    };
});

lpmtFilters.filter('lineBreak', function($sce){
    return function(msg) { 
        var msg = (msg + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1'+ '<br>' +'$2');
        return $sce.trustAsHtml(msg);
    }
});