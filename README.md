# profile.online

Profile.online is a [meteor](http://meteor.com) smart package to
provide a convenient way to expose accounts online status.


## Installation

Publish with relations can be installed with 
[Meteorite](https://github.com/oortcloud/meteorite/).
From inside a Meteorite-managed app:

``` sh
$ mrt add profile-online
```

## API

There is nothing you have to do to get this package working.
Install it, sign in to your application and you will get
your ```profile.online``` field set to ```true```. Log out,
and it goes ```false```.

You can use Meteor._onLogin and Meteor._onLogout callbacks
server-side to do stuff when users comes in and out.
Example:
```javascript
Meteor._onLogin  = function (userId) { console.log(userId + "just logged in.") }
Meteor._onLogout = function (userId) { console.log(userId + "just logged out.") }
```

## Configuring

There are two global variables this SmartPackage rely at:
- ```config.keepalive.interval``` (defaults to ```60```)
- ```config.keepalive.timeout``` (defaults to ```10```)

It is not necessary to set them up if you don't want to change
the default values.

## How it works

On the client, there is a reactive function that calls
```Meteor.keepalive``` method on user sign in and every
60 seconds after that. On the server, the ```Meteor.keepalive```
method sets user ```profile.online``` field to ```true```
and sets a timer to 70 seconds which will set ```profile.online```
to ```false```. The timer is reset on each ```Meteor.keepalive```
method call. There is also a function that overrides ```Meteor.logout```
method to set user's ```profile.online``` to ```false``` when he
logs out.
