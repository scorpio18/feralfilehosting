#!/bin/bash
# Install Subsonic
scriptversion="1.8.2"
scriptname="install.subsonic"
subsonicversion="5.0"
javaversion="1.7 Update 67"
jvdecimal="1.7.0_67"
#
# Bobtentpeg 01/30/2013 & randomessence 04/24/2013
#
# * * * * * bash -l ~/bin/subsonicron
#
# wget -qO ~/install.subsonic.sh http://git.io/GBjb3w && bash ~/install.subsonic.sh
#
############################
## Version History Starts ##
############################
#
# See version.txt
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
# Sets a random port between 6000-50000 for http
http=$(shuf -i 6000-49000 -n 1)
# Defines the memory variable
# buffer
submemory="2048"
# Gets the Java version from the last time this script installed Java
installedjavaversion=$(cat ~/.javaversion 2> /dev/null)
# Java URL
javaupdatev="http://javadl.sun.com/webapps/download/AutoDL?BundleId=95116"
# Subsonic Standalone files
subsonicfv="http://downloads.sourceforge.net/project/subsonic/subsonic/5.0/subsonic-5.0-standalone.tar.gz"
subsonicfvs="subsonic-5.0-standalone.tar.gz"
# ffmpeg files
sffmpegfv="https://bitbucket.org/feralhosting/feralfiles/downloads/sonic.ffpmeg.27.09.2014.zip"
sffmpegfvs="sonic.ffpmeg.27.09.2014.zip"
#
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%20and%20Madsonic/scripts/subsonic/install.subsonic.sh"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
mkdir -p "$HOME/bin"
#
if [[ ! -f "$HOME/$scriptname.sh" ]]
then
    wget -qO "$HOME/$scriptname.sh" "$scripturl"
fi
if [[ ! -f "$HOME/bin/$scriptname" ]]
then
    wget -qO "$HOME/bin/$scriptname" "$scripturl"
fi
#
wget -qO "$HOME/000$scriptname.sh" "$scripturl"
#
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/$scriptname.sh" >/dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/$scriptname.sh" "'"$scripturl"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/$scriptname.sh"
    exit 1' > "$HOME/111$scriptname.sh"
    bash "$HOME/111$scriptname.sh"
    exit 1
fi
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/bin/$scriptname" >/dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/$scriptname.sh" "'"$scripturl"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/$scriptname.sh"
    exit 1' > "$HOME/222$scriptname.sh"
    bash "$HOME/222$scriptname.sh"
    exit 1
fi
cd && rm -f {000,111,222}"$scriptname.sh"
chmod -f 700 "$HOME/bin/$scriptname"
#
############################
##### Self Updater End #####
############################
#
############################
#### Core Script Starts ####
############################
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
echo -e "The version of the" "\033[33m""Subsonic""\e[0m" "server being used in this script is:" "\033[31m""$subsonicversion""\e[0m"
echo -e "The version of the" "\033[33m""Java""\e[0m" "being used in this script is:" "\033[31m""$javaversion""\e[0m"
echo
if [[ -f "$HOME/private/subsonic/.version" ]]
then
    echo -e "Your currently installed version is:" "\033[32m""$(sed -n '1p' $HOME/private/subsonic/.version)""\e[0m"
    echo
