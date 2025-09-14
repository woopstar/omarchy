# add ssh keys to ssh-agent
mkdir -p ~/.ssh
if ! grep -q "^AddKeysToAgent yes" ~/.ssh/config 2>/dev/null; then
  echo 'AddKeysToAgent yes' | tee -a ~/.ssh/config >/dev/null
fi

# Create systemd service for ssh-agent
mkdir -p ~/.config/systemd/user
if ! grep -q "^ExecStart=/usr/bin/ssh-agent" ~/.config/systemd/user/ssh-agent.service 2>/dev/null; then
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
fi

# Start ssh-agent automatically for user
systemctl enable --user ssh-agent.service