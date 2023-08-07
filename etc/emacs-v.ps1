#! /usr/bin/env pwsh

# 请 手动修改 默认参数:
$DefaultArguments = "-Q"
# 以及 下文 提及 的 不同版本的 Emacs 安装路径.

$EmacsPath = $null
if ($args.count -lt 1) {
    Write-Output "请输入至少一个参数!"
    exit
}
switch ($args[0]) {
    24 {
        $EmacsPath = 'D:/Progs/emacs-24.5/bin/runemacs.exe'
    }
    25 {
        $EmacsPath = 'D:/Progs/emacs-25.3_1/bin/runemacs.exe'
    }
    26 {
        $EmacsPath = 'D:/Progs/emacs-26.3/bin/runemacs.exe'
    }
    27 {
        $EmacsPath = 'D:/Progs/emacs-27.2/bin/runemacs.exe'
    }
    28 {
        $EmacsPath = 'D:/Progs/emacs-28.2/bin/runemacs.exe'
    }
    default {
        Write-Output "无法识别的程序编号: $programNumber"
        exit
    }
}

$RemainingArguments = $args[1..$args.count]
# 如果默认参数不为空, 将它们添加到参数列表的开头.
if ($DefaultArguments) {
    $RemainingArguments = $DefaultArguments + $RemainingArguments
}

# 将剩余的参数传递给程序.
& $EmacsPath $RemainingArguments

# Local Variables:
# coding: utf-8-unix
# End:
