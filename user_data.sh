#!/bin/bash
##
# Github Authorized Keys Setup
##

# Do not require password for users in sudo group
if  [ -f "/etc/redhat-release" ]; then

  echo '%wheel	ALL=(ALL)	NOPASSWD: ALL' >> /etc/sudoers
  SYNC_USERS_GROUPS=wheel
  SYNC_USERS_GID=500

else

  echo '%sudo  ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/group
  SYNC_USERS_GROUPS=sudo
  SYNC_USERS_GID=1000

fi

if command -v systemctl >/dev/null; then
  SSH_RESTART_TPL="/bin/systemctl restart sshd.service"
else
  SSH_RESTART_TPL="/etc/init.d/sshd restart"
fi

# Create secret file
cat << EOF > /etc/default/github-authorized-keys
GITHUB_API_TOKEN=${github_api_token}
GITHUB_ORGANIZATION=${github_organization}
GITHUB_TEAM=${github_team}
SYNC_USERS_GID=$SYNC_USERS_GID
SYNC_USERS_GROUPS=$SYNC_USERS_GROUPS
SYNC_USERS_SHELL=/bin/bash
SYNC_USERS_ROOT=/
SYNC_USERS_INTERVAL=300
LISTEN=:301
INTEGRATE_SSH=true
LINUX_USER_ADD_TPL="/usr/sbin/useradd --create-home --password '*' --shell {shell} {username}"
LINUX_USER_ADD_WITH_GID_TPL="/usr/sbin/useradd --create-home --password '*' --shell {shell} --group {group} {username}"
LINUX_USER_ADD_TO_GROUP_TPL="/usr/sbin/usermod --append --groups {group} {username}"
LINUX_USER_DEL_TPL="/usr/sbin/userdel {username}"
SSH_RESTART_TPL="$SSH_RESTART_TPL"
AUTHORIZED_KEYS_COMMAND_TPL=/usr/bin/authorized-keys
EOF

if command -v systemctl >/dev/null; then
  /usr/bin/curl -Lso /etc/systemd/system/github-authorized-keys.service https://raw.githubusercontent.com/cloudposse/github-authorized-keys/systemd_init/contrib/github-authorized-keys-non-docker.service
  /usr/bin/systemctl daemon-reload
  /usr/bin/systemctl enable github-authorized-keys.service
  /usr/bin/systemctl start github-authorized-keys.service
else
  /usr/bin/curl -Lso /etc/init.d/github-authorized-keys https://raw.githubusercontent.com/cloudposse/github-authorized-keys/systemd_init/contrib/github-authorized-keys-rhel.initd
  /bin/chmod +x /etc/init.d/github-authorized-keys
  /etc/init.d/github-authorized-keys start
  /sbin/chkconfig github-authorized-keys on
fi
