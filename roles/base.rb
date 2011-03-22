name "base"
description "Common Role"

#installs users
run_list "recipe[base]", "recipe[users::sysadmins]", "recipe[sudo]"

# Attributes applied if the node doesn't have it set already.
default_attributes()

# Attributes applied no matter what the node has set already.
override_attributes()
