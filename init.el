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
(require 'go-autocomplete)
(require 'popup)

(require 'window-numbering)
(window-numbering-mode 1)
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

(defun auto-complete-for-go ()
    (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(defun go-mode-godef-hook()
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-godef-hook)

(setq exec-path (cons "/usr/bin" exec-path))
(add-to-list 'exec-path "/usr/bin")
(add-hook 'before-save-hook 'gofmt-before-save)

;code
(set-language-environment "UTF-8")
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system 'utf-8)
(setq-default pathname-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;; linum
(global-linum-mode t)

;; folding
(require 'origami)
(global-origami-mode)

(global-set-key(kbd "C-c C-c") 'origami-close-node)
(global-set-key(kbd "C-c C-o") 'origami-open-node)


;theme
(load-theme 'taming-mr-arneson t)

(ac-config-default)


(put 'upcase-region 'disabled nil)
