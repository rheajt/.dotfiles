function new-gs
    echo "scripts dir"
    cd ~/Projects/scripts

    command mkdir $argv
    command gh repo create -p typescript-react-clasp-template $argv

    echo "get in there!"
    cd $argv

    echo "git pull"
    command git pull origin master

    echo "npm install"
    command npm install
end
