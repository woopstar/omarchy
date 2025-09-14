# add ssh keys to ssh-agent
mkdir -p ~/.ssh
echo 'AddKeysToAgent yes' | tee ~/.ssh/config >/dev/null

# Create systemd service for ssh-agent
mkdir -p ~/.config/systemd/user
tee ~/.config/systemd/user/ssh-agent.service >/dev/null <<EOF
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
# DISPLAY required for ssh-askpass to work
Environment=DISPLAY=:0
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
EOF

# Start ssh-agent automatically for user
sudo systemctl enable --user ssh-agent.service