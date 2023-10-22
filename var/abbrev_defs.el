;;; 未开启 ‘lexical-binding’, 原文件如此.

;; Abbrev 展开的顺序似乎是:
;;   1. 先替换为目标文本.
;;   2. 运行勾函数.
;;   3. 插入分割字符.

(defun shynur/abbrev:e.g.->E.g.\,\  ()
  "作为扩展的勾函数, 在用户键入 “eg”+逗号 后 (此处仅以 “eg” 为例), “eg” 被扩展为 “e.g.”, 然后,
1. 判断是否需要首字母大写, 如有必要则将其替换为 “E.g.”.
2. 在其后添加 逗号 和 空格 (并删除原有的多余的空白字符).
3. 阻止用户键入的那个 逗号 被插入."
  (when (eq last-command-event ?,)
    (save-excursion
      ;; 检测是否需要将 “e.g.” 替换为 “E.g.”.
      (backward-sentence)
      (re-search-forward (rx point
                             (one-or-more (or ?\s ?\n ?\t ?\r
                                              ?' ?\" ?‘ ?’ ?“ ?\”
                                              (or ?\( ?\))
                                              ?/
                                              )))
                         nil t 1)
      (when (= (point) last-abbrev-location)
        (upcase-char 1)))
    (insert-char ?,)
    (insert-char ?\s) (backward-char) (with-restriction (point) (line-end-position)
                                        (c-hungry-delete-forward))
    (insert-char ?\s)
    ;; 返回 non-nil 值, 以阻止用户键入的字符被插入.
    "不要插入用户键入的那个 逗号"))
(put 'shynur/abbrev:e.g.->E.g.\,\  'no-self-insert t)

;; TODO: 该 abbrev 表中的某些词条应当放入到 ‘text-mode-abbrev-table’ 中.
(define-abbrev-table 'global-abbrev-table
  `(
    ("1021"   "10215102427")
    ("eg"     "e.g."       shynur/abbrev:e.g.->E.g.\,\ )
    ("elisp"  "Emacs Lisp")
    ("gnu"    "GNU")
    ("ie"     "i.e."       shynur/abbrev:e.g.->E.g.\,\ )
    ("ios"    "iOS")
    ("js"     "JavaScript")
    ("linux"  "Linux")
    ("nb"     "n.b."       shynur/abbrev:e.g.->E.g.\,\ )
    ("sql"    "SQL")
    ("sqlite" "SQLite")
    ))

(define-abbrev-table 'sql-mode-abbrev-table
  `(
    ("add"           "ADD")
    ("alter"         "ALTER TABLE")
    ("and"           "AND")
    ("as"            "AS")
    ("asc"           "ASC")
    ("begin"         "BEGIN")
    ("between"       "BETWEEN AND "             ,(lambda ()
                                                   (backward-char 5)))
    ("binary"        "BINARY")
    ("bit"           "BIT")
    ("char"          "CHAR)"                    backward-char)
    ("check"         "CHECK()"                  ,(lambda ()
                                                   (backward-char 2)
                                                   (make-thread (lambda ()
                                                                  (thread-yield)
                                                                  (forward-char)))))
    ("close"         "CLOSE")
    ("column"        "COLUMN")
    ("commit"        "COMMIT")
    ("constraint"    "CONSTRAINT")
    ("count"         "COUNT)"                   backward-char)
    ("create"        "CREATE")
    ("cursor"        "CURSOR")
    ("date"          "DATE")
    ("datetime"      "DATETIME")
    ("dbms"          "DBMS")
    ("decimal"       "DECIMAL")
    ("declare"       "DECLARE")
    ("default"       "DEFAULT")
    ("delete"        "DELETE FROM")
    ("desc"          "DESC")
    ("distinct"      "DISTINCT")
    ("drop"          "DROP")
    ("end"           "END")
    ("execute"       "EXECUTE")
    ("fetch"         "FETCH")
    ("float"         "FLOAT")
    ("for"           "FOR")
    ("foreign"       "FOREIGN KEY() REFERENCES" ,(lambda ()
                                                   (backward-char 13)
                                                   (make-thread (lambda ()
                                                                  (thread-yield)
                                                                  (forward-char)))))
    ("from"          "FROM")
    ("grant"         "GRANT")
    ("group"         "GROUP BY")
    ("in"            "IN)"                      backward-char)
    ("index"         "INDEX")
    ("inner"         "INNER JOIN ON "           ,(lambda ()
                                                 (backward-char 4)))
    ("insert"        "INSERT")
    ("int"           "INT")
    ("integer"       "INTEGER")
    ("into"          "INTO")
    ("is"            "IS")
    ("left"          "LEFT")
    ("like"          "LIKE''"                   ,(lambda ()
                                                   (backward-char 2)
                                                   (make-thread (lambda ()
                                                                  (thread-yield)
                                                                  (forward-char)))))
    ("natural"       "NATURAL JOIN")
    ("nchar"         "NCHAR")
    ("not"           "NOT")
    ("null"          "NULL")
    ("number"        "NUMBER")
    ("numeric"       "NUMERIC")
    ("nvarchar"      "NVARCHAR")
    ("open"          "OPEN")
    ("or"            "OR")
    ("order"         "ORDER BY")
    ("outer"         "OUTER JOIN ON "           ,(lambda ()
                                                   (backward-char 4)))
    ("primary"       "PRIMARY KEY")
    ("procedure"     "PROCEDURE")
    ("raw"           "RAW")
    ("real"          "REAL")
    ("references"    "REFERENCES()"             ,(lambda ()
                                                   (backward-char 2)))
    ("revoke"        "REVOKE")
    ("rollback"      "ROLLBACK")
    ("save"          "SAVE")
    ("savepoint"     "SAVEPOINT")
    ("select"        "SELECT")
    ("set"           "SET")
    ("smalldatetime" "SMALLDATETIME")
    ("smallint"      "SMALLINT")
    ("table"         "TABLE")
    ("time"          "TIME")
    ("timestamp"     "TIMESTAMP")
    ("tinyint"       "TINYINT")
    ("transaction"   "TRANSACTION")
    ("trigger"       "TRIGGER")
    ("truncate"      "TRUNCATE TABLE")
    ("update"        "UPDATE SET "              ,(lambda ()
                                                   (backward-char 5)))
    ("values"        "VALUES)"                  backward-char)
    ("varbinary"     "VARBINARY")
    ("varchar"       "VARCHAR")
    ("view"          "VIEW")
    ("where"         "WHERE")
    ))

;; Local Variables:
;; coding: utf-8-unix
;; no-byte-compile: nil
;; eval: (display-fill-column-indicator-mode)  ; 用来目测每列是否对齐.
;; eval: (abbrev-mode)  ; 开启该模式, 便于测试.
;; End:
