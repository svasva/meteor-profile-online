Package.describe({
  summary: "Add and auto-update profile.online field to users collection."
});

Package.on_use(function(api) {
  api.use(['accounts-base', 'coffeescript'], ['client','server']);
  api.add_files('profile_online_server.coffee', 'server');
  api.add_files('profile_online_client.coffee', 'client');
});

