# Setting up Git SSH

## Step 1: Install Git on Debian

First, install Git by running the following commands:

1. **Update package index:**
    `sudo apt update`

2. **Install Git:**
    `sudo apt install git`

3. **Verify Git installation:**
    `git --version`

This should display the installed Git version, confirming that Git is installed.

## Step 2: Configure Git for Personal Use

You need to configure Git with your personal information so that your commits are attributed to you.

1. **Set your name:**
    `git config --global user.name "Dwight"`

2. **Set your email:**
    `git config --global user.email "dwightschrute@gmail.com"`

3. **Set your preferred editor for commit messages** (optional):
    `git config --global core.editor "nano"  # or vim if you prefer vim`

4. **Enable credential caching** (optional but useful): This allows Git to remember your credentials for some time, so you don't have to type your GitHub username and password every time.
    `git config --global credential.helper cache`

    Or, set the cache timeout (in seconds):
    `git config --global credential.helper 'cache --timeout=3600'  # 1 hour`

### Step 3: Generate SSH Key and Add to GitHub (Recommended)

Using SSH to authenticate with GitHub is more secure than using a username and password, especially since GitHub is deprecating basic authentication.

1. **Generate a new SSH key:**
    `ssh-keygen -t ed25519 -C "dwightschrute@gmail.com"`

    Follow the prompts to save the key (default location is `~/.ssh/id_ed25519`) and set a passphrase (or leave it blank for no passphrase).

2. **Add the SSH key to the SSH agent:**
    `eval "$(ssh-agent -s)" ssh-add ~/.ssh/id_ed25519`

3. **Copy the SSH public key to your clipboard:**
    `cat ~/.ssh/id_ed25519.pub`
    - add key to ~/.ssh/config

```bash
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
```

1. **Add the SSH key to your GitHub account:**

    - Go to your GitHub account.
    - In the upper-right corner, click your profile photo, then click **Settings**.
    - In the user settings sidebar, click **SSH and GPG keys**.
    - Click **New SSH key**, paste the SSH key from the previous step, and give it a recognizable title.
2. **Test SSH connection:**
    `ssh -T git@github.com`

    If successful, you should see a message like this:
    `Hi username! You've successfully authenticated, but GitHub does not provide shell access.`

### Step 4: Clone a Repository and Work on a Specific Branch

Now that you have Git configured, you can clone repositories and work on a specific branch.

1. **Clone the repository:** Navigate to the directory where you want to clone the repo, and run:
    `git clone git@github.com:your-username/your-repo.git`

    This will create a local copy of the repository.

2. **Navigate to the repository directory:**
    `cd your-repo`

3. **Switch to the branch you want to work on:**
    `git checkout your-branch-name`

4. **Make your changes**: Edit files as needed.

5. **Stage and commit your changes:**
    `git add . git commit -m "Your commit message"`

6. **Push your changes to the branch on GitHub:**
    `git push origin your-branch-name`

### Step 5: Make Git Usable by Other Admins

If you want other admins to use Git as well, they should each configure their own Git environment. Here's what to do for each admin:

1. **Ensure the admin has sudo privileges** (optional): You can create new users if needed and grant them sudo rights:
    `sudo adduser newadmin sudo usermod -aG sudo newadmin`

2. **Each admin should configure their own Git settings** (name, email, etc.) following the steps above under **Step 2**.

3. **Each admin should also generate their own SSH key** and add it to their GitHub account using the steps in **Step 3**. SSH keys are specific to each user, and multiple keys can be added to a single GitHub account.

4. **Shared repositories**:

    - All admins can clone the repository, switch to the branch they need to work on, make changes, and push them following the same procedure.
    - If you have many admins, you can set up a group for them and adjust permissions accordingly on the server for better security.

### Step 6: Verify Permissions and Test Setup

Once Git is installed and configured for everyone:

1. **Check repository permissions**: Ensure that each admin has the correct permissions on the repository on GitHub, i.e., they need to have push access to the branches they are working on.

2. **Test the setup** by having each admin clone the repo, make changes, and push to the desired branch
