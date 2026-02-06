;;; golangci-lint.el --- lint for the Go source code

;; Copyright 2013 The Go Authors. All rights reserved.

;; License: BSD-3-clause
;; URL: https://github.com/golang/lint

;;; Commentary:

;; To install golint, add the following lines to your .emacs file:
;;   (add-to-list 'load-path "PATH CONTAINING golint.el" t)
;;   (require 'golint)
;;
;; After this, type M-x golint on Go source code.
;;
;; Usage:
;;   C-x `
;;     Jump directly to the line in your code which caused the first message.
;;
;;   For more usage, see Compilation-Mode:
;;     http://www.gnu.org/software/emacs/manual/html_node/emacs/Compilation-Mode.html

;;; Code:

(require 'compile)

(defun golangci-lint-buffer-name (mode)
  "*Golangci-lint*")

(defun golangci-lint-process-setup ()
  "Setup compilation variables and buffer for `golangci-lint'."
  (run-hooks 'golangci-lint-setup-hook))

(define-compilation-mode golangci-lint-mode "golangci-lint"
  "Golangci-lint is a linter for Go source code."
  (set (make-local-variable 'compilation-scroll-output) nil)
  (set (make-local-variable 'compilation-disable-input) t)
  (set (make-local-variable 'compilation-process-setup-function)
       'golangci-lint-process-setup))

;;;###autoload
(defun golangci-lint ()
  "Run golangci-lint on the current file and populate the fix list.
Pressing \"C-x `\" jumps directly to the line in your code which
caused the first message."
  (interactive)
  (compilation-start
   (mapconcat #'shell-quote-argument
	      (list "revive" "-config" (concat (getenv "HOME") "/.emacs.d/lisp/go/.revive.toml") (expand-file-name buffer-file-name)) " ")
              ;(list "golangci-lint" "--config=~/.emacs.d/lisp/go/.golangci.yml" "run"  (expand-file-name buffer-file-name)) " ")
   'golangci-lint-mode))

(provide 'golangci-lint)

;;;###autoload
(defun golangci-lint-before-save ()
  "Add this to .emacs to run gofmt on the current buffer when saving:
 (add-hook 'before-save-hook 'gofmt-before-save).

Note that this will cause go-mode to get loaded the first time
you save any file, kind of defeating the point of autoloading."

  (interactive)
  (when (not (s-suffix? "_test.go" buffer-file-name)) (when (eq major-mode 'go-mode) (golangci-lint))))

;;; golint.el ends here
