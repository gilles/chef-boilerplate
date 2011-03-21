name "app"
description "ruby app"

#placeholder role
run_list "recipe[application]"

# Attributes applied if the node doesn't have it set already.
default_attributes()

# Attributes applied no matter what the node has set already.
override_attributes()
