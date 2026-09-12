# simple-sddm

尝试还原 [ly](https://codeberg.org/fairyglade/ly) 的 SDDM 主题 — 终端 TUI 风格

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

## 预览

- 顶部左: `F1 shutdown  F2 reboot  F7 toggle password`（可配置）
- 顶部右: 时钟 `Wed Mar 25 20:33:54 2026`
- 居中输入框（白边黑底）:
  ```
  wayland   <          Niri          >
  login     <          user          >
  password *<          ****          >*
  ```

> 背景仅静态：`theme.conf` 中 `background` 支持纯色 `#000000` 或图片 `background.jpg`

## 安装
依赖
```bash
sudo dnf install -y make sddm qt6-qtdeclarative qt6-qtquickcontrols2 sddm-themes

sudo make install
# 手动
sudo cp -r . /usr/share/sddm/themes/simple-sddm
```

启用 `/etc/sddm.conf`:
```ini
[Theme]
Current=simple-sddm
```

预览（无需重启）:
```bash
make test
# sddm-greeter --test-mode --theme .
```

## 配置

编辑 `/usr/share/sddm/themes/simple-sddm/theme.conf` :

```
## 交互

- `↑/↓` 或 `Ctrl+K/J` / `Tab` 切换（session/login/password）
- `←/→` 或 `Ctrl+H/L` 在 session/login 选择
- `F1` 关机 (`sddm.powerOff`)、`F2` 重启、`F7` 明/密文切换
- `Enter` 登录
- 
## 结构
```
simple-sddm/
├── Main.qml            # 1:1 ly 布局
├── metadata.desktop
├── theme.conf
├── theme.conf.example
├── Makefile
└── preview.png
```

## License

MIT
