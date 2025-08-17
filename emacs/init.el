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

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode 1)

(setq-default inhibit-splash-screen t
              backup-by-copying t
              auto-save-default nil
              create-lockfiles nil
              make-backup-files nil
              tab-width 4
              c-basic-offset 4
              indent-line-function 'insert-tab
              compilation-scroll-output t
              truncate-lines 1
              default-truncate-lines 1
              visible-bell (equal system-type 'windows-nt))

(indent-tabs-mode nil)
(electric-indent-mode 1)
(electric-pair-mode -1)

(setq warning-minimum-level :emergency)

;; Disable escape key
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; (set-face-attribute 'default nil :height 140)
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-14"))

;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)

(straight-use-package 'use-package)

(use-package tree-sitter
  :straight t
  :init
  (require 'tree-sitter))

(use-package tree-sitter-langs
  :straight t
  :after tree-sitter
  :init
  (require 'tree-sitter-langs))

(global-tree-sitter-mode)
;; (add-hook 'c-mode-hook #'tree-sitter-hl-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)


(use-package multiple-cursors
  :straight t)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(use-package diminish
  :straight t)

;; (use-package electric
;;   :straight t
;;   :init
;;   (electric-pair-mode 1)
;;   (setq electric-pair-preserve-balance nil)) ;; more annoying than useful

;; (setq electric-pair-inhibit-predicate
;;       `(lambda (c)
;;          (if (or (char-equal c ?\") (char-equal c ?\'))
;;              t
;;            (,electric-pair-inhibit-predicate c))))

(recentf-mode 1)
(setq recentf-max-menu-items 25)
 
(setq redisplay-dont-pause t
  scroll-margin 4
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

(defun nuke-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

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

(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching 1)
(setq ido-use-filename-at-point 'guess)
(put 'dired-find-alternate-file 'disabled nil)

(use-package ivy
  :straight t
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer))
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))

(use-package counsel
  :straight t
  :after ivy
  :diminish
  :config (counsel-mode))

(use-package all-the-icons-ivy-rich
  :straight t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :straight t
  :after ivy
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev))
  ;; :config
  ;; (ivy-set-display-transformer 'ivy-switch-buffer
  ;;                              'ivy-rich-switch-buffer-transformer))

(setopt ivy-use-virtual-buffers t)
(setopt enable-recursive-minibuffers t)
(setopt search-default-mode #'char-fold-to-regexp)
(keymap-global-set "C-s" #'swiper-isearch)
;; (keymap-global-set "C-c C-r" #'ivy-resume)
;; (keymap-global-set "<f6>" #'ivy-resume)
(keymap-global-set "M-x" #'counsel-M-x)
(keymap-global-set "M-p" #'counsel-fzf)
(keymap-global-set "C-x C-f" #'counsel-find-file)
(keymap-global-set "<f1> f" #'counsel-describe-function)
(keymap-global-set "<f1> v" #'counsel-describe-variable)
(keymap-global-set "<f1> o" #'counsel-describe-symbol)
(keymap-global-set "<f1> l" #'counsel-find-library)
(keymap-global-set "<f2> i" #'counsel-info-lookup-symbol)
(keymap-global-set "<f2> u" #'counsel-unicode-char)
(keymap-global-set "C-c g" #'counsel-git)
(keymap-global-set "C-c j" #'counsel-git-grep)
;; (keymap-global-set "C-c k" #'counsel-ag)
;; (keymap-global-set "C-x l" #'counsel-locate)
;; (keymap-global-set "C-S-o" #'counsel-rhythmbox)
(keymap-set minibuffer-local-map "C-r" #'counsel-minibuffer-history)


(use-package doom-themes
  :straight t
  :init
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-tokyo-night t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))


(use-package markdown-mode
  :straight t
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

(use-package company
  :straight t
  :init
  (global-company-mode)
  (define-key company-active-map [escape] 'company-abort))

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
;; (use-package lua-mode
;;   :straight t)


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
