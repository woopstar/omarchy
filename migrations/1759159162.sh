echo "Enable automatic Bluetooth audio device switching"

# Ensure WirePlumber is installed
omarchy-pkg-add wireplumber

# Create config directory if it doesn't exist
mkdir -p ~/.config/wireplumber/wireplumber.conf.d/

# Only install if not already present (don't overwrite user modifications)
if [[ ! -f ~/.config/wireplumber/wireplumber.conf.d/51-bluetooth-autoswitch.conf ]]; then
  cp ~/.local/share/omarchy/config/wireplumber/wireplumber.conf.d/51-bluetooth-autoswitch.conf \
     ~/.config/wireplumber/wireplumber.conf.d/

  echo "  → Bluetooth auto-switch config installed"
  echo "  → Restarting WirePlumber..."
  systemctl --user restart wireplumber
else
  echo "  → Config already exists, skipping"
fi