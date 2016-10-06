(setq emacs-load-start-time (current-time))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/color-themes/" t)
(require 'color-theme)
(color-theme-initialize)
(load-theme 'material t)
;;(load-theme 'material t)
;;(color-theme-taming-mr-arneson)
;; neotree
(require 'neotree)

(require 'unicad)
(require 'auto-complete)
(require 'go-mode)
(require 'auto-complete-config)
(require 'go-autocomplete)
(require 'popup)
;; window number
(require 'window-numbering)
(window-numbering-mode 1)
(global-linum-mode t)
(package-initialize)
(setq url-http-attempt-keepalives nil)

(package-initialize)
(setq url-http-attempt-keepalives nil)

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

;; go config
(defun auto-complete-for-go ()
    (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(defun go-mode-godef-hook()
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-godef-hook)
(setq exec-path (cons "/usr/bin" exec-path))
(add-to-list 'exec-path "/usr/bin")
(add-hook 'before-save-hook 'gofmt-before-save)
;; go config end

;; code solve chinese show problem
(set-language-environment "utf-8")
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set default-buffer-file-coding-system 'utf-8)
;; code end

;;
(setq line-number-mode t)
(setq frame-title-format "Welcome to Emacs")
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;;

(ac-config-default)

(put 'upcase-region 'disabled nil)

