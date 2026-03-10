# Repository Guidelines

## 项目结构与模块组织
当前仓库是一个精简的 Verilog 仿真工作区，核心文件如下：

- `test.v`：被测设计，当前定义 `module test`
- `testbench.v`：测试平台，负责激励、时钟生成和波形导出
- `run.ps1`：本地仿真脚本，串联编译、运行和波形查看
- `build/`：生成产物目录，包含 `sim.vvp`、`wave.vcd` 等文件

可综合逻辑应放在独立的 `*.v` 源文件中；仿真专用代码放在 `testbench.v` 或新增的 `*_tb.v` 文件中。除非用于排查问题，不要提交 `build/` 下的临时产物。

## 构建、测试与开发命令
- `powershell -ExecutionPolicy Bypass -File "./run.ps1"`：使用 `iverilog` 编译，调用 `vvp` 运行，并用 `gtkwave` 打开波形
- `iverilog -g2012 -o "build/sim.vvp" "testbench.v"`：仅编译仿真，不打开波形工具
- `vvp -n "build/sim.vvp"`：运行已生成的仿真文件

本地环境需要提前安装 `iverilog`、`vvp` 和 `gtkwave`，并确保它们已加入 `PATH`。

## 代码风格与命名约定
统一使用 4 空格缩进，端口连接建议上下对齐，保证可读性。仓库规模变大后，优先保持一文件一模块。

- 模块文件名使用小写描述性命名，如 `counter.v`
- 测试平台文件使用 `*_tb.v` 或 `testbench.v`
- 信号、变量使用 `snake_case`
- 参数和局部常量使用全大写，如 `END_TIME`

注释保持简短、技术化，并与目标文件现有注释语言一致。

## 测试规范
每次逻辑变更都应配套仿真验证。修改设计后，需同步补充或更新测试激励，并执行 `./run.ps1` 或等价的手动命令。

新增测试平台时，文件名建议使用 `_tb.v` 后缀。调试阶段应保留 `$dumpfile` 和 `$dumpvars`，至少验证以下内容：
- 初始状态或复位行为
- 正常时钟驱动下的功能输出
- 边界时序或仿真停止条件

## 提交与合并请求规范
当前目录不是 Git 仓库，无法从历史记录归纳现有提交风格。后续建议使用简洁的 Conventional Commits，例如：`feat: add counter module`、`fix: correct clock toggle`。

提交合并请求时应包含：
- 变更目的与功能摘要
- 受影响文件和验证步骤
- 涉及时序变化时附带波形截图
- 对应任务或问题编号（如适用）

## 安全与配置提示
不要在脚本或源码中写死机器相关的绝对路径。工具调用尽量基于仓库根目录的相对路径，`build/` 应视为可随时重建的输出目录。
