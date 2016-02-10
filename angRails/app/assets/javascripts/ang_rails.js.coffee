# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@app = angular.module("angRails",["ngResource"]);


@mainCTRL = ["$scope", "$resource", ($scope, $resource) ->

  Entry = $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}})

  $scope.newName = "";

  $scope.entries = Entry.query();


  $scope.addEntry = ->

    unless $scope.newName is ""
      entry = Entry.save($scope.newName)
      $scope.entries.push(entry);
      console.log("add Entry function");
      $scope.newName = "";

]


app.controller("mainCTRL", mainCTRL);
