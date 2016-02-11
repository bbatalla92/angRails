
###
app = angular.module("angRails",["ngResource", "ngMaterial", "ngAnimate", "ngAria"]);

app.factory 'Entry', ['$resource', ($resource) ->

  $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}})
]
###
