# 02 - 配置 GitHub

> 目标：在新主机上配置 Git 并连接 GitHub

## 前置条件

- 已完成 [01 - SSH 远程连接](./01-SSH远程连接.md)
- 有 GitHub 账号

---

## 步骤一：配置 Git 用户信息

在**新主机**上执行：

```bash
git config --global user.name "wangjs-jacky"
git config --global user.email "2409277719@qq.com"
```

验证配置：

```bash
git config --global --list
```

---

## 步骤二：生成 SSH 密钥

在**新主机**上执行：

```bash
ssh-keygen -t ed25519 -C "2409277719@qq.com"
```

一路回车使用默认设置。

查看公钥：

```bash
cat ~/.ssh/id_ed25519.pub
```

复制输出的内容。

---

## 步骤三：添加 SSH 密钥到 GitHub

1. 打开 GitHub → Settings → SSH and GPG keys
2. 点击「New SSH key」
3. Title 填：`Mac Mini`（或其他能识别设备的名称）
4. Key type 选：`Authentication Key`
5. 粘贴公钥内容到「Key」文本框
6. 点击「Add SSH key」

---

## 步骤四：测试连接

```bash
ssh -T git@github.com
```

预期输出：

```
Hi wangjs-jacky! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 步骤五：配置代理（可选）

如果网络需要代理，执行：

```bash
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890
```

取消代理：

```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

---

## 常见问题

### Q: SSH 连接超时怎么办？

检查：
1. 网络是否正常
2. 是否需要配置代理
3. SSH 密钥是否正确添加到 GitHub

### Q: 如何查看已添加的 SSH 密钥？

GitHub → Settings → SSH and GPG keys，可以看到所有已添加的密钥列表。

---

## 下一步

[03 - 配置开发环境](./03-配置开发环境.md)
