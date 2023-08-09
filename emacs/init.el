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


(straight-use-package 'use-package)
(straight-use-package 'evil)
(straight-use-package 'undo-tree)
(straight-use-package 'undo-fu)
(straight-use-package 'goto-chg)
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)
(straight-use-package 'flycheck)
(straight-use-package 'flycheck)
(straight-use-package 'company-mode)
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(straight-use-package 'lsp-treemacs)
(straight-use-package 'lsp-ivy)
(straight-use-package 'helm-lsp)
(straight-use-package 'dap-mode)
(straight-use-package 'all-the-icons)

;; The path to lsp-mode needs to be added to load-path as well as the
;; path to the `clients' subdirectory.
(add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))
(add-hook 'prog-mode-hook 'lsp-deferred)

(require 'tree-sitter)
(require 'tree-sitter-langs)

(setq make-backup-files nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(electric-pair-mode)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4) ; Assuming you want your tabs to be four spaces wide
;; (defvaralias 'c-basic-offset 'tab-width)

(setq redisplay-dont-pause t
  scroll-margin 4
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(require 'evil)
(evil-mode 1)


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
  "b b" '(switch-to-buffer :wk "Switch buffer")
  "b k" '(kill-this-buffer :wk "Kill this buffer")
  "b K" '(nuke-all-buffers :wk "Kill this buffer")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer")
  "s h" '(async-shell-command :wk "Execute a shell command")
  "."   '(find-file :wk "Find file")
  "f r" '(recentf-open-files :wk "Find file")
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

;;(set-face-attribute 'default nil
;;  :font "JetBrains Mono"
;;  :height 110
;;  :weight 'medium)
;;(set-face-attribute 'variable-pitch nil
;;  :font "Ubuntu"
;;  :height 120
;;  :weight 'medium)
;;(set-face-attribute 'fixed-pitch nil
;;  :font "JetBrains Mono"
;;  :height 110
;;  :weight 'medium)

;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
;;(set-face-attribute 'font-lock-comment-face nil
;;  :slant 'italic)
;;(set-face-attribute 'font-lock-keyword-face nil
;;  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
;;(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Uncomment the following line if line spacing needs adjusting.
;;(setq-default line-spacing 0.12)


;;(use-package toc-org
;;    :commands toc-org-enable
;;    :init (add-hook 'org-mode-hook 'toc-org-enable))

;;(add-hook 'org-mode-hook 'org-indent-mode)
;;(use-package org-bullets)
;;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package which-key
  :straight t)

(which-key-mode 1)
(setq which-key-side-window-location 'bottom
  which-key-sort-order #'which-key-key-order-alpha
  which-key-sort-uppercase-first nil
  which-key-add-column-padding 1
  which-key-max-display-columns nil
  which-key-min-display-lines 6
  which-key-side-window-slot -10
  which-key-side-window-max-height 0.25
  which-key-idle-delay 0.8
  which-key-max-description-length 25
  which-key-allow-imprecise-window-fit t
  which-key-separator " → ")

(use-package doom-themes
  :straight t)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
    doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-one t)
;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
(doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;(require 'lsp-mode)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.1) ;; default is 0.2

;;; Programming Languages

; C/C++
(use-package ccls
  :straight t
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda ()
           (require 'ccls)
           (tree-sitter-hl-mode)
           (lsp))))

; Golang
(use-package go-mode
  :straight t
  :hook ((go-mode) .
         (lambda ()
           (require 'go-mode)
           (tree-sitter-hl-mode)
           (lsp))))
;(add-hook 'go-mode-hook 'lsp-deferred)

; Racket
(use-package racket-mode
  :straight t)
(add-hook 'racket-mode-hook 'lsp-deferred)

; Lisp
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")


; Disable Warnings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(warning-suppress-types '((lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
