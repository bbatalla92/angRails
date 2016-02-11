# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("angRails",["ngResource", "ngMaterial", "ngAnimate", "ngAria"]);

app.factory 'Entry', ['$resource', ($resource) ->

  entries = $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}});

]




@mainCTRL = ["$scope", 'Entry', ($scope, Entry) ->

  ###Entry = $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}})###

  $scope.newGuest = "";
  $scope.entries = Entry.query();



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


  deleteNulls = ->
    console.log("hi")
    for items in $scope.entries
      console.log(items.name)

  $scope.addEntry = ->
    unless $scope.newGuest is ""
      $scope.newGuest.createdAt = reformatDate();
      entry = Entry.save($scope.newGuest);
      $scope.entries.push(entry);
      console.log("add Entry function");
      console.log(JSON.stringify($scope.newGuest));
      $scope.newGuest = "";




  # Functions above and instantiations up top, logic below

  deleteNulls()
]

app.controller("mainCTRL", mainCTRL);

