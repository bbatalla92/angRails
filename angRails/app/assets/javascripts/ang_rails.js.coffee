###
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("angRails",["ngResource", "ngMaterial", "ngAnimate", "ngAria",'ui.router','templates']);

app.factory 'Entry', ['$resource', ($resource) ->

  entries = $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}});

]


app.config(['$stateProvider',"$urlRouterProvider","$locationProvider" , ($stateProvider, $urlRouterProvider, $locationProvider) ->

      $stateProvider.state( 'home',
        url: '/',
        templateURL: "home.html",
        controller: "mainCTRL"
      ).state('filterData',
        url: '/filterData',
        templateURL: "filterData.html",
        controller: "mainCTRL"
      );

      $urlRouterProvider.otherwise '/'


      $locationProvider.html5Mode
        enabled: true
        requireBase: false
  ])



@mainCTRL = ["$scope", 'Entry','$resource', ($scope, Entry, $resource) ->


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
     },
     {
       'title': 'Filter Data',
       'state': 'filterData'
     }
   ];

  console.log("Reloaded");

  reformatDate = ->
    today = new Date
    dd = today.getDate()
    #The value returned by getMonth is an integer between 0 and 11, referring 0 to January, 1 to February, and so on.
    mm = today.getMonth() + 1
    yyyy = today.getFullYear()
    if dd < 10
      dd = '0' + dd
    if mm < 10
      mm = '0' + mm
    today = mm + '/' + dd + '/' + yyyy
    today.toString()


  $scope.addEntry = ->
    unless $scope.newGuest is ""
      $scope.newGuest.createdAt = reformatDate();
      entry = Entry.save($scope.newGuest);
      $scope.entries.push(entry);
      console.log("add Entry function");
      console.log(JSON.stringify($scope.newGuest));
      $scope.newGuest = "";

  $scope.goHome = ->
    console.log("Home Page");
    #$resource("/secondPage");

  $scope.goSecondPage = ->
    console.log("Second Page");

  $scope.filterName = ->
    $scope.hideNameSortImages = false
    $scope.sortByElement = "name";
    $scope.sortReversed = !$scope.sortReversed
    $scope.nameImageUP = !$scope.nameImageUP;

  $scope.filterDate = ->
    $scope.hideNameSortImages = true
    $scope.sortByElement = "createdAt";
    $scope.sortReversed = !$scope.sortReversed
    $scope.dateImageUP = !$scope.dateImageUP;



  # Functions above and instantiations up top, logic below

]


app.controller("mainCTRL", mainCTRL);

###
