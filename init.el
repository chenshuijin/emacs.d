(setq emacs-load-start-time (current-time))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(package-initialize)
;;(package-refresh-contents)
;;(set package-check-signature nil)

;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/color-themes/" t)
(require 'color-theme)
(color-theme-initialize)
(load-theme 'material t)
;;(load-theme 'material t)
;;(color-theme-taming-mr-arneson)
;; neotree
(require 'neotree)
(global-set-key(kbd "C-c n") 'neotree-toggle)
;;(global-set-key "\C-h" 'backward-delete-char-untabify)
;;(global-set-key "\d" 'delete-char)
(require 'unicad)
(require 'auto-complete)
;(require 'go-mode)
(require 'auto-complete-config)
;(require 'go-autocomplete)
(require 'popup)
(require 'window-numbering)
(window-numbering-mode 1)
(global-linum-mode t)

(package-initialize)
(setq url-http-attempt-keepalives nil)

(unless (require 'use-package nil t)
  (package-refresh-contents)
  (package-install 'use-package))

;; slime
(require 'slime-autoloads)
(setq inferior-lisp-program "sbcl")
;; slime

;;
(require 'protobuf-mode)
(setq auto-mode-alist  (cons '(".proto$" . protobuf-mode) auto-mode-alist))

(defconst my-protobuf-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
	  (lambda () (c-add-style "my-style" my-protobuf-style t)))

;; clang-format
(require 'clang-format)
;;(global-set-key (kbd "C-c C-f") 'clang-format-region)

;;(defun clangfmt-before-save ()
;;  (interactive)
;;  (when (eq major-mode 'protobuf-mode) (clang-format-buffer)))

;;(add-hook 'before-save-hook 'clangfmt-before-save)


;; clang-format end

;;
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
;;(add-hook 'before-save-hook 'require-final-newline)
(setq require-final-newline t)


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
					;   (exec-path-from-shell-copy-env "GOPATH"))

;; go config
;;(require 'golint)
(require 'golangci-lint)
;; 启用 go-mode
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; 配置 eglot
(use-package eglot
  :ensure t
  :config
  (add-hook 'go-mode-hook 'eglot-ensure))

;; 保存时自动格式化
(add-hook 'go-mode-hook
        (lambda ()
          (add-hook 'before-save-hook 'gofmt-before-save nil t)))

;; 配置 gopls 特定选项
(setq gopls-arguments '("-remote=auto" "-logfile=/tmp/gopls.log"))
(add-hook 'go-mode-hook
        (lambda ()
          (setq-local lsp-header-line-format "gopls")))

;; go config end

;; hot-key
(defun kill-other-buffers()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (neo-global--get-buffer) (delq (current-buffer) (buffer-list)))))

(global-set-key(kbd "C-c k") 'kill-other-buffers)

;; hot-key-end

;; code solve chinese show problem
(set-language-environment "utf-8")
;;(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system 'utf-8)
(setq-default pathname-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq locale-coding-system 'utf-8)

;;(set default-buffer-file-coding-system 'utf-8)

;; code end

;; folding
(require 'origami)
(global-origami-mode)
(global-set-key(kbd "C-c c") 'origami-close-node)
(global-set-key(kbd "C-c o") 'origami-open-node)

;;
(setq line-number-mode t)
(setq column-number-mode t)
(setq frame-title-format "Welcome to Emacs")
(menu-bar-mode -1)
(when window-system (tool-bar-mode -1))
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

;; js-mode
(autoload 'js2-mode "js2-mode"
  "Major mode for editing JAVASCRIPT files" t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
	  (funcall (cdr my-pair)))))
(add-hook 'web-mode-hook #'(lambda ()
                             (enable-minor-mode
                              '("\\.jsx?\\'" . prettier-js-mode))))
;; json-mode
(autoload 'json-mode "json-mode"
  "Major mode for editing JSON files" t)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.jsonld$" . json-mode))

;;(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'json-mode-hook 'prettier-js-mode)

;; rust-mode
(require 'rust-mode)
;;(add-hook 'rust-mode-hook 'lsp-deferred)
(add-hook 'rust-mode-hook 'eglot-ensure)
(setq rust-format-on-save t)

;; end rust-mode

;; format whole file
(defun indent-whole()
  (interactive)
  (indent-region (point-min)(point-max))
  (message "fomat successfully"))
(global-set-key(kbd "C-c f") 'indent-whole)

;;
;; solidity mode
;;
;;(require 'solidity-mode)


;; python elpy
(require 'elpy)
(elpy-enable)
(setq elpy-rpc-backend 'jedi)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

;; ggtags
;;(require 'ggtags)
;;(add-hook 'c-mode-common-hook
;;	  (lambda ()
;;	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;	      (ggtags-mode 1))))

(ac-config-default)

(put 'upcase-region 'disabled nil)

(put 'scroll-left 'disabled nil)

;(setq original-y-or-n-p 'y-or-n-p)
;(defalias 'original-y-or-n-p (symbol-function 'y-or-n-p))
;(defun default-yes-sometimes (prompt)
;  (if (or
;       (string-match "Really proceed with writing" prompt)
;      t
;      (original-y-or-n-p prompt)))
;(defalias 'yes-or-no-p 'default-yes-sometimes)
;(defalias 'y-or-n-p 'default-yes-sometimes)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (eglot lsp-mode rust-mode slime go-mode ## rope-read-mode py-autopep8 flycheck elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
