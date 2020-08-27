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

0. Clone this repo. We recommend you give it a name based on whatever *your*
project is about. The name will be used to distinguish which container you are
running when you start to have lots of projects.

    Here is an example using Github's HTTPs URL to clone a project and call it `<my-project>`:
    `git clone https://github.com/kafeisystems/dd7.git <my-project>`

1. Create a subfolder inside this folder called `repo` with your project's code
base. The entire *code* base, the Drupal/Backdrop core files and any modules and
themes you have.

2. Create another subfolder inside this folder called `files`. Put the contents of your
sites/default/files folder in here.

3. If you have settings.php customizations check the `settings` folder. That
folder is mounted as a "volume" over top of whatever your repo/sites/default
folder has in it.

    The provided settings/settings.php file has the database settings pre-populated at the bottom of the file.

    It uses the default connection values (databse host:
"db", name: "dd7", user: "dd7", pass: "dd7").

4. Your files should be unzipped into the `files` folder.

    For 1, 2, 3, and 4, if you are on Linux or MacOS you may use symlinks to
point to folders that exist somewhere else. On Windows perhaps you can use WSL
symlinks, but that is up to you to research and figure out if you want to do
things that way.

4. Finally, you will need to put a copy of your database into the `sql` folder,
USING THE NAME dd7.sql.gz, if gzipped, or dd7.sql if not gzipped.

    Yes, if you are wondering, you may put additional files and they will be
auto-imported as well into a database resembling the name of the file. You
would use the same credentials for the other databases. Check the MySQL docker
image documentation for additional details.

5. Now you are ready to `docker-compose up`!

    The first time the database container starts up it "should" take a long
time as it needs to import the dd7.sql.gz file. If you see it "stuck" on that
step - that is good! Wait until it gets past that and you should be good to go.

    You can now begin editing files in your `repo` folder to do your work. When
you need to run commands in the container use the instructions below to connect
to it and run `drush` commands from in the `dd7` container.

6. To stop the containers, press `Control-C` in the terminal where
`docker-compose` is running. To REMOVE the containers, or to force a reload of
a fresh DB next time, use `docker-compose down`.

## Working with your site

In order to connect to the site you will need to know it's IP address or port
number. In Windows or MacOS you may have a menu to do this, but you can always
go to the terminal and run `docker ps` to see a listing. Find the dd7 image you
are running in the list and note the port number.

### Using the command line

You will use `localhost:<port>` as the address, the port number will be listed in
the `docker ps` output. If the port was listed as 35555, for example, you could
use http://localhost:35555 to access the container.

You can alternatively grab the name of the container in the last column of
output to do `docker inspect <name>` where the `<name>` is the auto-generated
tag assigned to the container. Near the bottom of the output you will see the
IP address listed there. You can use that in your browser.

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

## Some additional notes about Drush

All drush commands, such as `drush cc all` should work fine once you are
attached to the dd7 container as described above.

Keep in mind when using `drush uli` that the first part of the URL is going to
be wrong, it will say `http://default` because it doesn't know what hostname
you are currently using. So open the site in a browser first, and then paste
everything after `http://default` when using `drush uli`.

## Learning more about Docker

I often cite "TheDockerBook" as a good resource for learning Docker. I have no
affiliation with the author but it is a quick and focused read that will help
you understand what to focus on if you are learning to manage a docker
environment. After reading that book using this project should hopefully be a
piece of cake.

## About the Author

This package was created by Ryan Weal.
