# Grapefruit Development Environment Setup

Hello, thanks for checking out Grapefruit! This guide will list the necessary steps to set up a Grapefruit development environment on your computer. Keep in mind that this is a living document. If you notice an error, would like to make a correction, or want to suggest a tip or process, please don’t hesitate to submit a pull request!

### First things first: Operating Systems

We *strongly* recommend that you develop for Grapefruit using a computer than runs OS X or a Linux distribution. The remainder of this guide will assume that you are running a Unix-based system like a Mac or PC equipped with an Ubuntu flavor. Windows development through Cygwin is likely to be difficult and is not supported at this time.

At this time, developing on Grapefruit is supported on the following operating systems:

- OS X 10.9 Mavericks
- OS X 10.10 Yosemite
- Ubuntu 14.04 Trusty Tahr (or common derivatives)

Note: When you see the turtle ![turtle](http://findicons.com/files/icons/1050/pidgin_old_tango_smilies/24/turtle.png) icon, you might want to step out for a coffee or a healthy snack. Depending on your machine and internet connection, these processes can take a while!

Run terminal commands in Terminal.app on OS X, or 'terminal' on a Linux system.

### 1. Installing Applications & Setting Up the Environment

These apps are recommended, not required (unless otherwise indicated). When testing is not dependent on specific applications (e.g. browser rendering), feel free to use any replacement programs you prefer.

**Browsers**
- Google Chrome (all platforms)
- Firefox (all platforms)
- Safari (OS X only)

**Code Editors**
- [Atom](https://atom.io/) (all platforms, a great open source option!)
- [Sublime Text 3](http://www.sublimetext.com/3) (all platforms)
- On OS X, Xcode's command line tools *must* be installed (this is necessary to work with all of the C libraries that Ruby depends on). If you need help doing this, check out [this StackOverflow answer](http://stackoverflow.com/a/9329325).

**Package Managers**
- On Ubuntu-based Linux distributions, use built-in Aptitude
- On OS X, [Homebrew](http://brew.sh/) is highly recommended

**Shell Tools**

- [ZSH](http://www.zsh.org/) is highly recommended. On OS X, check out [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [TotalTerminal](http://totalterminal.binaryage.com/) provides a great Quake-style terminal experience on OS X

### 2. Install System Dependencies

You will need to install the following system libraries: git, mysql2, libxml2, libxslt, and postgresql.

On OS X, we recommend using homebrew, so installation is as simple as ![turtle](http://findicons.com/files/icons/1050/pidgin_old_tango_smilies/24/turtle.png) `brew install git mysql postgresql libxml2 libxslt` and `brew link libxml2 libxslt`. On Linux, these can be installed with `apt-get install libxslt-dev libxml2-dev mysql-client libmysqlclient-dev`.

While git is perfectly usable just by using the command line, some people prefer graphical clients to aid them in their work. Recommended are [Github for Mac](https://mac.github.com/) and [Github for Windows](https://windows.github.com/). If you are on Linux, or you would like explore other options, check out the [Git GUI client list](http://git-scm.com/downloads/guis) on the Git SCM site.

### 3. Install Ruby

We'll install Ruby first with [RVM](http://rvm.io/rvm/install) (a Ruby version manager). Note: some developers prefer to use [rbenv](https://github.com/sstephenson/rbenv). However, these instructions will give instructions for RVM installations.

Install RVM using the instructions on its website. By running `rvm list known`, you should see a list of various Ruby versions. Under 'MRI Rubies', there should be a stable version listed as `[ruby-]2.1.X`, where X is any number. Let's choose the latest iteration of that version (as of this writing, 2.1.1).

Install that Ruby version using `rvm install`. For example, here is the command to install Ruby 2.1.1:

> ![turtle](http://findicons.com/files/icons/1050/pidgin_old_tango_smilies/24/turtle.png) rvm install 2.1.1

*Trivia: 'MRI' stands for Matz's Ruby Interpreter: [Matz](http://en.wikipedia.org/wiki/Yukihiro_Matsumoto) created the Ruby language!*

To double check that Ruby is installed correctly, open a new terminal window and execute `ruby -v`. You should get a full version stamp for the Ruby currently in use on your system- on mine, it says `ruby 2.1.1p76 (2014-02-24 revision 45161) [x86_64-darwin12.0]`.

### 4. Install Grapefruit and Gems

It is time to download Grapefruit on to your system! We currently host the source code under version control [at Github](https://github.com/grahamcracker/grapefruit). On that page, you should see a link to an "HTTPS clone URL", like https://github.com/grahamcracker/grapefruit.git. Copy the address.

Open a new terminal window, and navigate to the directory where you'd like to install Grapefruit. It doesn't really matter where this is, although placing it somewhere in your home folder is suggested. Run the following command, and remember to paste in the correct repository address:

> git clone https://github.com/grahamcracker/grapefruit.git

This should download a local version of Grapefruit to your system. Now, let's install all of the Ruby gems that Grapefruit depends on. In the same directory, run this command:

> ![turtle](http://findicons.com/files/icons/1050/pidgin_old_tango_smilies/24/turtle.png) bundle install

If this command exits at some point with an error, don't panic! Usually this just indicates a need for a minor modification of your system. The best method to resolve errors is usually to Google the message you get.

Note: some people running OS X have issues installing the Nokogiri gem due to issues installing the libiconv library. If your installation fails with an error message relating to libxml2, libxslt, or libiconv, please follow [the steps outlined on the Nokogiri website](http://nokogiri.org/tutorials/installing_nokogiri.html#homebrew_09).

### 5. Configure the Grapefruit installation

You're almost there! Grapefruit needs a MySQL database created before it can automatically install its schema. First, start MySQL on your machine by running `mysql.server start` on OS X or `sudo service mysql start` on Linux.

Now that MySQL is running, open the MySQL prompt by typing in the following command:

> mysql -u root -p

By doing this, you are logging in as the `root` MySQL user. You will be prompted for a password- by default, the root password is empty, so just hit the enter key.

In the MySQL terminal, create a new database for Grapefruit:

> CREATE DATABASE grapefruit;

You should see a response containing "Query OK", or similar. You can now exit the MySQL prompt by typing in `exit` and hitting enter.

Now we need to tell Grapefruit what our local settings are. Create copies of `config/database-example.yml` (to `database.yml`) and `config/settings-demo.yml` (as `settings.yml`). For now, leave the database settings as default (unless you modified the authentication details) and update the app settings with the Google account Grapefruit will use for video uploads.

Finally, reset the database and get it ready to run Grapefruit by running the following command:

> rake db:reset

**You're ready to go!** Start a local Grapefruit instance by running `rails s` in the same directory. The first time you start the server, it might take a little while.

Happy coding!
