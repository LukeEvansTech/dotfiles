# NFS Mounts with 1Password Integration

This document explains how to set up NFS mounts using 1Password for credential storage with chezmoi.

## Quick Start

1. **Store mount details in 1Password**:
   - Create a Secure Note with tag `nfs-mount`
   - Add required fields: `server`, `remote_path`, `local_path`
   - Optional fields: `options`, `add_to_fstab`

2. **Apply configuration**:
   ```bash
   chezmoi apply
   ```

## 1Password Item Setup

### Required Fields

| Field         | Description        | Example                       |
| ------------- | ------------------ | ----------------------------- |
| `server`      | NFS server address | `192.168.1.100`               |
| `remote_path` | Path on NFS server | `/exports/data`               |
| `local_path`  | Local mount point  | `/Users/username/mounts/data` |

### Optional Fields

| Field          | Description       | Default               |
| -------------- | ----------------- | --------------------- |
| `options`      | Mount options     | `resvport,rw,noatime` |
| `add_to_fstab` | Add to /etc/fstab | `false`               |

### Example Item

```
Title: NFS Mount - Home Server
Tag: nfs-mount

Fields:
- server: 192.168.1.100
- remote_path: /exports/data
- local_path: /Users/username/mounts/data
- options: resvport,rw,noatime
- add_to_fstab: true
```

## How It Works

The script:
1. Retrieves items with tag `nfs-mount` from 1Password
2. Creates local mount points if needed
3. Mounts NFS shares
4. Optionally adds entries to /etc/fstab

## Troubleshooting

- **Authentication**: Run `op signin` before using the script
- **Permissions**: Script requires sudo access for mounting
- **Logs**: Check console output for error messages

## Management

- **Add mount**: Create new 1Password item with tag `nfs-mount`
- **Remove mount**: 
  1. Delete 1Password item
  2. Unmount: `sudo umount /path/to/mount`
  3. Remove from fstab if added