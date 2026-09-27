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

;; evil
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-goggles
  :after evil
  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

;; completion
(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :init (marginalia-mode))

(use-package corfu
  :init (global-corfu-mode)
  :config
  (setq corfu-auto t
        corfu-auto-prefix 2))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package company
  :init (global-company-mode))

;; ui
(use-package dashboard
  :init (dashboard-setup-startup-hook))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package hl-todo
  :init (global-hl-todo-mode))

(use-package treemacs)
(use-package treemacs-evil :after (treemacs evil))

(use-package vi-tilde-fringe
  :hook (prog-mode . vi-tilde-fringe-mode))

(use-package diff-hl
  :init (global-diff-hl-mode))

(use-package which-key
  :init (which-key-mode))

(use-package popper
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*" "Output\\*$" help-mode compilation-mode))
  (popper-mode 1)
  (popper-echo-mode 1))

(use-package perspective
  :init (persp-mode))

;; editor
(use-package yasnippet
  :init (yas-global-mode 1))
(use-package yasnippet-snippets :after yasnippet)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(use-package ws-butler
  :init (ws-butler-global-mode))

(use-package auto-insert
  :init (auto-insert-mode))

;; emacs
(use-package undo-fu)
(use-package undo-fu-session
  :init (global-undo-fu-session-mode))

(use-package dired-x
  :ensure nil)

;; checkers
(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode))

;; tools
(use-package eros
  :init (eros-mode 1))

(use-package dumb-jump
  :init (add-to-list 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package eglot
  :ensure nil
  :hook ((c-mode c++-mode csharp-mode) . eglot-ensure))

(use-package magit)

(use-package treesit-auto
  :init
  (setq treesit-auto-install t)
  (global-treesit-auto-mode))

;; os
(when (eq system-type 'darwin)
  (use-package exec-path-from-shell
    :init (exec-path-from-shell-initialize)))

;; lang
(use-package csharp-mode)
(use-package markdown-mode)

;; smartparens
(use-package smartparens
  :init (smartparens-global-mode 1))

;; bindings: define your own keymaps below
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auto-insert cape company corfu dashboard diff-hl doom-modeline
		 doom-themes dumb-jump emojify eros evil
		 evil-collection evil-goggles hl-todo magit marginalia
		 markdown-mode orderless perspective popper
		 smartparens treemacs treemacs-evil treesit-auto
		 undo-fu undo-fu-session vertico vi-tilde-fringe
		 ws-butler yasnippet yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-change-face ((t (:inherit diff-removed))))
 '(evil-goggles-delete-face ((t (:inherit diff-removed))))
 '(evil-goggles-paste-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-add-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-change-face ((t (:inherit diff-changed))))
 '(evil-goggles-undo-redo-remove-face ((t (:inherit diff-removed))))
 '(evil-goggles-yank-face ((t (:inherit diff-changed)))))
