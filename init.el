(setq emacs-load-start-time (current-time))
;(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;;--------------------------------------------------------------
;; To solve the chinese coding problem
;;--------------------------------------------------------------
 (set-fontset-font "fontset-default"
 'gb18030 '("Microsoft YaHei" . "unicode-bmp"))
;;----end----
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(setq url-http-attempt-keepalives nil)
;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(require 'unicad)
(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)
(require 'auto-complete-config)
(ac-config-default)
