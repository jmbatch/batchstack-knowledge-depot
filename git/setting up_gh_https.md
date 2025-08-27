# Setting up gh https
```bash
## Install gh
sudo apt install gh

## Login
gh auth login
```

## Example
```bash
(.venv) jmbatch@jb-pc-01:~/dev/batchstack$ gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: 2DA8-1038
Press Enter to open github.com in your browser... 
✓ Authentication complete.
- gh config set -h github.com git_protocol https
✓ Configured git protocol
✓ Logged in as jmbatch
(.venv) jmbatch@jb-pc-01:~/dev/batchstack$
```

# Initialize and publish a repo
```bash
# 1) Initialize git in your project
git init

# 2) Make initial commit
git add .
git commit -m "chore: initial import of BatchStack CLI"

# 3) Create a GitHub repo from here (interactive)
gh repo create batchstack --source=. --public --push
# or: --private if you prefer
```