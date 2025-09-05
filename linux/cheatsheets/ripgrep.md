# ripgrep (rg) Cheat Sheet

## Basic Usage

```bash
rg "pattern"            # Search for 'pattern in current directory recursively
rg -i "pattern"         # Case-insensitive search
rg -w "pattern"         # Match whole words only
rg -x "pattern"         # Match the entire line
```

## File and Directory Control

```bash
rg "pattern" file.txt       # Search inside a single file
rg "pattern" dir/           # Search inside a specific directory
rg "pattern" *.py           # Search only in Python files (shell expansion)
rg "pattern" -g "*.py"      # Use glob filter. ripgrep handles it directly
rg "pattern" -g "!*.log"    # Exclude log files
```

## Output Options

```bash
rg -n "pattern"             # Show line numbers
rg -C 3 "pattern"           # Show 3 lines of context around matches
rg -A 2 "pattern"           # Show 2 lines after matches
rg -B 2 "pattern"           # Show 2 lines before matches
rg -o "pattern"             # Show only the matched text
```

## Regex

```bash
rg "^ERROR"             # Lines starting with ERROR
rg "foo|bar"            # Match 'foo' or 'bar'
rg "\d{3}-\d{2}-\d{4}"  # Regex for SSN format
```

## File Type Filtering

```bash
rg "pattern" --type py          # Search only Python files
rg --type-list                  # Show all supported file types
rg "pattern" --type-not sql     # Exclude SQL files
```

## Performance and tricks

```bash
rg "pattern" --files            # List files containing matches
rg "pattern" --count            # Count total matches
rg "pattern" --json             # JSON output (good for scripting)
rg "pattern" --pcre2            # Enable PCRE2 regex (lookahead/lookbehind)
```

## Alias examples

```bash
alias rgi='rg -i'
alias rgn='rg -n'
alias rga='rg --hidden --no-ignore'
```
