(setq emacs-load-start-time (current-time))
;(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;;--------------------------------------------------------------
;; To solve the chinese coding problem
;;--------------------------------------------------------------
;;----end----
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/color-themes/")
(load-theme 'taming-mr-arneson t)
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(require 'unicad)
(require 'auto-complete)
(require 'go-mode)
(require 'auto-complete-config)
(require 'popup)

(package-initialize)
(setq url-http-attempt-keepalives nil)
;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(add-hook 'before-save-hook 'gofmt-before-save)
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))
;(when (memq window-system '(mac ns))
;   (exec-path-from-shell-initialize)
;    (exec-path-from-shell-copy-env "GOPATH"))

(defun auto-complete-for-go ()
    (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(defun go-mode-godef-hook()
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-godef-hook)

(with-eval-after-load 'go-mode
  (require 'go-autocomplete))
  
(setq exec-path (cons "/Users/chenshuijin/git/go/go/bin" exec-path))
(add-to-list 'exec-path "/Users/chenshuijin/git/go/go/bin")
(add-hook 'before-save-hook 'gofmt-before-save)

(load-theme 'taming-mr-arneson t)

(ac-config-default)











