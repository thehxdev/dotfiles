(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)

(add-to-list 'load-path "~/.emacs.d/hxlocal")

;;; Disable backup files
(setq make-backup-files nil)
(setq backup-directory-alist '((".*" . "~/.emacs.d/.trash")))


(setq-default tab-width 4
              indent-tabs-mode nil
              compilation-scoll-output t)

;; (setq display-line-numbers-type 'relative)
(setq scroll-conservatively 4
      scroll-margin 4
      split-width-threshold nil)

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

;; (require 'treesit)

;;; Multiple cursors
(straight-use-package 'multiple-cursors)
(global-set-key (kbd "C->")     'mc/mark-next-like-this)
(global-set-key (kbd "C-<")     'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")    'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")     'mc/skip-to-previous-like-this)
;; (global-set-key (kbd "C-;")     'mark-word)

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
 'yaml-mode
 'json-mode
 'markdown-mode
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

;;; simpc-mode
;; (require 'simpc-mode)
;; (add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;; odin-mode
(require 'odin-mode)
(add-to-list 'auto-mode-alist '("\\.odin" . odin-mode))

(c-set-offset 'comment-intro 0)
(put 'dired-find-alternate-file 'disabled nil)
