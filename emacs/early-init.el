(setq gc-cons-percentage 0.6
      inhibit-startup-screen t
      native-comp-speed 2
      initial-frame-alist '((top . 30) (left . 30) (width . 120) (height . 35)))

;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 500 1024 1024))))

(set-default-coding-systems 'utf-8)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

;; (add-to-list 'default-frame-alist '(font . "Iosevka NFM-14"))
(add-to-list 'default-frame-alist '(font . "CaskaydiaCove NFM SemiLight-14"))
;; (add-to-list 'default-frame-alist '(font . "Cascadia Mono SemiLight-14"))
;; (add-to-list 'default-frame-alist '(font . "JetBrainsMono NFM Light-14"))
;; (add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font Mono-14"))


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

;;; Gruvbox theme
(hx/install-packages 'gruvbox-theme)
(load-theme 'gruvbox-dark-medium t)
