if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR nvim 
    set -gx XDG_CONFIG_HOME ~/.config
    set -gx PAGER less
    starship init fish | source
    zoxide init fish | source
    thefuck --alias | source
end
