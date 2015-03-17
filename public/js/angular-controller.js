var todoApp = angular.module("TodoApp", []);

todoApp.controller("TodoListCtrl", function($scope, $http) {
  $http.get('api/todo').success(function(data) {
    $scope.todos = data;
  });
  $scope.submit = function() {
    $http.post('api/todo', {
      title: this.title,
      done: false
    }).
    success(function(data, status, headers, config) {
      // this callback will be called asynchronously
      // when the response is available
      $http.get('api/todo').success(function(data) {
        $scope.todos = data;
      });
    }).
    error(function(data, status, headers, config) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
      alert("failed!");
    });
  };

  $scope.deleteTodo = function(itemID) {
    $http.delete("api/todo/" + itemID, null).success(function(data) {
      $http.get('api/todo').success(function(data) {
        $scope.todos = data;
      });
    });
  };
});
