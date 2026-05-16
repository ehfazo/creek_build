# Crave Custom ROM Build Scripts 🚀
Instruction is still under maintenance.. will be updated soon.

This repository contains highly automated build scripts optimized for building custom Android ROMs (specifically LineageOS) using the **Crave.io** build environment. 

These scripts handle the entire lifecycle of a build: from environment preparation and source synchronization to automated notifications and artifact distribution.

---

## ✨ Features
*   **Automated Tooling:** Self-installs dependencies like `jq` if missing.
*   **Smart Sync:** Integrates with Crave's native resync logic for maximum speed.
*   **Real-time Notifications:** Sends build status, sync times, and errors directly to Telegram.
*   **Artifact Hosting:** Automatically uploads successful builds (`.zip`) and partition images (`.img`) to **PixelDrain** and **GoFile**.
*   **Error Logging:** On failure, the script captures and uploads build logs to help with debugging.

---

## 🛠️ Setup & Usage

### 1. Prerequisites
You must have a **Crave.io** account and the `crave` CLI tool configured on your local machine or devspace.

### 2. Secrets Management
Create a `.env` file in your project root. **Never commit this file to GitHub.**

```env
TG_TOKEN="your_telegram_bot_token"
TG_CHAT="your_telegram_chat_id"
TG_TOPIC="your_telegram_topic_id"
UPLOAD="your_telegram_log_channel_id"
PIXELDRAIN="your_pixeldrain_api_key"
GITHUB="your_github_token"
```


### 3. Running a Build
To start a build for the POCO M7 (**creek**), execute the following command in your terminal:


# Push the .env file to the root of the Crave workspace
```bash
crave push .env -d /tmp/src/android
curl -sf https://raw.githubusercontent.com/nuruszama/crave_build_script/blob/main/crave_build.sh | bash
```

---

## GitHub Actions (Self-Hosted)

This repo includes a self-hosted GitHub Actions workflow that runs the same build logic on your own runner.

### 1. Runner requirements
- Self-hosted runner labels: `self-hosted`, `linux`, `x64`
- Passwordless `sudo` (required by timezone setup in `crave_run.sh`)
- Preinstalled tools: `git`, `git-lfs`, `curl`, `repo`, Java/Android build deps, and Android build environment
- Sufficient disk space for Android source and build output

Recommended for Ubuntu 24.04
- OpenJDK 17: `sudo apt-get install -y openjdk-17-jdk`
- Repo tool: `curl -s https://storage.googleapis.com/git-repo-downloads/repo -o ~/bin/repo && chmod +x ~/bin/repo`

### 2. Required GitHub secrets
Add these in your GitHub repository settings:

| Secret | Used by | Purpose |
| --- | --- | --- |
| `TG_TOKEN` | `crave_run.sh`, `crave_build.sh` | Telegram bot token for notifications |
| `TG_CHAT` | `crave_run.sh`, `crave_build.sh` | Telegram chat ID for notifications |
| `TG_TOPIC` | `crave_build.sh` | Telegram topic ID for queue messages |
| `UPLOAD` | `crave_run.sh` | Telegram channel ID for log uploads |
| `PIXELDRAIN` | `crave_run.sh` | PixelDrain API key for artifact uploads |
| `GITHUB` | `crave_run.sh` | GitHub token (reserved for future use) |

### 3. Trigger the workflow
Go to the Actions tab and run **Creek Build (Self-Hosted)** manually.

---

## Script Map

- `build_config.sh`: build parameters (device, release, build type).
- `crave_build.sh`: Crave.io entry point that queues the remote build.
- `crave_run.sh`: main build workflow used by GitHub Actions and Crave remote run.
- `messages.sh`: randomized queue messages used by `crave_build.sh`.

---

## 🤝 Credits

A huge thanks to the original author for the foundation of these scripts:

*   **[EternalMikaelson](https://github.com/EternalMikaelson)** - For the original script architecture, automated workflow logic, and Telegram integration.
*   
