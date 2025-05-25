if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx EDITOR nvim 
    set -gx XDG_CONFIG_HOME ~/.config
    set -gx PAGER less
    starship init fish | source
    zoxide init fish | source
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
# git aliases
abbr gst 'git status'
abbr ga 'git add'
abbr gc 'git commit'
abbr gb 'git branch'
abbr gco 'git checkout'
abbr gcb 'git checkout -b'
abbr gd 'git diff'
abbr gl 'git log'
abbr glo 'git log --oneline --graph --decorate'
abbr gp 'git push'
abbr gl 'git pull'
alias grep rg
alias cd z
