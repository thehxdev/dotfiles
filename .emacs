(setq initial-frame-alist '((top . 20) (left . 20) (width . 100) (height . 30)))

(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)

(add-to-list 'load-path "~/.emacs.d/hxlocal")

(setq-default inhibit-startup-screen t
              tab-width 4
              indent-tabs-mode nil
              compilation-scoll-output t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(font . "Iosevka NF-13"))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

(setq scroll-conservatively 4
      scroll-margin 4)

;;; Disable backup files
(setq make-backup-files nil)
(setq backup-directory-alist '((".*" . "~/.emacs.d/.trash")))

;;; ido mode
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq-default ido-use-filename-at-point nil)


;;; dired-x
(with-eval-after-load 'dired
  (require 'dired-x))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)
(setq dired-listing-switches "-agho --group-directories-first")

(global-set-key (kbd "C-,") 'duplicate-line)

;;; Format current buffer with Astyle 
;;; https://astyle.sourceforge.net/
(defun astyle-buffer ()
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr --indent-preproc-block"
     nil
     t)
    (goto-line saved-line-number)))

(global-set-key (kbd "C-c f") 'astyle-buffer)



;;; Initialize Straight.el package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

(defun hx/install-packages (&rest packages)
  (dolist (package packages)
    (straight-use-package package)))

(require 'treesit)

;;; Multiple cursors
(straight-use-package 'multiple-cursors)
(global-set-key (kbd "C->")     'mc/mark-next-like-this)
(global-set-key (kbd "C-<")     'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")    'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")     'mc/skip-to-previous-like-this)
;; (global-set-key (kbd "C-;")     'mark-word)

;;; Gruvbox theme
(hx/install-packages 'gruvbox-theme)
(load-theme 'gruvbox-dark-medium t)

;;; Smex and Ido
(hx/install-packages 'smex 'ido-completing-read+)
(global-set-key (kbd "M-x") 'smex)
(require 'ido-completing-read+)

;;; Helm
(hx/install-packages 'helm)
(setq helm-ff-transformer-show-only-basename nil)
(global-set-key (kbd "C-c h r") 'helm-recentf)


;;; Company mode
(hx/install-packages 'company)
(require 'company)
(global-company-mode)

;;; Smartparens
(hx/install-packages 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode)


(hx/install-packages
 'cl-lib
 'magit
 'markdown-mode
 'clojure-mode
 'cider
 'go-mode
 'rust-mode)

;; (setq magit-auto-revert-mode nil)
;; (global-set-key (kbd "C-c m s") 'magit-status)
;; (global-set-key (kbd "C-c m l") 'magit-log)


;;; c-mode
(setq c-basic-offset 4
      c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;;; Enable simpc-mode
;; (require 'simpc-mode)
;; (add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))


(c-set-offset 'comment-intro 0)
(put 'dired-find-alternate-file 'disabled nil)
