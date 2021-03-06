module = ($resource,Session)->
  user = null
  {
    getUser: ->
      return user
    setUser: (obj) ->
      user = obj
      return
    removeUser: ->
      user = null
      localStorage.removeItem("access_token")
      localStorage.removeItem("user_id")
      return
    uploadCreds: (id)->
      tmp=
        access_token: localStorage.getItem('access_token')
        user_id: user.id
        ref_id: id
    checkPermission: (code,access)->
      return true if user.super_admin
      module_permission = user.permissions[code]
      !!module_permission && access in module_permission

  }



module.$inject = ['$resource','Session']
angular.module('client').factory('Auth', module)
