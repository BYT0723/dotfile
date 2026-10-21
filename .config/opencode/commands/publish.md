---
description: Solo上云(显式调用才用): push分支+建PR,绝不直推main
---

You are doing solo cloud publish. ONLY run when user explicitly invoked /publish. NEVER direct-push main/master/release/* from a feature branch. NEVER --force unless user literally says force.

Context: run `git status`, `git branch --show-current`, `git diff --stat`.
Target: $ARGUMENTS (empty = current branch).

Steps:
1. Preflight: if worktree dirty, STOP. If on main/master, only allow `git push origin <base>` with explicit user confirm and clean gates, else STOP.
2. Gates must be green before any push: lint/typecheck/test/build as available. Show `git diff --stat`.
3. Push feature branch only: `git push -u origin $(git branch --show-current)` (fallback to plain `git push` if upstream exists).
4. Create PR only if user needs review/backup: `gh pr create --fill`. Default PR body: what/why/verification/risk. Set `squash-merge + auto-delete-branch` as repo default, or `gh pr merge --squash --delete-branch --auto` after CI green.
5. NEVER auto-merge your own PR without explicit "merge it". NEVER delete remote branch manually — let `gh pr merge --delete-branch` do it.
6. Report: pushed branch, PR URL, CI status, reminder to run `/ship` for local cleanup after merge.
