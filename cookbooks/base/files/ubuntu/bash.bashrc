###HANDLED BY CHEF

# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
# rvm does not like return in bash files
if [[ -n "$PS1" ]]; then

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  # if the command-not-found package is installed, use it
  if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
    function command_not_found_handle {
            # check because c-n-f could've been removed in the meantime
                  if [ -x /usr/lib/command-not-found ]; then
         /usr/bin/python /usr/lib/command-not-found -- $1
                     return $?
                  elif [ -x /usr/share/command-not-found ]; then
         /usr/bin/python /usr/share/command-not-found -- $1
                     return $?
      else
         return 127
      fi
    }
  fi

fi