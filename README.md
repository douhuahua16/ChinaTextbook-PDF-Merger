# ChinaTextbook PDF Merger

在 Android 上使用 **MT 管理器终端 / Termux** 批量合并 [ChinaTextbook](https://github.com/TapXWorld/ChinaTextbook) 下载的 PDF 二进制分片。无需 Root、无需 Windows EXE。

> 非 ChinaTextbook 官方项目。本工具仅负责合并用户已经下载的分片，不包含教材内容。

## 功能

- 递归查找指定目录中的 `*.pdf.1` 文件
- 按相同文件名前缀及数字编号合并 `*.pdf.1`、`*.pdf.2`、`*.pdf.3` 等
- 检查已找到的分片编号是否连续
- 如果目标 `.pdf` 已存在则跳过，避免覆盖
- 先写入临时文件 `.pdf.merging`，合并成功后重命名
- 默认保留原始分片，不自动删除

## 使用教程（MT 管理器）

1. 下载本仓库的 `merge_pdf.sh` 到手机 `Download` 文件夹。
2. 下载好同一本教材的**全部**分片，并放在同一目录。
3. 打开 MT 管理器终端，执行：

```sh
sh /sdcard/Download/merge_pdf.sh /sdcard/Download
```

也可以指定其他目录：

```sh
sh /sdcard/Download/merge_pdf.sh "/sdcard/Documents/教材"
```

不需要 `chmod`，用 `sh` 运行即可。请确保 MT 管理器具有相应文件夹的读写权限。

## 示例

合并前：

```text
数学.pdf.1
数学.pdf.2
数学.pdf.3
```

合并后会新增 `数学.pdf`；分片仍然保留。

## 注意事项

- **请先确保所有分片已下载完成。** 脚本只能检查现有编号是否有缺口，无法知道远端总分片数量。例如教材本该有 3 片、但只下载了前 2 片时，仍可能合并出不完整的 PDF。
- 本工具适用的是**同一个 PDF 按字节拆分的文件**，不是将几个独立 PDF 文档按页面合并。
- 不会覆盖已存在的目标 PDF；如果之前生成过不完整文件，请先手动检查并移走它，然后重试。
- 目标目录需要有足够剩余空间，至少能够容纳合并后的 PDF。
- 本版本使用 Android 的 `/system/bin/sh`、`find`、`cat` 等工具；尚未针对所有文件名和安卓版本做全面兼容性测试。

## 致谢

教材资料来源：[TapXWorld/ChinaTextbook](https://github.com/TapXWorld/ChinaTextbook)。

此脚本为独立编写的简单文件分片合并工具，不是原项目 Windows EXE 的移植，也不附带原项目教材文件。
