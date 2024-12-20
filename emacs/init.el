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

(setq warning-minimum-level :emergency)
;; (set-frame-font "CaskaydiaCove Nerd Font Mono-110" nil t)

;; disable line wrap
(setq default-truncate-lines t)
;; (text-scale-set 1)
(set-face-attribute 'default nil :height 140)
;; make side by side buffers function the same as the main window
;(setq truncate-partial-width-windows nil)

(straight-use-package 'use-package)
(straight-use-package 'undo-tree)
;; (straight-use-package 'undo-fu)
(straight-use-package 'goto-chg)
;; (straight-use-package 'lsp-mode)
;; (straight-use-package 'lsp-ui)
;; (straight-use-package 'flycheck)
;; (straight-use-package 'company-mode)
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
;; (straight-use-package 'lsp-treemacs)
;; (straight-use-package 'lsp-ivy)
;; (straight-use-package 'helm-lsp)
;; (straight-use-package 'dap-mode)
;; (straight-use-package 'sly)
(straight-use-package 'magit)

;; The path to lsp-mode needs to be added to load-path as well as the
;; path to the `clients' subdirectory.
;; (add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))
;; (add-hook 'prog-mode-hook 'lsp-deferred)
;; (require 'lsp-mode)

(require 'tree-sitter)
(require 'tree-sitter-langs)

(use-package vterm
    :straight t)

(use-package evil
  :straight t
  :init ;; tweak evil's configuration before loading it
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))

(use-package evil-tutor
  :straight t)

(use-package all-the-icons
  :straight t
  :if (display-graphic-p))

;; (use-package all-the-icons-dired
;;   :straight t
;;   :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))


(setq make-backup-files nil)
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


(use-package electric
  :init
  (electric-pair-mode 1)
  (setq electric-pair-preserve-balance nil)) ;; more annoying than useful

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

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(defun nuke-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

(use-package general
  :straight t)
(general-evil-setup)

;; set up 'SPC' as the global leader key
(general-create-definer dt/leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC" ;; set leader
  :global-prefix "M-SPC") ;; access leader in insert mode

(dt/leader-keys
  "b"   '(:ignore t :wk "buffer")
  "b i" '(ibuffer :wk "Switch buffer")
  "b b" '(switch-to-buffer :wk "Switch buffer")
  "b k" '(kill-this-buffer :wk "Kill this buffer")
  "b K" '(nuke-all-buffers :wk "Kill all buffers")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer")
  ;"s h" '(async-shell-command :wk "Execute an async shell command")
  "s h" '(shell-command :wk "Execute a shell command")
  "s c" '(sly-compile-and-load-file :wk "Compile and load .lisp files in sly")
  "."   '(find-file :wk "Find file")
  "f r" '(recentf-open :wk "Find file")
  "c l" '(comment-line :wk "Comment lines")
  )

(dt/leader-keys
  "e" '(:ignore t :wk "Eshell/Evaluate")
  "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
  "e d" '(eval-defun :wk "Evaluate defun containing or after point")
  "e e" '(eval-expression :wk "Evaluate and elisp expression")
  "e h" '(counsel-esh-history :which-key "Eshell history")
  "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
  "e r" '(eval-region :wk "Evaluate elisp in region")
  "e s" '(eshell :which-key "Eshell")
  )

(dt/leader-keys
  "h" '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable")
  "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :wk "Reload emacs config")
  ;;"h r r" '(reload-init-file :wk "Reload emacs config")
  )

(dt/leader-keys
  "t" '(:ignore t :wk "Toggle")
  "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
  "t t" '(visual-line-mode :wk "Toggle truncated lines")
  ;"t v" '(vterm-toggle :wk "Toggle vterm")
  )

(dt/leader-keys
  "w" '(:ignore t :wk "Windows")
  ;; Window splits
  "w c" '(evil-window-delete :wk "Close window")
  "w n" '(evil-window-new :wk "New window")
  "w s" '(evil-window-split :wk "Horizontal split window")
  "w v" '(evil-window-vsplit :wk "Vertical split window")
  ;; Window motions
  "w h" '(evil-window-left :wk "Window left")
  "w j" '(evil-window-down :wk "Window down")
  "w k" '(evil-window-up :wk "Window up")
  "w l" '(evil-window-right :wk "Window right")
  "w w" '(evil-window-next :wk "Goto next window")
  ;; Move Windows
  "w H" '(buf-move-left :wk "Buffer move left")
  "w J" '(buf-move-down :wk "Buffer move down")
  "w K" '(buf-move-up :wk "Buffer move up")
  "w L" '(buf-move-right :wk "Buffer move right")
  )

;; Emacs Dashboard
(use-package dashboard
  :straight t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;(setq dashboard-startup-banner "/home/dt/.config/emacs/images/dtmacs-logo.png")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '(
                          ;(recents . 5)
                          ;(agenda . 5 )
                          ;(bookmarks . 3)
                          ;(projects . 3)
                          ;(registers . 3)
                          ))
  (dashboard-modify-heading-icons '(
                                    ;(recents . "file-text")
                                    ;(bookmarks . "book")
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

;; (use-package counsel
;;   :straight t
;;   :after ivy
;;   :diminish
;;   :config (counsel-mode))

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

(use-package gruber-darker-theme
  :straight t)
(require 'gruber-darker-theme)
(load-theme 'gruber-darker 1)
(global-hl-line-mode 1)

;; (use-package doom-themes
;;   :straight t)

;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;     doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; (load-theme 'doom-one t)
;; ;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)
;; ;; Enable custom neotree theme (all-the-icons must be installed!)
;; (doom-themes-neotree-config)
;; ;; or for treemacs users
;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;; (doom-themes-treemacs-config)
;; ;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)



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

; Golang
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


;; Lisp
;; (load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "/home/hx/.local/bin/commonlisp/bin/sbcl")

;; Rust
;; (use-package rust-mode
;;   :straight t)

;; Golang
;; (use-package go-mode
;;   :straight t)
