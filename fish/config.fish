ssh-add -K ~/.ssh/id_rsa

set -gx PATH /Library/Frameworks/Python.framework/Versions/2.7/bin $PATH
#set -gx PATH /Library/Frameworks/Python.framework/Versions/3.6/bin $PATH
set -gx PATH $PATH $HOME/.dotfiles/bin
set -gx PATH $PATH ./node_modules/.bin

set -gx ANDROID_HOME /usr/local/opt/android-sdk

# Added by n-installer
set -gx N_PREFIX $HOME/n
set -gx PATH $PATH $N_PREFIX/bin

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
