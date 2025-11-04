# LXQt Desktop Environment with VNC Access

[![Docker Image](https://img.shields.io/badge/docker-labeg%2Fcentos--lxqt--vnc-blue)](https://hub.docker.com/r/labeg/centos-lxqt-vnc)

## Overview

> **Note:** This project has transitioned from CentOS to Fedora following the [CentOS Stream announcement](https://blog.centos.org/2020/12/future-is-centos-stream/).

A lightweight Docker image providing a complete desktop environment accessible via VNC. Built on Fedora minimal with LXQt desktop environment, OpenBox window manager, and TigerVNC Server.

**Key Features:**

- Minimal footprint with essential desktop components
- Multi-architecture support (amd64, arm64)
- Automated daily builds for latest security updates
- Customizable display resolution
- Easy VNC access configuration

![LXQt Desktop via VNC](https://raw.githubusercontent.com/LabEG/centos-lxqt-vnc/master/.pics/vnc_container_view.jpg)

## Quick Start

### Prerequisites

- Docker installed on your system
- VNC client (TigerVNC, TightVNC, RealVNC, or any compatible viewer)

### Try It Out

For a quick test run:

```bash
docker run -it --rm -e password='YOUR_VNC_PASSWORD' -p 5901:5901 labeg/centos-lxqt-vnc
```

Connect to `localhost:5901` using your VNC client with the password you specified.

### Production Deployment

For persistent use with automatic restart:

```bash
docker run -d \
  --name lxqt-vnc \
  --restart always \
  -e password='YOUR_VNC_PASSWORD' \
  -p 5901:5901 \
  labeg/centos-lxqt-vnc
```

## Configuration

### Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `password` | **Yes** | - | VNC connection password |
| `user_password` | No | `password` value | Password for the `headless` user |
| `root_password` | No | `user_password` value | Password for the `root` user |
| `resolution` | No | `1920x1080` | Virtual screen resolution |

### Docker Options

| Option | Description |
|--------|-------------|
| `--shm-size='64m'` | Increase shared memory size if Firefox or other browsers crash |
| `-p 5901:5901` | Map VNC port (change host port as needed) |
| `--restart always` | Automatically restart container on system reboot |

### Example with Custom Configuration

```bash
docker run -d \
  --name lxqt-vnc \
  --restart always \
  --shm-size='128m' \
  -e password='SecureVNCPassword' \
  -e user_password='UserPassword123' \
  -e resolution='2560x1440' \
  -p 5901:5901 \
  labeg/centos-lxqt-vnc
```

## Customization

### Changing LXQt Theme

1. Open the application menu
2. Navigate to **Preferences** → **Appearance** → **LXQt Theme**
3. Select your preferred theme (e.g., Kde-Plasma)

### Changing OpenBox Window Manager Theme

1. Open the application menu
2. Navigate to **Preferences** → **LXQt Settings** → **OpenBox Settings**
3. Select your preferred theme (e.g., Clearlooks)

## Supported Architectures

This image supports multiple platforms:

- `linux/amd64` - x86-64 architecture
- `linux/arm64/v8` - ARM 64-bit architecture

## Building from Source

Clone the repository and build the image locally:

```bash
git clone https://github.com/LabEG/centos-lxqt-vnc.git
cd centos-lxqt-vnc
docker build -t labeg/centos-lxqt-vnc .
```

## Security Considerations

- Always use strong passwords for VNC and user accounts
- Consider using SSH tunneling for VNC connections over untrusted networks
- Limit port exposure using firewall rules when deploying in production
- Keep the image updated by pulling the latest version regularly

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests on [GitHub](https://github.com/LabEG/centos-lxqt-vnc).

## License

See the [LICENSE](LICENSE) file for details.
