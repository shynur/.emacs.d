;; 未开启 ‘lexical-binding’, 原文件如此.

(define-abbrev-table 'global-abbrev-table
  `(
    ("JS" "JavaScript")
    ))

(define-abbrev-table 'sql-mode-abbrev-table
  `(
    ("BtAd" "BETWEEN AND "
     ,(lambda nil (backward-char 5)))
    ("Ct" "COUNT)"
     backward-char)
    ("Dp" "DROP")
    ("Dstct" "DISTINCT")
    ("GrpB" "GROUP BY")
    ("Hv" "HAVING")
    ("I" "IN)"
     backward-char)
    ("IsN" "IS NULL")
    ("IstIt" "INSERT INTO")
    ("Lk" "LIKE '"
     backward-char)
    ("OdB" "ORDER BY")
    ("SlctFr" "SELECT FROM "
     ,(lambda () (backward-char 6)))
    ("Tb" "TABLE")
    ("Vls" "VALUES)"
     backward-char)
    ("We" "WHERE")
   ))

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
