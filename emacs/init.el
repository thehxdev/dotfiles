(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq custom-file "~/.emacs.d/emacs.custom.el")

;; disable line wrap
(set-default 'truncate-lines 1)
(setq default-truncate-lines 1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode -1)
;; (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; enable current line highlight
(global-hl-line-mode 1)

(setq warning-minimum-level :emergency)


;; Disable escape key
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; (text-scale-set 1)
(set-face-attribute 'default nil :height 140)
;; (set-frame-font "CaskaydiaCove Nerd Font Mono-110" nil t)

;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)

(straight-use-package 'use-package)
(straight-use-package 'undo-tree)
;; (straight-use-package 'undo-fu)
(straight-use-package 'goto-chg)
;; (straight-use-package 'lsp-mode)
;; (straight-use-package 'lsp-ui)
;; (straight-use-package 'flycheck)
;; (straight-use-package 'company-mode)
;; (straight-use-package 'lsp-treemacs)
;; (straight-use-package 'lsp-ivy)
;; (straight-use-package 'helm-lsp)
;; (straight-use-package 'dap-mode)
;; (straight-use-package 'sly)
(straight-use-package 'magit)
(straight-use-package 'multiple-cursors)

;; (use-package tree-sitter
;;   :straight t
;;   :init
;;   (require 'tree-sitter))

;; (use-package tree-sitter-langs
;;   :straight t
;;   :init
;;   (require 'tree-sitter-langs))


;; The path to lsp-mode needs to be added to load-path as well as the
;; path to the `clients' subdirectory.
;; (add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))
;; (add-hook 'prog-mode-hook 'lsp-deferred)
;; (require 'lsp-mode)

(use-package vterm
    :straight t)

(use-package all-the-icons
  :straight t
  :if (display-graphic-p))

;; (setq backup-directory-alist
;;     `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;     `((".*" ,temporary-file-directory t))

(setq make-backup-files nil)
(setq backup-by-copying t)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package diminish
  :straight t)

;; (use-package flycheck
;;   :straight t
;;   :defer t
;;   :diminish
;;   :init (global-flycheck-mode))


;; (use-package electric
;;   :init
;;   (electric-pair-mode 1)
;;   (setq electric-pair-preserve-balance nil)) ;; more annoying than useful

;; (use-package company
;;   :straight t
;;   :defer 2
;;   :diminish
;;   :custom
;;   (company-begin-commands '(self-insert-command))
;;   (company-idle-delay .1)
;;   (company-minimum-prefix-length 2)
;;   (company-show-numbers t)
;;   (company-tooltip-align-annotations 't)
;;   (global-company-mode t))

;; (use-package company-box
;;   :straight t
;;   :after company
;;   :diminish
;;   :hook (company-mode . company-box-mode))


(recentf-mode 1)
(setq recentf-max-menu-items 25)
 
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4) ; Assuming you want your tabs to be four spaces wide
(setq indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)

(setq redisplay-dont-pause t
  scroll-margin 4
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)


(defun nuke-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

;; (use-package general
;;   :straight t)

;; Emacs Dashboard
(use-package dashboard
  :straight t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-items '(
                        ;; (recents   . 5)
                        ;; (bookmarks . 5)
                        ;; (projects  . 5)
                        ;; (agenda    . 5)
                        ;; (registers . 5)
                        ))
  :config
  (dashboard-setup-startup-hook))

(use-package which-key
  :straight t
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
      which-key-sort-order #'which-key-key-order
      which-key-allow-imprecise-window-fit nil
      which-key-sort-uppercase-first nil
      which-key-add-column-padding 1
      which-key-max-display-columns nil
      which-key-min-display-lines 6
      which-key-side-window-slot -10
      which-key-side-window-max-height 0.25
      which-key-idle-delay 0.8
      which-key-max-description-length 25
      which-key-allow-imprecise-window-fit nil
      which-key-separator " → " ))


;; (use-package ivy
;;   :straight t
;;   :bind
;;   ;; ivy-resume resumes the last Ivy-based completion.
;;   (("C-c C-r" . ivy-resume)
;;    ("C-x B" . ivy-switch-buffer-other-window))
;;   :diminish
;;   :custom
;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-count-format "(%d/%d) ")
;;   (setq enable-recursive-minibuffers t)
;;   :config
;;   (ivy-mode))

;; (use-package counsel
;;   :straight t
;;   :after ivy
;;   :diminish
;;   :config (counsel-mode))

;; (use-package all-the-icons-ivy-rich
;;   :straight t
;;   :init (all-the-icons-ivy-rich-mode 1))

;; (use-package ivy-rich
;;   :straight t
;;   :after ivy
;;   :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
;;   :custom
;;   (ivy-virtual-abbreviate 'full
;;    ivy-rich-switch-buffer-align-virtual-buffer t
;;    ivy-rich-path-style 'abbrev)
;;   :config
;;   (ivy-set-display-transformer 'ivy-switch-buffer
;;                                'ivy-rich-switch-buffer-transformer))

(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(put 'dired-find-alternate-file 'disabled nil)

(use-package gruber-darker-theme
  :straight t)

;; (require 'gruber-darker-theme)
;; (load-theme 'gruber-darker 1)

(use-package doom-themes
  :straight t
  :init
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-tokyo-night t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))


(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

;;; Programming Languages

;; C/C++
;; (use-package ccls
;;   :straight t
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda ()
;;            (require 'ccls)
;;            (tree-sitter-hl-mode)
;;            (lsp))))
;; (add-hook 'c-mode-hook 'lsp-deferred)
;; (c-set-offset 'syntactic-symbol 4)

;; Golang
;; (use-package go-mode
;;   :straight t
;;   :hook ((go-mode) .
;;          (lambda ()
;;            (require 'go-mode)
;;            (tree-sitter-hl-mode)
;;            (lsp))))
;; (add-hook 'go-mode-hook 'lsp-deferred)


;; Racket
;; (use-package racket-mode
;;   :straight t
;;   :hook ((racket-mode) .
;;          (lambda ()
;;            (require 'racket-mode)
;;            (tree-sitter-hl-mode))))
;; (add-hook 'racket-mode-hook 'lsp-deferred)


;; Nix
;; (use-package nix-mode
;;   :straight t)


;; Clojure
;; (use-package clojure-mode
;;   :straight t)
;; (use-package cider
;;   :straight t)


;; Haskell
;; (use-package haskell-mode
;;   :straight t
;;   :hook ((haskell-mode) .
;;          (lambda ()
;;            (require 'haskell-mode)
;;            (tree-sitter-hl-mode))))

;; Lua
;; (use-package lua-mode
;;   :straight t
;;   :hook ((lua-mode) .
;;          (lambda ()
;;            (require 'lua-mode)
;;            (tree-sitter-hl-mode))))
(use-package lua-mode
  :straight t)


;; Lisp
;; (load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "/home/hx/.local/bin/commonlisp/bin/sbcl")

;; Rust
(use-package rust-mode
  :straight t)

;; Golang
(use-package go-mode
  :straight t)

;; Python
(use-package python-mode
  :straight t)
