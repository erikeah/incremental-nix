intermediatesHook() {
    local red='\033[0;31m'
    local no_color='\033[0m'

    local errorCounter=0

    if [ -z "$requestedIntermediates" ]; then
        ((errorCounter++))
        echo -e "${red}intermediatesHook failed to set intermediates because requestedIntermediates variable has not been set.${no_color}" > /dev/stderr
        echo -e 'hint: try to declare `env = { inherit requestedIntermediates; }`.' > /dev/stderr
    fi
    if [ -z "$intermediates" ]; then
        ((errorCounter++))
        echo -e "${red}intermediatesHook failed to set intermediates because intermediates output variable has not been set.${no_color}" > /dev/stderr
        echo -e 'hint: try to add "intermediates" to your package outputs.' > /dev/stderr
    fi
    if [ "0" -eq "$errorCounter" ]; then
        cp -r $requestedIntermediates $intermediates
        find $intermediates -exec chmod u+w {} +
        find $intermediates -exec touch -d '1970-01-01T00:00:00Z' {} +
    else
        exit $errorCounter
    fi
}

preBuildHooks+=(intermediatesHook)
