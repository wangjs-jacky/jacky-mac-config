# 01 - SSH 远程连接新主机

> 目标：从本地 Mac 连接到新买的 Mac Mini/Studio

## 前置条件

- 新主机已完成 macOS 初始设置（创建用户、连接 WIFI）
- 本地 Mac 和新主机在同一个局域网

---

## 步骤零：在新主机上开启远程登录

在**新主机**上执行以下命令，检查远程登录是否已开启：

```bash
sudo systemsetup -getremotelogin
```

如果显示 `Remote Login: Off`，执行以下命令开启：

```bash
sudo systemsetup -setremotelogin on
```

> **也可以通过图形界面开启**：系统设置 → 通用 → 共享 → 远程登录

---

## 步骤一：在新主机上获取连接信息

### 1.1 打开终端

在**新主机**上打开「终端」应用（Command + 空格，输入"终端"）

### 1.2 获取用户名

```bash
whoami
```

预期输出示例：
```
jacky
```

记下这个用户名，后面要用。

### 1.3 获取 IP 地址

```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

预期输出示例：
```
inet 192.168.1.7 netmask 0xffffff00 broadcast 192.168.1.255
```

> **如何看懂输出**：`inet` 后面的第一串数字就是 IP 地址，比如 `192.168.1.7`

记下这个 IP 地址。

---

## 步骤二：从本地连接新主机

回到**本地 Mac**，打开终端，执行：

```bash
ssh <用户名>@<IP地址>
```

示例：
```bash
ssh jacky@192.168.1.7
```

首次连接会提示确认指纹，输入 `yes` 回车，然后输入新主机的登录密码。

---

## 步骤三：配置免密登录（可选但推荐）

每次连接都要输密码很麻烦，配置 SSH 密钥后可以免密登录。

### 3.1 本地生成 SSH 密钥（如果没有）

在**本地 Mac** 执行：

```bash
# 检查是否已有密钥
ls ~/.ssh/id_rsa.pub

# 如果没有，生成新密钥
ssh-keygen -t rsa -b 4096
```

### 3.2 复制公钥到新主机

```bash
ssh-copy-id <用户名>@<IP地址>
```

示例：
```bash
ssh-copy-id jacky@192.168.1.7
```

### 3.3 测试免密登录

```bash
ssh jacky@192.168.1.7
```

如果不需要输入密码直接登录，配置成功！

---

## 下一步

[02 - 配置 GitHub](./02-配置GitHub.md)
