# Global Rules

## Language

- 默认使用中文作答。
- Git 操作（commit message、branch、PR、tag 等）使用英文。

## Skill Enforcement（必须严格遵守）

对于用户的每一项开发任务，你必须自动完成以下流程，不允许跳过或省略：

### 第一步：识别任务类型

根据用户描述中的关键词自动判断：

| 类型          | 关键词                              | 自动加载的 skill                                                                                                     |
| ------------- | ----------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| feat          | 新增、添加、功能、实现、开发        | `spec-driven-development` → `planning-and-task-breakdown` → `incremental-implementation` + `test-driven-development` |
| fix           | 修复、bug、错误、异常、不对、有问题 | `debugging-and-error-recovery`                                                                                       |
| perf          | 优化、性能、慢、卡顿、加速          | `performance-optimization`                                                                                           |
| refactor      | 重构、整理、简化、拆分、重命名      | `code-simplification`                                                                                                |
| security      | 安全、漏洞、注入、权限、加密        | `security-and-hardening`                                                                                             |
| docs/style/ci | 文档、注释、格式、CI、流水线        | 不强制加载 skill，直接实现                                                                                           |

### 第二步：声明并加载 skill

在开始任何工作前，必须先用中文声明：

> 识别到 [类型] 任务，加载 [skill名称]

然后用 `skill` 工具加载对应的 skill。

### 第三步：严格按 skill 步骤执行

加载后必须完整遵循 skill 内的每一步流程，不允许跳过、合并或自行发挥。该写 spec 就写 spec，该写测试就写测试。

## Documentation & Research

- When you need to look up library/framework documentation, use `context7` tools.
- When you need to find code examples from GitHub, use `gh_grep` tools.
