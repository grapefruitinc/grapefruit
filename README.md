Grapefruit
==========

an open source learning portal
------------------------------

* Grapefruit is an RCOS (http://rcos.rpi.edu) project

Installation
------------

1. Go to config and rename database-example.yml to database.yml.

2. Change anything in the config as needed, such as MySQL database names, passwords,
etc. Create the database in question and apply all permissions to the user that will 
be accessing it.

3. Copy config/settings-demo.local.yml to config/settings.local.yml and replace the username and password fields with youtube account information for the master youtube account that holds lecture videos

4. bundle install

5. rake db:migrate

6. (Optional) Run rake db:seed to add some test seed data

Contributing
------------

Please use spaced-tabs (don't use real tabs!! Sublime Text 2 and any decent editor
will have an option to replace tabs with spaces). 2 space tabs please.

Administration
--------------

To make any user account an "admin" account, run the following command after `rake db:migrate` has successfully completed:

  `rake admins:set[admin@email.com]`

Note: If you are using ZSH, be sure to add `alias rake='noglob rake'` to your ~/.zshrc and source it, otherwise the rake task will have an issue with the unquoted string literal