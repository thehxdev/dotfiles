;;; early-init.el --- Early initialization -*- coding: utf-8-auto; lexical-binding: t; -*-

;; Optimization: Disable file-name-handler during startup
(defvar hx--file-name-handler-alist-orig file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Optimization: Maximize garbage collection threshold during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Reset optimizations once Emacs starts
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 64 1024 1024)
                  gc-cons-percentage 0.1
                  file-name-handler-alist hx--file-name-handler-alist-orig)))

;; Native compilation settings
(when (featurep 'native-compile)
  (setq native-comp-async-report-warnings-errors 'silent
        native-comp-async-query-on-exit t
        native-comp-async-jobs-number 4)
  (when (boundp 'native-comp-jit-compilation)
    (setq native-comp-jit-compilation t)))

;; UI / Frame early setup (suppress GUI clutter before rendering)
(setq package-enable-at-startup nil
      inhibit-startup-screen t
      initial-frame-alist '((top . 30) (left . 30) (width . 120) (height . 35)))

(set-default-coding-systems 'utf-8)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode 1)

;;; early-init.el ends here