fi    
#
#############################
#### subsonicrsk starts  ####
#############################
#
# This section MUST be escaped properly using backslash when adding to it. If you need to see it uncommented, run this script in SSH. It will create the working, uncommented version at ~/bin/subsonicrsk
echo -e "#!/bin/bash
if [[ -d ~/private/subsonic ]]
then
    #
    httpport=\$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)
    #
    # v 1.2.0  Kill Start Restart Script generated by the subsonic installer script
    #
    echo
    echo -e \"\\\033[33m1:\\\e[0m This is the process PID:\\\033[32m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m used the last time \\\033[36m~/private/subsonic/subsonic.sh\\\e[0m was started.\"
    echo
    echo -e \"\\\033[33m2:\\\e[0m This is the URL Subsonic is configured to use:\"
    echo
    echo -e \"\\\033[31mSubsonic\\\e[0m last accessible at \\\033[31mhttps://\$(hostname -f)/\$(whoami)/subsonic/\\\e[0m\"
    echo
    echo -e \"\\\033[33m3:\\\e[0m Running instances checks:\"
    echo
    echo -e \"Checking to see, specifically, if the \\\033[32m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m is running\"
    echo -e \"\\\033[32m\"
    if [[ -z \"\$(ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
    then
        echo -e \"Nothing to show.\"
        echo -e \"\\\e[0m\"
    else
        ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
        echo -e \"\\\e[0m\"
    fi
    if [[ \"\$(ps -U \$(whoami) | grep -c java)\" -gt \"1\" ]]
    then
        echo -e \"There are currently \\\033[31m\$(ps -U \$(whoami) | grep -c java 2> /dev/null)\\\e[0m running Java processes.\"
        echo -e \"\\\033[31mWarning:\\\e[0m \\\033[32mSubsonic might not load or be unpredicatable with multiple instances running.\\\e[0m\"
        echo -e \"\\\033[33mIf there are multiple Subsonic processes please use the killall by using option [a] then use the restart option.\\\e[0m\"
        echo -e \"\\\033[31m\"
        ps -U \$(whoami) | grep java
        echo -e \"\\\e[0m\"
    fi
    echo -e \"\\\033[33m4:\\\e[0m Options for killing and restarting Subsonic:\"
    echo
    echo -e \"\\\033[36mKill PID only\\\e[0m \\\033[31m[y]\\\e[0m \\\033[36mKillall java processes\\\e[0m \\\033[31m[a]\\\e[0m \\\033[36mSkip to restart (where you can quit the script)\\\e[0m \\\033[31m[r]\\\e[0m\"
    echo
    read -ep \"Please press one of these options [y] or [a] or [r] and press enter: \"  confirm
    echo
    if [[ \$confirm =~ ^[Yy]\$ ]]
    then
        kill -9 \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) 2> /dev/null
        echo -e \"The process PID:\\\033[31m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m that was started by the installer or custom scripts has been killed.\"
        echo
        echo -e \"Checking to see if the PID:\\\033[32m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m is running:\\\e[0m\"
        echo -e \"\\\033[32m\"
        if [[ -z \"\$(ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
        then
            echo -e \"Nothing to show, job done.\"
            echo -e \"\\\e[0m\"
        else
            ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
            echo -e \"\\\e[0m\"
        fi
    elif [[ \$confirm =~ ^[Aa]\$ ]]
    then
        killall -9 -u \$(whoami) java 2> /dev/null
        echo -e \"\\\033[31mAll java processes have been killed\\\e[0m\"
        echo
        echo -e \"\\\033[33mChecking for open java processes:\\\e[0m\"
        echo -e \"\\\033[32m\"
        if [[ -z \"\$(ps -U \$(whoami) | grep java 2> /dev/null)\" ]]
        then
            echo -e \"Nothing to show, job done.\"
            echo -e \"\\\e[0m\"
        else
            ps -U \$(whoami) | grep java
            echo -e \"\\\e[0m\"
        fi
    else
        echo -e \"Skipping to restart or quit\"
        echo
    fi
    if [[ -f ~/private/subsonic/subsonic.sh ]]
    then
        read -ep \"Would you like to restart subsonic? [r] reload the kill features? [l] or quit the script? [q]: \"  confirm
        echo
        if [[ \$confirm =~ ^[Rr]\$ ]]
        then
            if [[ -z \"\$(ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
            then
                bash ~/private/subsonic/subsonic.sh
                echo -e \"Started Subsonic at PID:\\\033[31m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m\"
                echo
                echo -e \"\\\033[31mSubsonic\\\e[0m last accessible at \\\033[31mhttps://\$(hostname -f)/\$(whoami)/subsonic/\\\e[0m\"
                echo -e \"\\\033[32m\"
                if [[ -z \"\$(ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
                then
                    echo -e \"Nothing to show, job done.\"
                    echo -e \"\\\e[0m\"
                else
                    ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
                    echo -e \"\\\e[0m\"
                fi
                exit 1
            else
                echo -e \"Subsonic with the PID:\\\033[32m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m is already running. Kill it first then restart\"
                echo
                read -ep \"Would you like to restart the RSK script? [y] reload it? [q] or quit the script?: \"  confirmrsk
                echo
                if [[ \$confirmrsk =~ ^[Yy]\$ ]]
                then
                    bash ~/bin/subsonicrsk
                fi
                exit 1
            fi
        elif [[ \$confirm =~ ^[Ll]\$ ]]
        then
            echo -e \"\\\033[31mReloading subsonicrsk to access kill features.\\\e[0m\"
            echo
            bash ~/bin/subsonicrsk
        else
            echo This script has done its job and will now exit.
            echo
            exit 1
        fi
    else
        echo
        echo -e \"The \\\033[31m~/private/subsonic/subsonic.sh\\\e[0m does not exist.\"
        echo -e \"please run the \\\033[31m~/install.subsonic\\\e[0m to install and configure subsonic\"
        exit 1
    fi
else
    echo -e \"Subsonic is not installed\"
fi" > ~/bin/subsonicrsk
#
#############################
##### subsonicrsk ends  #####
#############################
#
#############################
#### subsonicron starts  ####
#############################
#
echo '#!/bin/bash
echo "$(date +"%H:%M on the %d.%m.%y")" >> subsonicrun.log
if [[ -z "$(ps -p $(cat ~/private/subsonic/subsonic.sh.PID) --no-headers)" ]]
then
    bash ~/private/subsonic/subsonic.sh
else
    exit 1
fi' > ~/bin/subsonicron
#
#############################
##### subsonicron ends  #####
#############################
#
# Make the ~/bin/subsonicrsk and ~/bin/subsonicron files we created executable
chmod -f 700 ~/bin/subsonicrsk
chmod -f 700 ~/bin/subsonicron
#
#############################
##### proxypass starts  #####
#############################
#
# Apache proxypass
if [[ -f ~/private/subsonic/subsonic.sh ]]
then
    echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\nInclude /etc/apache2/mods-available/ssl.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\nSSLProxyEngine on\n\nProxyPass /subsonic http://10.0.0.1:'$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)'/${USER}/subsonic\nProxyPassReverse /subsonic http://10.0.0.1:'$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)'/${USER}/subsonic\nRedirect /${USER}/subsonic https://${APACHE_HOSTNAME}/${USER}/subsonic' > "$HOME/.apache2/conf.d/subsonic.conf"
    /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
    # Nginx proxypass
    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
    then
        echo -e 'location /subsonic {\nproxy_set_header        Host            $http_x_host;\nproxy_set_header        X-Real-IP       $remote_addr;\nproxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;\nrewrite /subsonic/(.*) /'$(whoami)'/subsonic/$1 break;\nproxy_pass http://10.0.0.1:'$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)'/'$(whoami)'/subsonic/;\nproxy_redirect http:// https://;\n}' > ~/.nginx/conf.d/000-default-server.d/subsonic.conf
        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
    fi
    echo -e "The" "\033[36m""nginx/apache proxypass""\e[0m" "has been installed."
    echo
    echo -e "Subsonic is accessible at:" "\033[32m""https://$(hostname -f)/$(whoami)/subsonic/""\e[0m"
    echo
fi
#
#############################
###### proxypass ends  ######
#############################
#
echo -e "The" "\033[36m""~/bin/subsonicrsk""\e[0m" "has been updated."
echo
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " -i "y" updatestatus
echo
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
    mkdir -p ~/private
    #
    #############################
    #### Install Java Start  ####
    #############################
    #
    if [[ ! -f ~/bin/java && -f ~/.javaversion ]]
    then
        cd && rm -f ~/.javaversion
        export installedjavaversion=""
    fi
    if [[ "$installedjavaversion" != "$javaversion" ]]
    then
        echo "Please wait a moment while java is installed"
        rm -rf ~/private/java
        wget -qO ~/java.tar.gz "$javaupdatev"
        tar xf ~/java.tar.gz
        cp -rf ~/jre"$jvdecimal"/. "$HOME/"
        rm -f ~/java.tar.gz
        rm -rf ~/jre"$jvdecimal"
        echo -n "$javaversion" > ~/.javaversion
        # we create a custom Java version file for comparison so the installer only runs once
        echo -e "\033[31m""Important:""\e[0m" "Java" "\033[32m""$javaversion""\e[0m" "has been installed to" "\033[36m""$HOME/""\e[0m"
        echo
        echo -e "This Script needs to exit for the Java changes to take effect. Please restart the Script using this command:"
        echo
        echo 'bash ~/bin/install.subsonic'
        echo
        bash
        exit 1
    fi
    #
    #############################
    ##### Install Java End  #####
    #############################
    #
    if [[ ! -d ~/private/subsonic ]]
    then
        echo -e "Congratulations," "\033[31m""Java is installed""\e[0m"". Continuing with the installation."
        sleep 1
        echo
        echo -e "Path" "\033[36m""~/private/subsonic/""\e[0m" "created. Moving to next step."
        mkdir -p ~/sonictmp
        mkdir -p ~/private/subsonic/transcode
        mkdir -p ~/private/subsonic/playlists
        mkdir -p ~/private/subsonic/Podcasts
        # buffer
        # buffer
        # buffer
        echo -n "$subsonicfvs" > ~/private/subsonic/.version
        echo
        echo -e "\033[32m""$subsonicfvs""\e[0m" "Is downloading now."
        wget -qO ~/sonictmp/subsonic.tar.gz "$subsonicfv"
        echo -e "\033[36m""$subsonicfvs""\e[0m" "Has been downloaded and renamed to" "\033[36m""subsonic.tar.gz\e[0m"
        echo -e "\033[36m""subsonic.tar.gz""\e[0m" "Is unpacking now."
        tar xf ~/sonictmp/subsonic.tar.gz -C ~/private/subsonic/
        echo -e "\033[36m""subsonic.tar.gz""\e[0m" "Has been unpacked to" "\033[36m""~/private/subsonic/\e[0m"
        sleep 1
        echo
        echo -e "\033[32m""$sffmpegfvs""\e[0m" "Is downloading now."
        wget -qO ~/sonictmp/ffmpeg.zip "$sffmpegfv"
        echo -e "\033[36m""$sffmpegfvs""\e[0m" "Has been downloaded and renamed to" "\033[36m""ffmpeg.zip\e[0m"
        echo -e "\033[36m""$sffmpegfvs""\e[0m" "Is being unpacked now."
        unzip -qo ~/sonictmp/ffmpeg.zip -d ~/private/subsonic/transcode/
        chmod -f 700 ~/private/subsonic/transcode/{Audioffmpeg,ffmpeg,lame,xmp}
        echo -e "\033[36m""$sffmpegfvs""\e[0m" "Has been unpacked to" "\033[36m~/private/subsonic/transcode/\e[0m"
        rm -rf ~/sonictmp
        sleep 1
        echo
        echo -e "\033[32m""Copying over a local version of lame.""\e[0m"
        # cp -f /usr/local/bin/lame ~/private/subsonic/transcode/ 2> /dev/null
        chmod -f 700 ~/private/subsonic/transcode/lame
        echo -e "Lame copied to" "\033[36m""~/private/subsonic/transcode/\e[0m"
        sleep 1
        echo
        echo -e "\033[32m""Copying over a local version of flac.""\e[0m"
        cp -f /usr/bin/flac ~/private/subsonic/transcode/ 2> /dev/null
        chmod -f 700 ~/private/subsonic/transcode/flac
        echo -e "Flac copied to" "\033[36m""~/private/subsonic/transcode/""\e[0m"
        sleep 1
        echo
        echo -e "\033[31m""Configuring the start-up script.""\e[0m"
        echo -e "\033[35m""User input is required for this next step:""\e[0m"
        echo -e "\033[33m""Note on user input:""\e[0m" "It is OK to use a relative path like:" "\033[33m""~/private/rtorrent/data""\e[0m"
        sed -i 's|SUBSONIC_HOME=/var/subsonic|SUBSONIC_HOME=~/private/subsonic|g' ~/private/subsonic/subsonic.sh
        sed -i "s/SUBSONIC_PORT=4040/SUBSONIC_PORT=$http/g" ~/private/subsonic/subsonic.sh
        sed -i 's|SUBSONIC_CONTEXT_PATH=/|SUBSONIC_CONTEXT_PATH=/$(whoami)/subsonic|g' ~/private/subsonic/subsonic.sh
        # buffer
        sed -i "s/SUBSONIC_MAX_MEMORY=150/SUBSONIC_MAX_MEMORY=$submemory/g" ~/private/subsonic/subsonic.sh
        sed -i '0,/SUBSONIC_PIDFILE=/s|SUBSONIC_PIDFILE=|SUBSONIC_PIDFILE=~/private/subsonic/subsonic.sh.PID|g' ~/private/subsonic/subsonic.sh
        read -ep "Enter the path to your media or leave blank and press enter to skip: " path
        sed -i "s|SUBSONIC_DEFAULT_MUSIC_FOLDER=/var/music|SUBSONIC_DEFAULT_MUSIC_FOLDER=$path|g" ~/private/subsonic/subsonic.sh
        # buffer
        sed -i 's|SUBSONIC_DEFAULT_PODCAST_FOLDER=/var/music/Podcast|SUBSONIC_DEFAULT_PODCAST_FOLDER=~/private/subsonic/Podcast|g' ~/private/subsonic/subsonic.sh
        sed -i 's|SUBSONIC_DEFAULT_PLAYLIST_FOLDER=/var/playlist|SUBSONIC_DEFAULT_PLAYLIST_FOLDER=~/private/subsonic/playlists|g' ~/private/subsonic/subsonic.sh
        # buffer
        sed -i 's/quiet=0/quiet=1/g' ~/private/subsonic/subsonic.sh
        sed -i "22 i export LC_ALL=en_GB.UTF-8\n" ~/private/subsonic/subsonic.sh
        sed -i '22 i export LANG=en_GB.UTF-8' ~/private/subsonic/subsonic.sh
        sed -i '22 i export LANGUAGE=en_GB.UTF-8' ~/private/subsonic/subsonic.sh
        # Apache proxypass
        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\nInclude /etc/apache2/mods-available/ssl.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\nSSLProxyEngine on\n\nProxyPass /subsonic http://10.0.0.1:'"$http"'/${USER}/subsonic\nProxyPassReverse /subsonic http://10.0.0.1:'"$http"'/${USER}/subsonic\nRedirect /${USER}/subsonic https://${APACHE_HOSTNAME}/${USER}/subsonic' > "$HOME/.apache2/conf.d/subsonic.conf"
        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
        echo
        # Nginx proxypass
        if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
        then
            echo -e 'location /subsonic {\nproxy_set_header        Host            $http_x_host;\nproxy_set_header        X-Real-IP       $remote_addr;\nproxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;\nrewrite /subsonic/(.*) /'$(whoami)'/subsonic/$1 break;\nproxy_pass http://10.0.0.1:'"$http"'/'$(whoami)'/subsonic/;\nproxy_redirect http:// https://;\n}' > ~/.nginx/conf.d/000-default-server.d/subsonic.conf
            /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
        fi
        echo -e "\033[31m""Start-up script successfully configured.""\e[0m"
        echo "Executing the start-up script now."
        bash ~/private/subsonic/subsonic.sh
        echo -e "A restart/start/kill script has been created at:" "\033[35m""~/bin/subsonicrsk""\e[0m"
        echo -e "\033[32m""Subsonic is now started, use the links below to access it. Don't forget to set path to FULL path to you music folder in the gui.""\e[0m"
        sleep 1
        echo
        echo -e "Subsonic is accessible at:" "\033[32m""https://$(hostname -f)/$(whoami)/subsonic/""\e[0m"
        echo -e "It may take a minute or two to load properly."
        echo
        echo -e "Subsonic started at PID:" "\033[31m""$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)""\e[0m"
        echo
        bash
        exit 1
    else
        echo -e "\033[31m""Subsonic appears to already be installed.""\e[0m" "Please kill the PID:" "\033[33m""$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)""\e[0m" "if it is running and delete the" "\033[36m""~/private/subsonic directory""\e[0m"
        echo
        read -ep "Would you like me to kill the process and remove the directories for you? [y] or update your installation [u] quit now [q]: "  confirm
        echo
        if [[ "$confirm" =~ ^[Yy]$ ]]
        then
            echo "Killing the process and removing files."
            kill -9 $(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) 2> /dev/null
            echo -e "\033[31m" "Done""\e[0m"
            sleep 1
            echo "Removing ~/private/subsonic"
            rm -rf ~/private/subsonic
            echo -e "\033[31m" "Done""\e[0m"
            sleep 1
            echo "Removing RSK scripts if present."
            rm -f ~/bin/subsonic.4.8
            rm -f ~/subsonic.4.8.sh
            rm -f ~/subsonicstart.sh
            rm -f ~/subsonicrestart.sh
            rm -f ~/subsonickill.sh
            rm -f ~/subsonicrsk.sh
            rm -f ~/bin/subsonicrsk
            rm -f ~/bin/subsonicron
            rm -f ~/.nginx/conf.d/000-default-server.d/subsonic.conf
            rm -f ~/.apache2/conf.d/subsonic.conf
            /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
            /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
            echo -e "\033[31m" "Done""\e[0m"
            sleep 1
            echo "Finalising removal."
            rm -rf ~/private/subsonic
            echo -e "\033[31m" "Done and Done""\e[0m"
            echo
            sleep 1
            read -ep "Would you like you relaunch the installer [y] or quit [q]: "  confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]
            then
                echo
                echo -e "\033[32m" "Relaunching the installer.""\e[0m"
                if [[ -f ~/bin/"$scriptname" ]]
                then
                    bash ~/bin/"$scriptname"
                else
                    wget -qO ~/bin/"$scriptname" "$scripturl"
                    bash ~/bin/"$scriptname"
                fi
            else
                exit 1
            fi
        elif [[ "$confirm" =~ ^[Uu]$ ]]
        then
            echo -e "Subsonic is being updated. This will only take a moment."
            kill -9 $(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) 2> /dev/null
            mkdir -p ~/sonictmp
            wget -qO ~/subsonic.tar.gz "$subsonicfv"
            tar xf ~/subsonic.tar.gz -C ~/sonictmp
            rm -f ~/sonictmp/subsonic.sh
            cp -rf ~/sonictmp/. ~/private/subsonic/
            wget -qO ~/ffmpeg.zip "$sffmpegfv"
            unzip -qo ~/ffmpeg.zip -d ~/private/subsonic/transcode
            chmod -f 700 ~/private/subsonic/transcode/{Audioffmpeg,ffmpeg,lame,xmp}
            echo -n "$subsonicfvs" > ~/private/subsonic/.version
            rm -rf ~/subsonic.tar.gz ~/ffmpeg.zip ~/sonictmp
            sed -i "s|^SUBSONIC_CONTEXT_PATH=/$|SUBSONIC_CONTEXT_PATH=/$(whoami)/subsonic|g" ~/private/subsonic/subsonic.sh
            # Apache proxypass
            echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\nInclude /etc/apache2/mods-available/ssl.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\nSSLProxyEngine on\n\nProxyPass /subsonic http://10.0.0.1:'$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)'/${USER}/subsonic\nProxyPassReverse /subsonic http://10.0.0.1:'$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)'/${USER}/subsonic\nRedirect /${USER}/subsonic https://${APACHE_HOSTNAME}/${USER}/subsonic' > "$HOME/.apache2/conf.d/subsonic.conf"
            /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
            echo
            # Nginx proxypass
            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
            then
                echo -e 'location /subsonic {\nproxy_set_header        Host            $http_x_host;\nproxy_set_header        X-Real-IP       $remote_addr;\nproxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;\nrewrite /subsonic/(.*) /'$(whoami)'/subsonic/$1 break;\nproxy_pass http://10.0.0.1:'$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)'/'$(whoami)'/subsonic/;\nproxy_redirect http:// https://;\n}' > ~/.nginx/conf.d/000-default-server.d/subsonic.conf
                /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
            fi
            bash ~/private/subsonic/subsonic.sh
            echo -e "A restart/start/kill script has been created at:" "\033[35m""~/bin/subsonicrsk""\e[0m"
            echo -e "\033[32m""Subsonic is now started, use the link below to access it. Don't forget to set path to FULL path to you music folder in the gui.""\e[0m"
            sleep 1
            echo
            echo -e "Subsonic is accessible at:" "\033[32m""https://$(hostname -f)/$(whoami)/subsonic/""\e[0m"
            echo -e "It may take a minute or two to load properly."
            echo
            echo -e "Subsonic started at PID:" "\033[31m""$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)""\e[0m"
            echo
            bash
            exit 1
        else
            echo "You chose to quit and exit the script"
            echo
            exit 1
        fi
    fi
#
############################
##### User Script End  #####
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    echo
    exit 1
    cd && bash
fi
#
############################
##### Core Script Ends #####
############################
#