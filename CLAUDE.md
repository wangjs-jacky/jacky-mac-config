# CLAUDE.md

## 项目说明

这是个人 Mac 工作站配置手册，记录配置新 Mac Mini/Studio 的完整步骤。

## 项目结构

```
jacky-mac-config/
├── CLAUDE.md              # 本文件
├── README.md              # 项目简介
└── docs/
    ├── index.md           # 首页
    ├── 01-SSH远程连接.md
    ├── 02-配置GitHub.md
    ├── ...
    └── scripts/           # 配套脚本
```

## 文档规范

- **目标读者**：自己（有编程基础）
- **组织方式**：时间线
- **风格**：复制粘贴版，命令可直接执行

## 配置信息

| 配置项 | 值 |
|--------|-----|
| 服务器 IP | 192.168.1.7 |
| 服务器用户名 | jacky |
| 服务器密码 | wangjiahao |
| GitHub 用户名 | wangjs-jacky |
| GitHub 邮箱 | 2409277719@qq.com |

## 新电脑 npm 安装工作流

当需要在新电脑上配置 npm 环境时，使用以下自动化流程：

### 目标电脑信息

| 配置项 | 值 |
|--------|-----|
| IP 地址 | 10.18.109.171 |
| 用户名 | jacky |
| 登录命令 | `ssh jacky@10.18.109.171` |

### 执行步骤

1. **SSH 登录目标电脑**
   ```bash
   ssh jacky@10.18.109.171
   ```

2. **克隆本项目**
   ```bash
   git clone https://github.com/wangjs-jacky/jacky-mac-config.git
   cd jacky-mac-config
   ```

3. **执行 npm 配置脚本**
   ```bash
   ./docs/scripts/setup-npm.sh
   ```

4. **验证安装结果**
   ```bash
   # 检查全局包
   npm list -g --depth=0

   # 检查镜像源
   nrm current
   nrm ls
   ```

### 迭代修复流程

如果执行过程中遇到问题：

1. 在**本地**修改 `docs/scripts/setup-npm.sh` 脚本
2. 提交并推送到 GitHub
3. 在**目标电脑**上执行：
   ```bash
   cd jacky-mac-config
   git pull
   ./docs/scripts/setup-npm.sh
   ```
4. 重复直到所有包安装成功

### 注意事项

- 确保目标电脑已安装 Node.js（脚本会检查）
- 如果某个包安装失败，可以单独安装：`npm install -g <package-name>`
- 个人工具包（@wangjs-jacky/*）需要先发布到 npm 才能安装

## 后续规划

- [ ] 使用 Vitepress 可视化
- [ ] 部署到 GitHub Pages
