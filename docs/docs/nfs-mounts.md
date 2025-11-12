---
sidebar_position: 6
---

# NFS Mount Automation

This guide covers the automated NFS mount setup using 1Password for credential management.

## Overview

The NFS mount automation system integrates with 1Password to securely store and retrieve mount credentials, automatically configuring NFS shares on macOS.

## Features

- 🔐 **Secure Credential Storage** - Credentials stored in 1Password
- 🤖 **Automated Setup** - Mounts configured automatically
- 📝 **fstab Integration** - Optional persistent mounts
- ✅ **Validation** - Tests mounts before committing
- 🔄 **Idempotent** - Safe to run multiple times

## Prerequisites

1. **1Password Account** - With CLI access
2. **1Password CLI** - Installed and configured
3. **NFS Server** - Accessible from your network
4. **Admin Access** - Required for fstab modifications

## 1Password Setup

### Install 1Password CLI

The CLI is automatically installed via Homebrew in your dotfiles:

```bash
brew install --cask 1password-cli
```

### Authenticate

Sign in to 1Password:
```bash
op signin
```

Or use biometric authentication:
```bash
eval $(op signin)
```

## Creating Mount Entries

### Item Structure

Create items in 1Password with:
- **Tag**: `nfs-mount`
- **Fields**:
  - `server` - NFS server hostname/IP
  - `share` - NFS export path
  - `mount_point` - Local mount location
  - `options` (optional) - Mount options
  - `add_to_fstab` (optional) - "true" or "false"

### Example Entry

**Item Name**: Home Media Server

**Fields**:
```
server: nas.home.lan
share: /volume1/media
mount_point: /Users/username/mnt/media
options: rw,noowners,nolockd,noresvport,hard,bg,intr,rw,tcp,nfc
add_to_fstab: true
```

### Using 1Password GUI

1. Open 1Password
2. Create new item (type: Secure Note or Server)
3. Add tag: `nfs-mount`
4. Add fields as shown above
5. Save

### Using 1Password CLI

```bash
# Create template
op item create \
  --category="Secure Note" \
  --title="NFS Mount Name" \
  --tags="nfs-mount" \
  server="nas.local" \
  share="/export/path" \
  mount_point="/Users/$USER/mnt/name"
```

## Mount Options

Common NFS mount options:

### Basic Options
- `rw` - Read-write access
- `ro` - Read-only access
- `noowners` - Ignore ownership (for compatibility)
- `nolockd` - Disable lock daemon

### Network Options
- `noresvport` - Use non-privileged ports
- `tcp` - Use TCP protocol (recommended)
- `udp` - Use UDP protocol
- `vers=3` - Use NFSv3
- `vers=4` - Use NFSv4

### Reliability Options
- `hard` - Hard mount (recommended for important data)
- `soft` - Soft mount (timeout and return error)
- `intr` - Allow interruption of mount operations
- `bg` - Retry mount in background if it fails

### Performance Options
- `rsize=8192` - Read buffer size
- `wsize=8192` - Write buffer size
- `timeo=900` - Timeout (in tenths of seconds)
- `retrans=5` - Number of retransmissions

### macOS Specific
- `nfc` - Use NFS version 4 with Kerberos
- `noquota` - Disable quota checking

### Recommended Configuration

```
rw,noowners,nolockd,noresvport,hard,bg,intr,rw,tcp,nfc
```

This provides:
- Read-write access
- Ignores Unix ownership (macOS compatibility)
- No file locking
- Non-reserved ports
- Hard mount with background retry
- Interruptible operations
- TCP protocol
- NFS version 4

## Automation Script

The `run_once_setup-nfs-mounts.sh.tmpl` script handles all mount operations.

### Script Features

1. **Discovery** - Finds all `nfs-mount` tagged items in 1Password
2. **Validation** - Verifies server accessibility
3. **Mount Point Creation** - Creates directories if needed
4. **Mounting** - Mounts NFS shares with specified options
5. **fstab Management** - Optionally adds persistent mounts
6. **Error Handling** - Provides clear error messages

### Execution

The script runs automatically when you apply your dotfiles:

```bash
chezmoi apply
```

Manual execution:
```bash
bash ~/.local/share/chezmoi/run_once_setup-nfs-mounts.sh.tmpl
```

