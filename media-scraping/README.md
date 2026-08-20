# Media Service

通过 Docker Compose 运行的媒体服务栈，包含媒体播放、元数据刮削、自动下载、字幕管理的完整流水线。

## 服务概览

| 服务 | 端口 | 镜像 | 说明 |
|------|------|------|------|
| Emby | `8096` (HTTP), `8920` (HTTPS) | `emby/embyserver` | 媒体播放服务器，支持 DLNA/Wake-on-Lan，使用 `host` 网络模式 |
| MetaTube | `8085` | `metatube-server` | 元数据刮削服务，数据存储于 SQLite |
| Sonarr | `8989` | `linuxserver/sonarr` | TV Shows / 连续剧自动下载管理 |
| Radarr | `7878` | `linuxserver/radarr` | 电影自动下载管理 |
| Prowlarr | `9696` | `linuxserver/prowlarr` | 索引器管理，为 Sonarr/Radarr 提供磁力源 |
| Bazarr | `6767` | `linuxserver/bazarr` | 字幕自动下载 |
| qBittorrent | `8086` (WebUI), `6881` (BT) | `linuxserver/qbittorrent` | BitTorrent 下载客户端，使用 `host` 网络模式 |

## 网络

- 自定义网络：`media-network`（bridge）
- Emby 和 qBittorrent 使用 `host` 网络模式
  - **注意：** qBittorrent 请指定网络接口，防止下载流量走 sing-box 白名单

## 数据卷

所有服务数据挂载在 `$HOME/Applications/emby/` 下：

| 路径 | 用途 |
|------|------|
| `$HOME/Applications/emby/` | Emby 配置目录 |
| `$HOME/Applications/emby/media-stack/` | **共享数据目录**，Sonarr/Radarr/Bazarr/qBittorrent 共用 |
| `$HOME/Applications/emby/media-stack/radarr/` | Radarr 下载目录 → 挂载到 Emby `/mnt/movies` |
| `$HOME/Applications/emby/media-stack/tv-sonarr/` | Sonarr 下载目录 → 挂载到 Emby `/mnt/tv` |
| `$HOME/Applications/emby/sonarr/config/` | Sonarr 配置 |
| `$HOME/Applications/emby/radarr/config/` | Radarr 配置 |
| `$HOME/Applications/emby/bazarr/config/` | Bazarr 配置 |
| `$HOME/Applications/emby/qbittorrent/` | qBittorrent 配置 & 下载数据 |
| `$HOME/Applications/emby/prowlarr/` | Prowlarr 配置 |
| `$HOME/Applications/emby/metatube/` | MetaTube 数据（SQLite） |
| `$HOME/disks/private/` | 挂载到 Emby `/mnt/private`（rshared） |
| `$HOME/disks/resource/` | 挂载到 Emby `/mnt/resource`（rshared） |
| `$HOME/Music/` | 挂载到 Emby `/mnt/music` |

## 环境变量

所有 linuxserver 镜像共享以下约定：
- `PUID=1000` / `PGID=1000`：容器以当前用户权限运行
- `TZ=Asia/Shanghai`：时区

## 服务依赖链路

```
Prowlarr（索引器）→ Sonarr/Radarr（媒体管理）→ qBittorrent（下载）→ Bazarr（字幕）
                                                                          ↓
                                                                    Emby（播放）
MetaTube → Emby（元数据刮削）
```

## 同步

此 `docker-compose.yml` 由 Makefile `update` target 从 `~/Workspace/docker-compose.yml` 同步而来。
