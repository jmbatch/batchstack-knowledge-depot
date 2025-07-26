# debian_package_management

**Searching & inspecting packages**
| Action                             | Command                |
| ---------------------------------- | ---------------------- |
| Search for a package               | `apt search <package>` |
| Show detailed info about a package | `apt show <package>`   |
| List files installed by a package  | `dpkg -L <package>`    |
| Find out which package owns a file | `dpkg -S <file_path>`  |
| List manually installed packages   | `apt-mark showmanual`  |

**Installing & removing packages**
| Action                         | Command                                                                  |
| ------------------------------ | ------------------------------------------------------------------------ |
| Install a package              | `apt install <package>`                                                  |
| Install from a `.deb` file     | `dpkg -i <file>.deb` *(then run `apt -f install` to fix deps if needed)* |
| Remove a package (keep config) | `apt remove <package>`                                                   |
| Remove a package (and config)  | `apt purge <package>`                                                    |
| Autoremove unused dependencies | `apt autoremove`                                                         |
| Fix broken dependencies        | `apt --fix-broken install`                                               |

**Updating & upgrading**
| Action                               | Command                 |
| ------------------------------------ | ----------------------- |
| Update package index                 | `apt update`            |
| Upgrade installed packages           | `apt upgrade`           |
| Full upgrade (removes obsolete deps) | `apt full-upgrade`      |
| List upgradable packages             | `apt list --upgradable` |
| Simulate upgrade (dry run)           | `apt -s upgrade`        |

**Package info & dependencies**
| Action                         | Command                             |                  |
| ------------------------------ | ----------------------------------- | ---------------- |
| List dependencies of a package | `apt depends <package>`             |                  |
| Reverse dependencies           | `apt rdepends <package>`            |                  |
| Check install status           | `dpkg -s <package>`                 |                  |
| Check version installed        | `dpkg -l`                           | `grep <package>` |
| List all installed packages    | `dpkg -l` or `apt list --installed` |                  |

**System cleanup**
| Action                       | Command         |
| ---------------------------- | --------------- |
| Clean local package cache    | `apt clean`     |
| Remove partial package files | `apt autoclean` |

**Troubleshooting**
| Symptom                     | Fix                                                                   |
| --------------------------- | --------------------------------------------------------------------- |
| Broken `dpkg` state         | `dpkg --configure -a`                                                 |
| Locked `apt` database       | `rm /var/lib/apt/lists/lock` and `rm /var/lib/dpkg/lock` (cautiously) |
| Force reconfigure a package | `dpkg-reconfigure <package>`                                          |


**Using aptitude**
```bash
apt install aptitude
aptitude
```
