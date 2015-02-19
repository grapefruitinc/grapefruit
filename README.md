Grapefruit
==========

### an open source learning portal

Grapefruit is a free and open learning management system for administrators, educators, and students.

We currently support awesome features like lecture videos and notes, a discussion forum, assignments, grading, and much more!

Please consider contributing to the project -
we need your help to accomplish our goal of making the best free education platform possible.


Grapefruit receives support from RCOS (http://rcos.rpi.edu). However, pull requests and collaborations are welcome from anyone!

Installation
------------

*If you are an experienced Rails developer, follow the below steps. If not, please visit `setup.md` to get started.*

1. Go to config and rename database-example.yml to database.yml.

2. Change anything in the config as needed, such as MySQL database names, passwords,
etc. Create the database in question and apply all permissions to the user that will
be accessing it.

3. Copy config/settings-example.yml to config/settings.yml and replace the username and password fields with youtube account information for the master youtube account that holds lecture videos

4. bundle install

5. rake db:migrate

6. *Optional* - Run rake db:seed to add some test seed data

Contributing
------------

Please use 2 spaced-tabs (don't use real tabs, any decent editor
will have an option to replace tabs with spaces).

**The `dev` branch is our main development branch.** If you are working on a new feature, please branch off of `dev` and name your new branch appropriately (e.g. `redesign-masthead`). The `master` branch is reserved for production builds that will be sourced from `dev`. Please DO NOT commit, pull request, or merge to the `master` branch.

We do our best to follow the semantic versioning guidelines outlined at [semver.org](http://semver.org). In the footer of most Grapefruit
pages, we list the platform major, minor, and patch versions, as well as a "build number" (which is really a shortened hash of the current commit).

Help
----

For help with contributing, please contact [Graham Ramsey](mailto:ramseg@rpi.edu) or any member of the Grapefruit core team.
