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
(require 'markdown-mode)
;;(reporte 'eww)
;; window number
(require 'window-numbering)
(window-numbering-mode 1)
(global-linum-mode t)
(package-initialize)
(setq url-http-attempt-keepalives nil)

(package-initialize)
(setq url-http-attempt-keepalives nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'before-save-hook 'gofmt-before-save)
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))
;;(setenv "GOPATH" (shell-command-to-string "pwd"))

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
;(setq exec-path (cons "/usr/bin" exec-path))
;(add-to-list 'exec-path "/usr/bin")
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; go config end

;; code solve chinese show problem
(set-language-environment "utf-8")
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system 'utf-8)
(setq-default pathname-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq locale-coding-system 'utf-8)
(set default-buffer-file-coding-system 'utf-8)
;; code end

;; linum
(global-linum-mode t)

;; folding
(require 'origami)
(global-origami-mode)
(global-set-key(kbd "C-c C-c") 'origami-close-node)
(global-set-key(kbd "C-c C-o") 'origami-open-node)

;;
(setq line-number-mode t)
(setq frame-title-format "Welcome to Emacs")
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq visible-bell nil)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;;
;;markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Mardown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; js2-mode end

;; format whole file
(defun indent-whole()
  (interactive)
  (indent-region (point-min)(point-max))
  (message "fomat successfully"))
(global-set-key(kbd "C-c f") 'indent-whole)
;;

(ac-config-default)

(put 'upcase-region 'disabled nil)

(put 'scroll-left 'disabled nil)
