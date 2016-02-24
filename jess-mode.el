;;; JESS mode --- a major mode for working with .clp files to be used with
;;; the JESS rule engine
;;; Author: Elina Sendonaris
;;; Version: 0.2
;;; Creation date: 1/25/16
;;; Last modified: 2/19/16

;; To open this mode automatically for .clp files name this file 'jess-mode.el',
;; place this file in your emacs loadpath directory, and include the following 
;; lines in your .emacs:
;; (load-library "jess-mode")
;; (add-to-list 'auto-mode-alist '("\\.clp\\'" . jess-mode))
;; In order to make all tabs into spaces (however many are specified by jess-tab
;; -width), put the following line in your .emacs:
;; (setq-default indent-tabs-mode nil)

(defvar jess-keywords
  '("for" "while" "if" "then" "else" "return" "deffunction" "defrule" "bind" "and" "not" "or" "+" "-" "*" "/" "++" "<=" ">=" ">" "<" "=" "**" "--" "lambda" "break" "continue" "do" "&~" "&" "~"))

(defvar jess-constants
  '("TRUE" "FALSE" "=>"))

(defvar jess-list-funcs
   '("insert$" "list" "nth$" "member$" "length$" "implode$" "intersection$" "create$" "delete$" "first$" "explode$" "length$" "union$"))

(defvar jess-math-funcs
   '("abs" "div" "e" "eq" "eq*" "exp" "float" "integer" "log" "log10" "long" "max" "min" "mod" "neq" "pi" "random" "round" "sqrt"))

(defvar jess-rule-funcs
   '("clear" "reset" "agenda" "bload" "bsave" "build" "batch" "eval" "exit" "focus" "get-current-module" "get-focus" "get-focus-stack" "get-reset-globals" "defadvice" "clear-focus-stack" "engine" "get-salience-evaluation" "get-strategy" "halt" "list-focus=stack" "pop-focus" "provide" "require" "require*" "run" "run-until-halt" "set-current-module" "set-node-index-hash" "set-reset-globals" "set-salience-evaluation" "set-strategy" "undefadvice" "undeffacts" "undefrule"))

(defvar jess-fact-funcs
   '("assert" "assert-string" "dependencies" "dependents" "duplicate" "fact-id" "fact-slot-value" "facts" "load-facts" "modify" "remove" "retract" "retract-string" "save-facts" "save-facts-xml"))

(defvar jess-type-funcs
   '("evenp" "external-addressp" "floatp" "integerp" "java-objectp" "lexemep" "listp" "longp" "multifieldp" "numberp" "oddp" "subsetp" "symbolp"))

(defvar jess-str-funcs
  '("lowcase" "upcase" "str-cat" "str-compare" "sub-string" "str-length" "str-index" "sym-cat" "asc"))

(defvar jess-io-funcs
   '("close" "format" "get-multithreaded-io" "open" "printout" "read" "readline" "set-multithreaded-io" "socket" "crlf"))

(defvar jess-functions
   (append jess-str-funcs jess-type-funcs jess-fact-funcs jess-rule-funcs jess-math-funcs jess-list-funcs jess-io-funcs '("deftemplate")))

(defvar jess-tab-width 3)

(defvar jess-font-lock-defaults
  `((
     ( ,"\?[a-z-1234567890]+" . font-lock-variable-name-face)
     ( ,"\?" . font-lock-keyword-face)
     ( ,(regexp-opt jess-keywords 'words) . font-lock-keyword-face)
     ( ,(regexp-opt jess-functions 'words) . font-lock-builtin-face)
     ( ,(regexp-opt jess-constants 'words) . font-lock-constant-face)
     ( ,"\\|/*\\|*/" . font-lock-comment-delimiter-face)
     )))

(defvar jess-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?/ ". 14" st)
    (modify-syntax-entry ?* ". 23b" st)
    (modify-syntax-entry ?\n ">" st)
    (modify-syntax-entry ?; "<" st)
    (modify-syntax-entry ?? "w" st)
    (modify-syntax-entry ?+ "w" st)
    (modify-syntax-entry ?- "w" st)
    (modify-syntax-entry ?= "w" st)
    (modify-syntax-entry ?< "w" st)
    (modify-syntax-entry ?> "w" st)
    st)
  "Syntax table for JESS mode")

(define-derived-mode jess-mode lisp-interaction-mode "JESS Mode"
  "JESS mode is a major mode for editing .clp files to be used with the JESS rule engine"
  :syntax-table jess-mode-syntax-table
  (setq font-lock-defaults jess-font-lock-defaults)
  (setq tab-width jess-tab-width)
  (setq comment-start ";")
  (setq comment-start-skip ";+\\s-*")
  (setq comment-end "\n")
  (setq lisp-body-indent jess-tab-width)
  )

(provide 'jess-mode)
