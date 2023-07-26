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


;; Local Variables:
;; coding: utf-8-unix
;; End:
