#!/usr/bin/env bash

# Enables source operations across an organization.
#   Note: platform admin access required to run this script.

ORGANIZATION=drupal-agency
PROJECTS_LIST=$(platform project:list -o $ORGANIZATION --pipe)
PROJECTS=($PROJECTS_LIST)

for PROJECT in "${PROJECTS[@]}"
do
    printf "\nEnabling source operations on project $PROJECT:\n"
    RESPONSE=$(platform project:curl -X PATCH capabilities -d '{"source_operations": {"enabled": true}}' -p $PROJECT)
    echo $RESPONSE | jq -r '.status'
done



# This organization
#   - There are things that must be identical across all projects
#   - And other things that must be unique per project
#   - There is a 'default' policy, then overrides
# Policies
#   - Code/infrustructure
#       - Shares this common codebase
#       - These project variables
#       - These consistent environments
#       - These consistent environment variables
#       - These access controls
#   - Resources
#       - These plan settings/resources
#       - These metrics monitoring strategies
#   - Notifications
#       - These notification integrations
#   - Tests
#   - Data
#       - Backup strategies
#       - Restoration strategies
#   - Traffic/routing
#       - Traffic analysis
#       - Caching strategies
#   - Security
#       - access monitoring
#   - These observability integrations
#   - These log forwarding settings/integrations
# 