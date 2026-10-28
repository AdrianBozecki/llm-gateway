#!/usr/bin/env bash
# Blocks Bash commands that would write to files the owner writes by hand
# (see "Hard rules" in CLAUDE.md). Best effort: catches the common ways,
# not every possible one. Exit code 2 blocks the call and shows stderr to Claude.

cmd=$(jq -r '.tool_input.command // ""')

protected='(\.go|\.sql|\.tf|\.tfvars|Dockerfile[^ ]*|Makefile|docker-compose[^ ]*\.ya?ml|\.golangci\.ya?ml|go\.mod|go\.sum|README\.md|\.github/[^ ]*)'

block() {
  echo "Blocked by .claude/hooks/guard-bash.sh: $1. The owner writes this code; explain or review instead (see CLAUDE.md)." >&2
  exit 2
}

# Redirects or tee into a protected file
if grep -Eq "(>>?|tee( -a)?)[[:space:]]*[^ |;&]*${protected}([[:space:]]|$|;|&|\|)" <<<"$cmd"; then
  block "writing to a protected file"
fi

# In-place editors and code-rewriting tools
if grep -Eq '(^|[;&|[:space:]])(sed[[:space:]]+(-[a-zA-Z]*i|--in-place)|perl[[:space:]]+-[a-zA-Z]*i|gofmt[[:space:]]+(-[a-z]+[[:space:]]+)*-w|goimports[[:space:]]+(-[a-z]+[[:space:]]+)*-w|gofumpt[[:space:]]+(-[a-z]+[[:space:]]+)*-w|golangci-lint[[:space:]]+run[^;&|]*--fix|go[[:space:]]+(mod[[:space:]]+(init|tidy|edit)|get|generate|fix))([[:space:]]|$)' <<<"$cmd"; then
  block "command modifies source files"
fi

# Copying/moving onto a protected path
if grep -Eq "(^|[;&|[:space:]])(cp|mv|install|touch|patch|git[[:space:]]+apply)[[:space:]][^;&|]*${protected}([[:space:]]|$|;|&|\|)" <<<"$cmd"; then
  block "creating or overwriting a protected file"
fi

# Anything that costs money
if grep -Eq '(^|[;&|[:space:]])terraform[[:space:]]+(apply|destroy|import)|aws[[:space:]]+[a-z0-9-]+[[:space:]]+(create|run|put|delete|update|start)' <<<"$cmd"; then
  block "cloud-changing command; the owner runs these"
fi

exit 0
