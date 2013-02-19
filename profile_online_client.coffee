Meteor.__original_logout = Meteor.logout
Meteor.logout = ->
  Meteor.users.update Meteor.userId(), $set: {'profile.online': false}
  Meteor.__original_logout()
Meteor.autorun ->
  userInterval = config?.keepalive?.interval ? 60
  (update = -> Meteor.call('keepalive') if Meteor.userId())()
  Meteor.clearInterval(Meteor.keepalive) if Meteor.keepalive?
  Meteor.keepalive = Meteor.setInterval(update, userInterval * 1000)
