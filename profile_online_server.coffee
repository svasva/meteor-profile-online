Meteor.methods
  _goOffline: ->
    return false unless @userId
    Meteor.users.update @userId, $set: {'profile.online': false}
    Meteor._onLogout?(@userId)
  _keepAlive: (params) ->
    userInterval = config?.keepalive?.interval ? 60
    userTimeout = config?.keepalive?.timeout ? 10
    return false unless @userId
    Meteor._keepalive ?= {}
    Meteor.clearTimeout Meteor._keepalive[@userId] if Meteor._keepalive[@userId]
    (setOnline = (online) =>
      user = Meteor.users.findOne(@userId)
      unless user?.profile?.online is online
        Meteor.users.update user._id, $set: {'profile.online': online}
        if online then Meteor._onLogin?(user._id)
        else Meteor._onLogout?(user._id)
    )(true)
    Meteor._keepalive[@userId] = Meteor.setTimeout (=>
      delete Meteor._keepalive[@userId]
      setOnline(false)
    ), (userInterval + userTimeout) * 1000
    return true
