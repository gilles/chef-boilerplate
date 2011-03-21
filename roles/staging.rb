name "production"
description "Sets production attributes"

#always install users
run_list "role[base]"

# Attributes applied if the node doesn't have it set already.
default_attributes()

# Attributes applied no matter what the node has set already.
#the app_environment is used by munin, it MUST have the same value as the role name
override_attributes :app_environment => "staging"
