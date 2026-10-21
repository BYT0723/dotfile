---
description: Solo收尾(默认): review+simplify+本地merge+删分支,绝不push/PR
---

You are doing solo local ship. NEVER push, NEVER create PR, NEVER touch remote.

Reuse skills `code-review-and-quality` + `code-simplification` + `git-workflow-and-versioning`, but scoped to this diff only.

Steps:
1. Context: run `git status`, `git branch --show-current`, resolve base (`main` if exists else `master`), then `git diff --stat <base>...HEAD`. If on `<base>/release/*`, or dirty worktree, STOP and report.
2. Review only `git diff <base>...HEAD`: correctness first, then readability/architecture. Mark findings as Critical/Required/Nit. Fix only Critical+Required, leave Nits alone.
3. Simplify only changed files: remove dead code, flatten nesting, rename misleading names. Do NOT refactor unrelated files. Run project gates after each step: lint/typecheck/test/build as available. If tests need modification to pass, STOP — behavior changed.
4. Commit leftover changes atomically: `type(scope): subject` in English, one logical thing per commit. No `node_modules/dist/build/.env` secrets.
5. Local merge: `git checkout <base>` (require clean worktree), then only `git pull --ff-only` if upstream exists, else skip. Then `git merge --squash <feature-branch>`, verify gates again.
6. Cleanup local only: `git branch -d <feature-branch>`, `git fetch -p`, `git diff --stat` self-check.
7. Final report: CHANGES / DIDN'T TOUCH / VERIFICATION (tests+lint). STOP here.
