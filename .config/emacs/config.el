;;; init.el -*- lexical-binding: t; -*-

;; package management
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; identity
;; (setq user-full-name "john doe"
;;       user-mail-address "john@doe.com")

;; fonts
;; (set-face-attribute 'default nil :family "fira code" :height 120 :weight 'semi-light)
;; (set-face-attribute 'variable-pitch nil :family "fira sans" :height 130)

;; line numbers
(setq display-line-numbers-type t)
(global-display-line-numbers-mode 1)

;; org
(setq org-directory "~/org/")

;; theme
(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox t))

(add-hook 'after-load-theme-hook
          (lambda ()
            (set-face-background 'default "nil")
            (set-face-background 'line-number "nil")
            (set-face-background 'line-number-current-line "nil")))

;; modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-major-mode-icon t)

  (doom-modeline-def-segment my-lambda
    "renders a lambda indicator"
    (propertize " λ " 'face 'bold))

  (doom-modeline-def-modeline 'main
    '(bar matches my-lambda buffer-info remote-host buffer-position)
    '(selection-info lsp debug minor-modes input-method process vcs check)))
