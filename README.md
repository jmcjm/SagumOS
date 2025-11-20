# SagumOS

Custom immutable Linux image based on [Universal Blue Bluefin-DX](https://github.com/ublue-os/bluefin) with enterprise security and developer tooling.

## What is this?

SagumOS is a bootc-based operating system image built on top of **Bluefin-DX** (the developer-focused variant of Universal Blue's desktop environment). The primary focus is **Microsoft Defender for Endpoint** integration for enterprise security compliance, along with a curated set of modern development tools.

This is essentially Bluefin-DX + Defender + a bunch of useful packages you'd install anyway.

## Key Features

### 🛡️ Microsoft Defender for Endpoint

The main reason this image exists. Includes full **Microsoft Defender for Endpoint** (`mdatp`) installation and configuration for Linux, allowing corporate security compliance on an immutable desktop.

### 📦 Additional Software

**Browser:**
- Google Chrome (stable)

**Fonts:**
- SourceCodePro Nerd Font v3.4.0

**CLI Tools:**
- `tmux` - terminal multiplexer
- `ripgrep` - faster grep
- `bat` - better cat with syntax highlighting
- `eza` - modern ls replacement
- `fd-find` - user-friendly find alternative
- `zoxide` - smarter cd command
- `btop` - resource monitor
- `iotop` - I/O monitoring

**Development Tools:**
- `clang` + `clang-tools-extra` - C/C++ toolchain
- `lazygit` - terminal UI for git
- `git-delta` - better diff viewer
- `postgresql` - database client
- `httpie` - user-friendly HTTP client
- `jq` / `yq` - JSON and YAML processors

**Services:**
- `podman.socket` - enabled by default

## Installation

If you're already on a bootc-based system (Bluefin, Bazzite, Aurora, Fedora Atomic), switch to this image with:

```bash
sudo bootc switch ghcr.io/jmcjm/sagumos:latest
```

Reboot when prompted. That's it.

## Building

The image is automatically built via GitHub Actions and published to `ghcr.io/jmcjm/sagumos`.

For local builds, use the included Justfile:
```bash
just build
```

## Base Image

- **Base:** `ghcr.io/ublue-os/bluefin-dx:stable`
- **Type:** Immutable, atomic desktop (bootc/ostree-based)
- **Desktop:** GNOME (from Bluefin)

## Why?

Because sometimes you need corporate endpoint security on a Linux desktop that doesn't suck. Bluefin-DX provides a solid developer foundation, and this adds the enterprise security layer plus some extra conveniences.
