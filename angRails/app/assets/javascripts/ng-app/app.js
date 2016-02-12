/*
Created by bb251s on 2/11/2016.
*/

var app = angular.module('angRails', ["ngResource",
        "ngMaterial",
        "ngAria",
        'ngAnimate',
        'ui.router',
        'templates'
    ]);

app.factory('Entry', function($resource){

    return $resource("/entries/:id", {id: "@id"});



  });

app.controller("mainCTRL", function($scope, $resource, Entry, $mdSidenav){


    var reformatDate;

    $scope.newGuest = "";
    $scope.entries = Entry.query();
    $scope.sortByElement = "createdAt";
    $scope.sortReversed = true;
    $scope.nameImageUP = null;
    $scope.dateImageUP = true;
    $scope.hideNameSortImages = true;
    $scope.menu = [
        {
            'title': 'Home',
            'state': 'home'
        }, {
            'title': 'Filter Data',
            'state': 'filterData'
        }
    ];
    var navOpen = false;

    console.log("Reloaded");

    reformatDate = function() {
        var dd, mm, today, yyyy;
        today = new Date;
        dd = today.getDate();
        mm = today.getMonth() + 1;
        yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        today = mm + '/' + dd + '/' + yyyy;
        return today.toString();
    };

    $scope.addEntry = function() {
        var entry;
        if ($scope.newGuest !== "") {
            $scope.newGuest.createdAt = reformatDate();
            entry = Entry.save($scope.newGuest);
            $scope.entries.push(entry);
            console.log("add Entry function");
            console.log(JSON.stringify($scope.newGuest));
            return $scope.newGuest = "";
        }
    };

    $scope.goHome = function() {
        return console.log("Home Page");
    };

    $scope.goSecondPage = function() {
        return console.log("Second Page");
    };

    $scope.filterName = function() {
        $scope.hideNameSortImages = false;
        $scope.sortByElement = "name";
        $scope.sortReversed = !$scope.sortReversed;
        return $scope.nameImageUP = !$scope.nameImageUP;
    };

    $scope.filterDate = function() {
        $scope.hideNameSortImages = true;
        $scope.sortByElement = "createdAt";
        $scope.sortReversed = !$scope.sortReversed;
        return $scope.dateImageUP = !$scope.dateImageUP;
    };

    $scope.navDrawOpen = function(){
        $mdSidenav('left').toggle();
    }


});




    app.config(function ($stateProvider, $urlRouterProvider, $locationProvider) {

        /**
         * Route and States
         */
        $stateProvider
            .state('home', {
                url: '/',
                templateUrl: 'home.html',
                controller: 'mainCTRL'
            })
            .state('filterData',{
                url: '/filterData',
                templateUrl: 'filterData.html',
                controller: 'mainCTRL'
            });

        // default fallback route
        $urlRouterProvider.otherwise('/');

        // enable HTML5 mode for SEO
        $locationProvider.html5Mode({
            enabled: true,
            requireBase: false
        });

    });