Force re-run:
```bash
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

## Persistent Mounts (fstab)

### Adding to fstab

Set `add_to_fstab: true` in the 1Password item to persist mounts across reboots.

fstab entry format:
```
server:/share /mount/point nfs options 0 0
```

### Manual fstab Management

Edit fstab:
```bash
sudo vifs
```

Add entry:
```
nas.local:/export/media /Users/username/mnt/media nfs rw,noowners,nolockd,noresvport,hard,bg,intr,tcp 0 0
```

Mount all fstab entries:
```bash
sudo mount -a
```

### Removing from fstab

1. Set `add_to_fstab: false` in 1Password
2. Re-run the script
3. Or manually edit with `sudo vifs`

## Manual Mount Operations

### Mount NFS Share

```bash
# Create mount point
mkdir -p ~/mnt/media

# Mount
sudo mount -t nfs -o rw,noowners,nolockd nas.local:/export/media ~/mnt/media
```

### Unmount

```bash
sudo umount ~/mnt/media
```

Force unmount:
```bash
sudo umount -f ~/mnt/media
```

### Check Mounts

List all mounts:
```bash
mount | grep nfs
```

Show mount details:
```bash
nfsstat -m
```

## Troubleshooting

### Mount Fails

Check server accessibility:
```bash
ping nas.local
showmount -e nas.local
```

Test mount manually:
```bash
sudo mount -v -t nfs -o rw nas.local:/export ~/test-mount
```

### Permission Denied

Verify NFS export permissions on server:
```bash
# On NFS server
cat /etc/exports
showmount -e
```

Ensure client IP is allowed in server's export configuration.

### Stale File Handle

Unmount and remount:
```bash
sudo umount -f ~/mnt/media
sudo mount ~/mnt/media
```

### Mount Point Busy

Find processes using mount:
```bash
lsof +D ~/mnt/media
```

Kill processes or wait, then unmount.

### 1Password Authentication

Re-authenticate:
```bash
op signin --force
```

Check CLI access:
```bash
op account list
op item list --tags nfs-mount
```

### Network Issues

Check network connectivity:
```bash
ping nas.local
traceroute nas.local
```

Test NFS protocol:
```bash
rpcinfo -p nas.local
```

## Best Practices

1. **Use Hard Mounts** - For important data
2. **Enable Background Retry** - Use `bg` option
3. **Use TCP** - More reliable than UDP
4. **Set Timeouts** - Prevent hanging on network issues
5. **Test Before fstab** - Verify mounts work before persisting
6. **Document Shares** - Use descriptive 1Password item names
7. **Regular Testing** - Verify mounts after network changes
8. **Backup Credentials** - 1Password emergency kit

## Security Considerations

1. **Network Security**
   - Use VPN for remote access
   - Restrict NFS exports to trusted IPs
   - Consider NFSv4 with Kerberos

2. **Credential Management**
   - Keep 1Password vault secure
   - Use strong master password
   - Enable 2FA on 1Password

3. **Server Configuration**
   - Use `root_squash` on server
   - Limit export access by IP/subnet
   - Regular security updates

4. **Local Security**
   - Protect mount points with appropriate permissions
   - Don't store sensitive data on NFS without encryption
   - Monitor access logs

## Advanced Configuration

### Multiple Servers

Create separate 1Password items for each mount:
```
Item 1: Media Server (nas1.local:/media)
Item 2: Backup Server (nas2.local:/backups)
Item 3: Work Server (work.local:/projects)
```

### Conditional Mounts

Use network detection to mount only when on specific networks:
```bash
if [[ "$(networksetup -getairportnetwork en0 | awk '{print $4}')" == "HomeNetwork" ]]; then
  sudo mount ~/mnt/media
fi
```

### Auto-mount on Network Connect

Use macOS Launch Agents to trigger mounts when network connects.

### Automount

Enable automount service:
```bash
sudo automount -vc
```

Configure auto_master:
```bash
sudo vi /etc/auto_master
```

## Resources

- [1Password CLI Documentation](https://developer.1password.com/docs/cli/)
- [macOS NFS Client](https://support.apple.com/guide/mac-help/share-files-using-nfs-mh17131/)
- [NFS Documentation](https://linux.die.net/man/5/nfs)
- [showmount man page](https://man7.org/linux/man-pages/man8/showmount.8.html)
