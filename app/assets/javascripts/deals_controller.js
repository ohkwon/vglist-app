(function() {
  "use strict";
  angular.module("app").controller("dealsCtrl", function($scope) {

    $scope.platformCount = 1;
    var counts = [];

    $scope.loopCount = function(num) {
      counts = [];
      $scope.platformCount = num;
      for (var i = 0; i < $scope.platformCount; i++) {
        counts.push(i+1);
      }
      return $scope.counts;
    }

  });
})();