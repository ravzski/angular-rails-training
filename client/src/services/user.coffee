module = ($resource)->

  User = $resource "/api/users/:id", {id: "@id"},
    {
      update:
        method: 'PUT'
      getList:
        url: "/api/users"
        method: 'get'
        isArray: false
    }

  User

module.$inject = ['$resource']
angular.module('client').factory('User', module)
