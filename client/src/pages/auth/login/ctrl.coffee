Ctrl = ($scope,$state,Session,growl,$http,Auth)->

  $scope.uiState =
    loading: false

  if !!localStorage.getItem('access_token')
    $state.go(DEFAULT_AUTH_STATE)
  else
    $scope.showLogin = true

  $scope.login =(email,password,remember)->
    $scope.uiState.loading = true
    Session.login(credentials: {email: email, password: password}).$promise
      .then (data) ->
        Auth.setUser(data)
        Session.setSession(data)
        Session.setHeaders(data)
        growl.success(MESSAGES.LOGIN_SUCCESS)
        $state.go(DEFAULT_AUTH_STATE)
      .finally ->
        $scope.ctrl.loading = false


Ctrl.$inject = ['$scope','$state','Session','growl','$http','Auth']
angular.module('client').controller('LoginCtrl', Ctrl)
