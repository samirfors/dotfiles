ssh-add -K ~/.ssh/id_rsa

set -g fish_color_autosuggestion          555\x1ebrblack
set -g fish_color_cancel                  \x2dr
set -g fish_color_command                 \x2d\x2dbold
set -g fish_color_comment                 red
set -g fish_color_cwd                     green
set -g fish_color_cwd_root                red
set -g fish_color_end                     brmagenta
set -g fish_color_error                   brred
set -g fish_color_escape                  bryellow\x1e\x2d\x2dbold
set -g fish_color_history_current         \x2d\x2dbold
set -g fish_color_host                    normal
set -g fish_color_match                   \x2d\x2dbackground\x3dbrblue
set -g fish_color_normal                  normal
set -g fish_color_operator                bryellow
set -g fish_color_param                   cyan
set -g fish_color_quote                   yellow
set -g fish_color_redirection             brblue
set -g fish_color_search_match            bryellow\x1e\x2d\x2dbackground\x3dbrblack
set -g fish_color_selection               white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set -g fish_color_user                    brgreen
set -g fish_color_valid_path              \x2d\x2dunderline
set -g fish_greeting                      Welcome\x20to\x20fish\x2c\x20the\x20friendly\x20interactive\x20shell
set -g fish_key_bindings                  fish_default_key_bindings
set -g fish_pager_color_completion        \x1d
set -g fish_pager_color_description       B3A06D\x1eyellow
set -g fish_pager_color_prefix            white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set -g fish_pager_color_progress          brwhite\x1e\x2d\x2dbackground\x3dcyan

set -gx PATH /Library/Frameworks/Python.framework/Versions/2.7/bin $PATH
#set -gx PATH /Library/Frameworks/Python.framework/Versions/3.6/bin $PATH
set -gx PATH $PATH $HOME/.dotfiles/bin
set -gx PATH $PATH ./node_modules/.bin

# set -gx ANDROID_HOME /usr/local/opt/android-sdk
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home
set -gx ANDROID_HOME ~/Library/Android/sdk

# Added by n-installer
set -gx N_PREFIX $HOME/n
set -gx PATH $PATH $N_PREFIX/bin
set -gx PATH $PATH $ANDROID_HOME/platform-tools
set -gx PATH $PATH $ANDROID_HOME/tools/bin
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/tools

alias android-studio="open -a /Applications/Android\ Studio.app/"

# Make prompt real nice
function _git_branch_name
  echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (git status -s --ignore-submodules=dirty ^/dev/null)
end

function _unpushed
  echo (git cherry -v "@{upstream}" ^/dev/null)
end

function fish_prompt
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l green (set_color green)
  set -l red (set_color -o red)
  set -l blue (set_color blue)
  set -l magenta (set_color -o magenta)
  set -l normal (set_color normal)

  set -l arrow "$cyan➜"
  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set git_branch $green(_git_branch_name)

    if [ (_is_git_dirty) ]
      set git_branch $red(_git_branch_name)
    end

    set git_info "$blue at $git_branch"

    set -l with_unpushed (_git_branch_name)


    if [ (_unpushed) ]
      set git_info "$git_info$normal with$magenta unpushed"
    end
  end

  echo -n -s \n$cwd $git_info
  echo -e \n$arrow $normal
end

# Run this command to get autocompletion for awscli
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
