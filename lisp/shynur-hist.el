;;; -*- lexical-binding: t; -*-

;; 保存 minibuffer 的历史记录.
(shynur/custom:appdata/ savehist-file el)
(setopt savehist-autosave-interval nil)
(savehist-mode)

;; 仅配置, 但不启用该 package.
(setopt desktop-restore-eager t  ; 尽快恢复 buffer, 而不是 idle 时逐步恢复.
        ;; Lock 文件 是为了 防止其它 Emacs 实例将其复写.
        ;; 但我的电脑上只会有一个 Emacs 实例, 所以即使文件是 locked,
        ;; 也只能是因为上一次 session 中 Emacs 崩溃了.
        desktop-load-locked-desktop t
        ;; Idle 时不自动保存, 毕竟 session 结束时会自动保存.
        desktop-auto-save-timeout nil
        desktop-restore-frames nil)
;; ‘desktop-files-not-to-save’: 默认不保存 Remote file.
(shynur/custom:appdata/ desktop-dirname /)
(shynur/custom:appdata/ desktop-base-file-name nil nil
  ;; 基于‘desktop-dirname’.
  "desktop-base-file-name.el")
(shynur/custom:appdata/ desktop-base-lock-name nil nil
  ;; 基于‘desktop-dirname’.
  "desktop-base-lock-name.el")
(setopt desktop-save t)

;; 最近打开的文件
(shynur/custom:appdata/ recentf-save-file el)
(setopt recentf-max-saved-items nil
        recentf-max-menu-items 30)
(recentf-mode)

(provide 'shynur-hist)

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
