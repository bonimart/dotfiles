if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR nvim 
    set -gx XDG_CONFIG_HOME ~/.config
    set -gx PAGER less
    starship init fish | source
    # zoxide init fish | source
end
# source /etc/profile with bash
if status is-login
    if not set -q __sourced_profile
        set -x __sourced_profile 1
        exec zsh -c "\
            test -e /etc/profile && source /etc/profile
            test -e $HOME/.zprofile && source $HOME/.zprofile
            exec fish --login
        "
    end
    
    # put your other configs below
    
    #
    
    set -e __sourced_profile
end
