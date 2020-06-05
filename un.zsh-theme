# VCS
UN_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
UN_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
UN_VCS_PROMPT_SUFFIX="%{$reset_color%}"
UN_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
UN_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${UN_VCS_PROMPT_PREFIX1}git${UN_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$UN_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$UN_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$UN_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(un_hg_prompt_info)'
un_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${UN_VCS_PROMPT_PREFIX1}hg${UN_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$UN_VCS_PROMPT_DIRTY"
		else
			echo -n "$UN_VCS_PROMPT_CLEAN"
		fi
		echo -n "$UN_VCS_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % un @ un-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
 \
%{$fg[white]%}[%*] $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
