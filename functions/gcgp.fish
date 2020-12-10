function gcgp --description "git add -A; git commit ...; git push ..."
    echo "commit " $argv[1] " into " $argv[2] " branch"
    command git add -A
    command git commit -am $argv[1]
    command git push origin $argv[2]
end 
