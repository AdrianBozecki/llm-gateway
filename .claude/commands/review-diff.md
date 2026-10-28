---
description: Senior Go review of my diff — findings only, no rewritten code
argument-hint: "[git range, default: working tree + staged]"
allowed-tools: Bash(git diff:*), Bash(git log:*), Bash(git show:*), Bash(git status:*), Bash(go vet:*), Bash(go build:*), Bash(go test:*), Bash(golangci-lint run:*), Read, Grep, Glob
---

Review my changes like a senior Go developer.

Diff to review: if `$ARGUMENTS` is given, `git diff $ARGUMENTS`; otherwise both
`git diff` and `git diff --staged`. Read surrounding code where needed. Run `go vet ./...`
and `go test -race ./...` and include any failures.

Check, in this order: correctness against the current milestone's scope, data races,
goroutine leaks and channel ownership, `context` cancellation and deadlines, error handling
(wrapping, classification, not logged-and-returned), resource cleanup (bodies, timers,
shutdown), tests (table-driven, fake provider, no real API calls), idiomatic Go.

Format each finding as **`file:line` — problem — why it matters**, ranked by severity.
Do not rewrite the code or show the fixed version. Don't pad the list: if something is
fine, say so in one line.

End with **one question** that checks whether I understand my own code.
