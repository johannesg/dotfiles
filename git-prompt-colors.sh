# This is an alternative approach. Single line in git repo.
override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"

  GIT_PROMPT_COMMAND_FAIL="${Red}✘"
  GIT_PROMPT_START_USER="[${BoldYellow}${PathShort}${ResetColor}]"
  GIT_PROMPT_END_USER="${ResetColor} $ "
  GIT_PROMPT_END_ROOT="${BoldRed} # "
}

reload_git_prompt_colors "Custom"
