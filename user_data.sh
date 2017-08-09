##
# Github Authorized Keys Setup
##

# Do not require password for users in sudo group 
echo '%sudo  ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/group

mkdir /etc/secrets
chmod 700 /etc/secrets
cat <<"__EOF__" > /etc/secrets/github-authorized-keys
GITHUB_API_TOKEN=${github_api_token}
GITHUB_ORGANIZATION=${github_organization}
GITHUB_TEAM=${github_team}
SYNC_USERS_GID=500
SYNC_USERS_GROUPS=sudo
SYNC_USERS_SHELL=/bin/bash
SYNC_USERS_ROOT=/
SYNC_USERS_INTERVAL=300
LISTEN=:301
INTEGRATE_SSH=true
LINUX_USER_ADD_TPL=/usr/sbin/useradd --create-home --password '*' --shell {shell} {username}
LINUX_USER_ADD_WITH_GID_TPL=/usr/sbin/useradd --create-home --password '*' --shell {shell} --group {group} {username}
LINUX_USER_ADD_TO_GROUP_TPL=/usr/sbin/usermod --append --groups {group} {username}
LINUX_USER_DEL_TPL=/usr/sbin/userdel {username}
SSH_RESTART_TPL=/bin/systemctl restart sshd.service
AUTHORIZED_KEYS_COMMAND_TPL=/usr/bin/authorized-keys
__EOF__

cat <<"__EOF__" > /etc/systemd/system/github-authorized-keys.service
[Unit]
Description=GitHub Authorized Keys

Requires=network-online.target
After=network-online.target

[Service]
User=root
TimeoutStartSec=0
EnvironmentFile=/etc/secrets/%p
ExecStartPre=-/usr/bin/curl -Lso /usr/bin/authorized-keys https://raw.githubusercontent.com/cloudposse/github-authorized-keys/master/contrib/authorized-keys
ExecStartPre=-/bin/chmod 755 /usr/bin/authorized-keys
ExecStartPre=-/usr/bin/curl -Lso /usr/bin/github-authorized-keys https://github.com/cloudposse/github-authorized-keys/releases/download/1.0.3/github-authorized-keys_linux_amd64
ExecStartPre=-/bin/chmod 755 /usr/bin/github-authorized-keys
ExecStart=/usr/bin/github-authorized-keys
TimeoutStopSec=20s
Restart=always
RestartSec=10s
__EOF__
systemctl daemon-reload
systemctl start github-authorized-keys.service
