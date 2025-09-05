# Debian .deb Update Packages

## Option 1 - Using dpkg

```bash
sudo dpkg -i package.deb
```

- installs or upgrades the package
- *Does not resolve dependencies*
- if deps are missing, fix them with:

```bash
sudo apt --fix-broken install
```

## Option 2 - Using apt (preferred)

```bash
sudo apt install ./package.deb
```

- Handles install/upgrade and dependencies automatically
- Works with absolute or relative paths (./ is required)

Upgrade explicitly:

```bash
sudo apt install --only-upgrade ./package.deb
```

## Option 3 - Using gdebi (dependency resolver)

```bash
sudo apt install gdebi-core
sudo gdebi package.deb
```

- installs the .deb and resolves deps
- handy on minimal systems where you don't want to mess with apts full resolver

## Optional stuff

### Dry-run / Preview

- See what would happen without installing:

```bash
sudo apt instsall --simulate ./package.deb
```

### Query and verify

- Check dependencies before installing:

```bash
dpkg -I package.deb | grep Depends
```

- Check installed version:

```bash
dpkg -l | grep packagename
```

- See upgrade candidate:

```bash
apt-cache policy packagename
```

### Rollback / Downgrade

- if you need to go back to an older `.deb`:

```bash
sudo apt install ./older-version.deb
```

- or force downgrade if needed:

```bash
sudo dpkg -i --force-downgrade older-version.deb
```
