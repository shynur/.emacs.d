;; 未开启 ‘lexical-binding’, 原文件如此.

(define-abbrev-table 'global-abbrev-table
  `(
    ("JS" "JavaScript")
    ))

(define-abbrev-table 'sql-mode-abbrev-table
  `(
    ("btad" "BETWEEN AND "
     ,(lambda nil (backward-char 5)))
    ("ct" "COUNT)"
     backward-char)
    ("dstct" "DISTINCT")
    ("grpb" "GROUP BY")
    ("i" "IN)"
     backward-char)
    ("isn" "IS NULL")
    ("istit" "INSERT INTO")
    ("injo" "INNER JOIN ON "
     ,(lambda () (backward-char 4)))
    ("lk" "LIKE '"
     backward-char)
    ("odb" "ORDER BY")
    ("prmrk" "PRIMARY KEY")
    ("ntn" "NOT NULL")
    ("slctfr" "SELECT FROM "
     ,(lambda () (backward-char 6)))
    ("vls" "VALUES)"
     backward-char)
   ))

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; End:
