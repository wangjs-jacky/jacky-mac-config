# Mac 工作站配置手册

> 记录配置新 Mac Mini/Studio 的完整步骤

[English](./README.md)

## 概述

本仓库记录了配置新 Mac 工作站的完整流程，包括 SSH 连接、GitHub 配置、npm 环境和开发工具等。

## 文档目录

| 序号 | 文档 | 说明 |
|------|------|------|
| 01 | [SSH远程连接](./docs/01-SSH远程连接.md) | 从本地连接到新主机 |
| 02 | [配置GitHub](./docs/02-配置GitHub.md) | 配置 Git 和 SSH 密钥 |
| 04 | [npm配置安装](./docs/04-npm配置安装.md) | 一键同步 npm 环境 |
| 05 | [Skills同步](./docs/05-Skills同步.md) | 同步 Claude Code 技能包 |
| 06 | [Claude全局配置](./docs/06-Claude全局配置.md) | 同步 CLAUDE.md 配置 |

## 快速开始

```bash
# 克隆仓库
git clone https://github.com/wangjs-jacky/jacky-mac-config.git
cd jacky-mac-config

# 按顺序阅读 docs/ 下的文档
```

## 项目结构

```
jacky-mac-config/
├── README.md              # 英文文档
├── README_CN.md           # 中文文档
├── CLAUDE.md              # Claude Code 指令
└── docs/
    ├── index.md           # 首页
    ├── 01-SSH远程连接.md
    ├── 02-配置GitHub.md
    ├── 04-npm配置安装.md
    └── scripts/           # 配套脚本
        ├── setup-passwordless-ssh.sh
        ├── setup-github-ssh.sh
        ├── setup-npm.sh
        └── setup-claude-skills.sh
```

## 特性

- **一键脚本** - 命令可直接复制执行
- **时间线组织** - 按顺序完成配置
- **完整参考** - 从 SSH 到开发环境全覆盖

## 许可证

MIT
