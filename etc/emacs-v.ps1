#! pwsh.exe

# 请 手动修改 默认参数:
$defaultArgs = "-q"

if ($args.count -lt 1) {
    Write-Output "请输入至少一个参数!"
    exit
}

$programNumber = $args[0]
$remainingArgs = $args[1..$args.count]

$programPath = $null

switch ($programNumber) {
    24 {
        $programPath = 'D:/Progs/emacs-24.5/bin/runemacs.exe'
    }
    25 {
        $programPath = 'D:/Progs/emacs-25.3_1/bin/runemacs.exe'
    }
    26 {
        $programPath = 'D:/Progs/emacs-26.3/bin/runemacs.exe'
    }
    27 {
        $programPath = 'D:/Progs/emacs-27.2/bin/runemacs.exe'
    }
    28 {
        $programPath = 'D:/Progs/emacs-28.2/bin/runemacs.exe'
    }
    default {
        Write-Output "无法识别的程序编号: $programNumber"
        exit
    }
}

# 如果默认参数不为空, 将它们添加到参数列表的开头.
if ($defaultArgs) {
    $remainingArgs = $defaultArgs + $remainingArgs
}

# 将剩余的参数传递给程序.
& $programPath $remainingArgs

# Local Variables:
# coding: utf-8-unix
# End:
