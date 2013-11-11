# Grapefruit
### an open source learning portal

* Grapefruit is an RCOS (http://rcos.rpi.edu) project *

### Installation
Go to config and rename database-example.yml to database.yml
Change anything in the config as needed, such as MySQL database names, passwords,
etc. Create the database in question and apply all permissions to the user that will 
be accessing it.
bundle install
rake db:migrate