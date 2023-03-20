# Description
This project is an example of a private CPAN mirror with Docker and NGINX where you can list specific modules to mirror in the `modules.txt` file. 

# How To Use
First, make sure [Docker](https://www.docker.com/) is installed on your host system. 

Next, clone this repo.

*Optionally, you can modify `modules.txt` to only include modules from [CPAN](https://www.cpan.org/modules/index.html) that you'd like to mirror.*

Third, make sure the `run.sh` file has appropriate execution permissions (`chmod +x ./run.sh`), and then run the command `./run.sh` within the cloned directory.

Finally, once the Docker container is up and running, you should now be able to install Perl modules using it as the source. For example, run the command to install a Perl module hosted within the Docker container: `sudo cpanm --mirror http://localhost/ Mojolicious`

# Customize
If you would like to edit what modules are stored on the Docker CPAN mirror, just modify the `modules.txt` file, and re-run `./run.sh` from within the repo directory.