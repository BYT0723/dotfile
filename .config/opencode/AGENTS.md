# Global Rules

## Language

- Default response language: Chinese.
- Use English for Git operations (commit message, branch, PR, tag, etc.).

## Skill Enforcement (MUST follow strictly)

For every development task from the user, auto-run the following flow. No skipping or omitting:

### Step 1: Identify task type

Match by keywords in the user description (keywords stay in Chinese because user input is Chinese):

| Type          | Keywords (Chinese)                  | Auto-load skill                                                                                                      |
| ------------- | ----------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| feat          | 新增、添加、功能、实现、开发        | `spec-driven-development` → `planning-and-task-breakdown` → `incremental-implementation` + `test-driven-development` |
| fix           | 修复、bug、错误、异常、不对、有问题 | `debugging-and-error-recovery`                                                                                       |
| perf          | 优化、性能、慢、卡顿、加速          | `performance-optimization`                                                                                           |
| refactor      | 重构、整理、简化、拆分、重命名      | `code-simplification`                                                                                                |
| security      | 安全、漏洞、注入、权限、加密        | `security-and-hardening`                                                                                             |
| docs/style/ci | 文档、注释、格式、CI、流水线        | No forced skill, implement directly                                                                                  |

### Step 2: Declare and load skill

Before starting any work, declare in Chinese:

> 识别到 [类型] 任务，加载 [skill名称]

Then load the corresponding skill via the `skill` tool.

### Step 3: Follow skill steps strictly

Follow every step inside the loaded skill completely. No skipping, merging, or improvising. Write spec when spec is required, write tests when tests are required.

## Development Workflow (MUST follow, GitHub Flow + Conventional Commits, multi-agent by default)

- NEVER develop/commit directly on `main`/`master`/`release/*`; at start run `git status` + `git branch --show-current` + `git worktree list` to confirm exclusive ownership of one worktree/branch; if on a protected branch, baseline outdated, or directory occupied, create a new isolated slot; if working tree dirty, stop and confirm.
- One task = one worktree + one branch + one session: separate worktree/branch per independent task; forbid 2+ unrelated changes / drive-by refactor / formatting / dep upgrades; forbid reusing others' worktree or old branches; naming `type/desc` lowercase with dashes, directory prefers `/tmp/opencode/<repo>-<type-desc>`, `type` limited to `feat|fix|perf|refactor|security|docs|test|chore|hotfix`.
- Commits: `type(scope): subject` in English, atomic; solo/worker may auto-commit locally, integration is done by main session in the base worktree via merge/rebase + delete local branch/worktree; forbid auto push/PR/delete remote branches, forbid force/reset rewriting public history.
- Scope: minimal diff; report first on API/schema/config/dependency breaking changes; forbid secrets/private keys/privacy, `node_modules/dist/build` artifacts.
- Gates: read source and tests first, follow skill+TDD; detect and run lint/typecheck/test/build per repo (declare skip if absent), self-check with `git diff --stat` inside current worktree for unrelated files or debug leftovers.
- Ending: ask user to choose `/ship` or `/publish`; `/ship` means main session integrates locally then reports done, `/publish` pushes/PRs only on explicit call; never push `main/master/release/*` directly, never auto-merge own PR.

## Parallel Work (multi-agent, MUST follow)

- Main session splits + integrates, workers touch only own worktree/branch: forbid 2 agents writing same dir/branch, different edits on same branch also count as conflict.
- New slot: `git worktree add /tmp/opencode/<repo>-<type-desc> -b <type/desc>` or `tools.opencode.worktree_create`; on finish `worktree remove` then delete local branch, never touch remotes.
- Runtime isolation: separate port/DB/sqlite file/dev server per agent, no shared mutable state.
- Split by vertical slice + file ownership + interface contract first, run tests to guard semantic conflicts even with clean textual merge.

## Documentation & Research

- When you need to look up library/framework documentation, use `context7` tools.
- When you need to find code examples from GitHub, use `gh_grep` tools.
