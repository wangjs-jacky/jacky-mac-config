# jacky-mac-config

> Complete guide for setting up a new Mac Mini/Studio workstation.

[中文文档](./README_CN.md)

## Overview

This repository documents the step-by-step process for configuring a new Mac workstation, including SSH setup, GitHub configuration, npm environment, and development tools.

## Documentation

| Step | Document | Description |
|------|----------|-------------|
| 01 | [SSH Remote Connection](./docs/01-SSH远程连接.md) | Connect to new Mac from local machine |
| 02 | [GitHub Configuration](./docs/02-配置GitHub.md) | Configure Git and SSH keys |
| 04 | [npm Setup](./docs/04-npm配置安装.md) | One-click npm environment sync |
| 05 | [Skills Sync](./docs/05-Skills同步.md) | Sync Claude Code skills |
| 06 | [Claude Global Config](./docs/06-Claude全局配置.md) | Sync CLAUDE.md config |

## Quick Start

```bash
# Clone the repository
git clone https://github.com/wangjs-jacky/jacky-mac-config.git
cd jacky-mac-config

# Read the docs in order
```

## Project Structure

```
jacky-mac-config/
├── README.md              # English documentation
├── README_CN.md           # 中文文档
├── CLAUDE.md              # Claude Code instructions
└── docs/
    ├── index.md           # Home page
    ├── 01-SSH远程连接.md
    ├── 02-配置GitHub.md
    ├── 04-npm配置安装.md
    └── scripts/           # Setup scripts
        ├── setup-passwordless-ssh.sh
        ├── setup-github-ssh.sh
        ├── setup-npm.sh
        └── setup-claude-skills.sh
```

## Features

- **One-click scripts** - Copy and paste commands directly
- **Timeline organized** - Follow steps in order
- **Complete reference** - From SSH to development environment

## License

MIT
