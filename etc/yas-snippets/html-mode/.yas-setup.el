;;; -*- lexical-binding: t; -*-

(defun shynur/snippet:html-attr (&rest attributes)
  "Return [ style=\"XXX: xxx; XXX: xxx;\" id=xxx class=xxx]."
  (seq-doseq (attr ["class"
                    "id"
                    "style"
                    ""])
    (push attr attributes))
  (mapconcat (lambda (attr-pair)
               (if-let (attr-val (cdr attr-pair))
                   (format " %s=\"%s\""
                           (car attr-pair)
                           attr-val)
                 ""))
             (let ((used-attributes (list))
                   attr-key)
               (while (not (string-empty-p (setq attr-key (completing-read #("Which attribute? (empty string to exit) "
                                                                             6 15 (face (bold italic)))
                                                                           attributes))))
                 (setq attributes (delete attr-key attributes))
                 (push (cons attr-key (pcase (setq attr-key (propertize attr-key
                                                                        'face '(bold italic)))
                                        ("style" (let ((shynur/snippet:html-attr-style (shynur/snippet:html-attr-style)))
                                                   (when (not (string-empty-p shynur/snippet:html-attr-style))
                                                     shynur/snippet:html-attr-style)))
                                        ((or "start"
                                             "value") (number-to-string (read-number (format "%s="
                                                                                             attr-key))))
                                        (_ (let ((attr-val (read-string (format "%s="
                                                                                attr-key))))
                                             (when (not (string-empty-p attr-val))
                                               attr-val)))))
                       used-attributes))
               (reverse used-attributes))))

(defun shynur/snippet:html-attr-style ()
  "Return [XXX: xxx; XXX: xxx;]."
  (mapconcat (lambda (style-pair)
               (format "%s: %s;"
                       (car style-pair)
                       (cdr style-pair)))
             (let ((styles (list "list-style-type"
                                 ""))
                   (used-styles (list))
                   style-key)
               (while (not (string-empty-p (setq style-key (completing-read #("Which style? (empty string to exit) "
                                                                              6 11 (face (bold italic)))
                                                                            styles))))
                 (setq styles (delete style-key styles))
                 (push (cons style-key (pcase (setq style-key (propertize style-key
                                                                          'face '(bold italic)))
                                         ("list-style-type" (completing-read (format "style=%s: "
                                                                                     style-key)
                                                                             '("decimal"
                                                                               "lower-alpha"
                                                                               "lower-roman"
                                                                               "upper-alpha"
                                                                               "upper-roman"
                                                                               )))
                                         (_ (read-string (format "style=%s: "
                                                                 style-key)))))
                       used-styles))
               (reverse used-styles))
             " "))

;; Local Variables:
;; coding: utf-8-unix
;; End:
