Meteor.__original_logout = Meteor.logout
Meteor.logout = (callback) ->
  Meteor.call('_goOffline')
  Meteor.__original_logout(callback)

Meteor.startup ->
  Deps.autorun ->
    return false unless userId = Meteor.userId()
    userInterval = config?.keepalive?.interval ? 60
    (update = -> Meteor.call('_keepAlive') if userId)()
    Meteor.clearInterval(Meteor._keepalive) if Meteor._keepalive?
    Meteor._keepalive = Meteor.setInterval(update, userInterval * 1000)
