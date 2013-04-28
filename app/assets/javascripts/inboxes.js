app = angular.module('Hermes', []);

function InboxCtrl($scope, $http) {
  // setup
    //when the inbox ID is received from the ng-init in the view
    $scope.$watch('$scope.inboxId != 0',function(){
      //populate the messages array from the server
      $http({method:'GET',url:'/pull?inbox='+$scope.inboxId,cache:false}).success(function(data,status){
        $scope.messages = data;
        //set the first message as cursored
        $scope.cursoredMessage = 0;
        updateCursor(-2);
      });
    });

  function updateCursor(direction){
    //if cursor update is relative...
    // -3: down one, -2: update in place, -1: up one
    if (direction < 1) {
      newCursoredMessage = $scope.cursoredMessage+2+direction;
    }
    //otherwise it's absolute...
    else {
      newCursoredMessage = direction
    }
    // apply new cursor position if valid
    if (-1 < newCursoredMessage && newCursoredMessage < $scope.messages.length) {
      $scope.cursoredMessage = newCursoredMessage;
      $scope.$digest();
    }
  }

  // monitor keypresses
  $(document).ready(function(){
    $('html').keypress(function(e){
      //allow letters through if input is focus
      if ($(e.target).is('input')) { return true; }
      else {
        console.log(e);
        e.preventDefault();
        // down key j
        if (e.which == 106) {
          updateCursor(-3);
        }
        // up key k
        if (e.which == 107) {
          updateCursor(-1);
        }
        // resolve key e
        if (e.which == 101){
          $http({method:'GET',url:'/resolve_message?id='+$scope.messages[$scope.cursoredMessage].id,cache:false}).success(function(data,status){
            $scope.messages.splice($scope.cursoredMessage,1);
            updateCursor(-2);
          });
        }
        // command dialog toggle a
        if (e.which == 97) {
          $('div#command').modal("toggle");
          window.setTimeout(function(){
            $('div#command input').focus();
          },400);
        }
      }
    });
  });
}