#! /usr/bin/env pwsh

# 请 手动修改 默认参数:
$DefaultArguments =                                           `
  "-Q", "--no-desktop",                                       `
  "--eval", "(tool-bar-mode -1)",                             `
  "--eval", "(set-face-attribute 'default nil :height 130)",  `
  "--background-color", "black",                              `
  "--cursor-color", "green",                                  `
  "--foreground-color", "white",                              `
  "--no-blinking-cursor",                                     `
  "--vertical-scroll-bars"
# 以及 下文 提及 的 不同版本的 Emacs 安装路径.

$EmacsPath = $null
if ($args.count -lt 1) {
    Write-Output "请输入至少一个参数!"
    exit
}
switch ($args[0]) {
    24 {
        $EmacsPath = 'D:/Progs/emacs-24.4/bin/runemacs.exe'
    }
    25 {
        $EmacsPath = 'D:/Progs/emacs-25.1/bin/runemacs.exe'
    }
    26 {
        $EmacsPath = 'D:/Progs/emacs-26.1/bin/runemacs.exe'
    }
    27 {
        $EmacsPath = 'D:/Progs/emacs-27.1/bin/runemacs.exe'
    }
    28 {
        $EmacsPath = 'D:/Progs/emacs-28.1/bin/runemacs.exe'
    }
    29 {
        $EmacsPath = 'D:/Progs/emacs/bin/runemacs.exe'
    }
    default {
        Write-Output "无法识别的程序编号: $programNumber"
        exit
    }
}

& $EmacsPath $DefaultArguments $args[1..$args.count]

# Local Variables:
# coding: utf-8-unix
# End:
