# DD7

This is a Drupal7 + Drush hosting environemnt created entirely in Docker.

The goal of this project is to create the most simple environment possible
using purely docker concepts - no custom scripting specific to Drupal.

Since we are using "pure Docker" we can presume the following is true:

- Works on Linux ✓
- Works on MacOS ✓
- Works on Microsoft Windows ✓

It should work anywhere the Docker daemon can run.

## This project is opinionated!

You are going to get PHP 7 and MySQL, running on Apache. If you want Nginx, run
it in front of this package, or modify this package to suit your own needs.

By keeping things simple we gain the following benefits:

- Automatic provisioning ✓
- No custom scripts ✓
- Quick setup - no decision paralysis about what to use ✓

## How to Use

Before you begin you must have `docker` installed on your computer. If you are
using Linux you will also need `docker-compose`.

The configuration is contained in the docker-compose.yml file.

Before you run `docker-compose up` in this folder you will want to do the
following:

1. Put your Drupal site (code base) in the `repo` folder. The entire code base,
the core files and any modules and themes you have.

2. If you have settings.php customizations check the `settings` folder. That
folder is mounted as a "volume" over top of whatever your repo/sites/default
folder has in it.

    The provided settings/settings.php file has the database settings pre-populated at the bottom of the file.

    It uses the default connection values (databse host:
"db", name: "dd7", user: "dd7", pass: "dd7").

3. Your files should be unzipped into the `files` folder.

    For 1, 2, and 3, if you are on Linux or MacOS you may use symlinks to point to
    folders that exist somewhere else. On Windows perhaps you can use WSL symlinks,
    but that is up to you to research and figure out if you want to do things that
    way.

4. Finally, you will need to put a copy of your database into the `sql` folder,
USING THE NAME dd7.sql.gz, if gzipped, or dd7.sql if not gzipped.

    Yes, if you are wondering, you may put additional files and they will be
auto-imported as well. Check the MySQL docker image documentation for details.

5. Now you are ready to `docker-compose up`!

## Working with your site

In order to connect to the site you will need to know it's IP address or port
number. In Windows or MacOS you may have a menu to do this, but you can always
go to the terminal and run `docker ps` to see a listing. Find the dd7 image you
are running in the list and note the port number.

### Access using port number

You will use localhost:port as the address, the port number will be listed in
the `docker ps` output. If the port was listed as 35555, for example, you could
use http://localhost:35555 to access the container.

### Access using IP address

You can alternatively grab the name of the container in the last column of
output to do `docker inspect <name>` where the <name> is the auto-generated tag
assigned to the container. Near the bottom of the output you will see the IP
address listed there. You can use that in your browser.

### Using Drush

In order to run drush commands you must enter the container. On the command
line you could do it using the name found in `docker ps` doing the following:

`docker exec -ti <name> /bin/bash` where <name> is the container name presented
in the `docker ps` listing while your `docker-compose up` is running.

### Managing the site using VS Code's Docker plugin

If you happen to use Microsoft's Visual Studio Code as your editor, you may
install the Docker plugin and find the running DD7 container in the list of
containers.

#### Drush

When you see the DD7 container you are interested in, right-click, and "Attach
terminal". You will see a new terminal with the path `/var/www/html`... this is
your repo's location inside the container. You can type any drush command here.

#### Browser

You can also use VS Code's right-click menu to "open in browser" and that will
load the localhost:port URL into your browser.

## Learning more about Docker

I often cite "TheDockerBook" as a good resource for learning Docker. I have no
affiliation with the author but it is a quick and focused read that will help
you understand what to focus on if you are learning to manage a docker
environment. After reading that book using this project should hopefully be a
piece of cake.

## About the Author

This package was created by Ryan Weal.
