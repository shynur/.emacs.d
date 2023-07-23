;;; -*- lexical-binding: t; -*-

;;; 供 计算 日出/日落 的 时间 参考.
;; 地理位置:
(setq calendar-longitude 121.4
      calendar-latitude  31.2
      calendar-location-name "Shanghai, China")
;; 时区:
(setq calendar-time-zone (* 60 +8)  ; UTC+8
      calendar-standard-time-zone-name "CST"
      ;; 夏令时 在中国好像已经废除了.
      calendar-daylight-time-zone-name "CDT")

;; 通过某种方法 (e.g., NFS, Samba) 访问驻留在遵循不同的 EOL 约定
;; 的系统上的文件系统时, 不应该加以转换.

;; (add-untranslated-filesystem "Z:")
;; (add-untranslated-filesystem "Z:\\foo")


;; Local Variables:
;; coding: utf-8-unix
;; End:
