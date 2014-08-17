Grapefruit
==========

### an open source learning portal

Grapefruit is an RCOS (http://rcos.rpi.edu) project. However, pull requests are always welcome from anyone!

Installation
------------

*If you are an experienced Rails developer, follow the below steps. If not, please visit `setup.md` to get started.*

1. Go to config and rename database-example.yml to database.yml.

2. Change anything in the config as needed, such as MySQL database names, passwords,
etc. Create the database in question and apply all permissions to the user that will
be accessing it.

3. Copy config/settings-demo.yml to config/settings.yml and replace the username and password fields with youtube account information for the master youtube account that holds lecture videos

4. bundle install

5. rake db:migrate

6. *Optional* - Run rake db:seed to add some test seed data

Contributing
------------

Please use 2 spaced-tabs (don't use real tabs, any decent editor
will have an option to replace tabs with spaces).

The `dev` branch is our main development branch. If you are working on a new feature, please branch off of `dev` and name your new branch appropriately (e.g. `redesign-masthead`). The `master` branch is reserved for production builds that will be sourced from `dev`. Please DO NOT commit, pull request, or merge to the `master` branch.

Help
----

For help with contributing, please contact [Graham Ramsey](mailto:ramseg@rpi.edu) or any member of the Grapefruit core team.
