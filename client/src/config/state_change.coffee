angular.module('client').run [
  '$rootScope','$location','$state','$window','$http','Session','Auth','PollConfig', ($rootScope,$location,$state,$window,$http,Session,Auth,PollConfig) ->

    PollConfig.cancel()
    $rootScope.checkPermission =(code,access)->
      Auth.checkPermission(code,access)

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      $rootScope.bodyClass = ""
      PollConfig.cancel()


]
