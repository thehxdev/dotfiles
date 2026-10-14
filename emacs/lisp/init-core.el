;;; init-core.el --- Core editor and system defaults -*- lexical-binding: t; -*-

;; Environment PATH sync (NixOS compatibility)
(setq exec-path
      (append
       exec-path
       (split-string
        (replace-regexp-in-string
         "[ \t\n]*$"
         ""
         (with-temp-buffer
           (unless (ignore-errors (insert-file-contents "~/.PATH")) "")
           (buffer-string)))
        path-separator)))

(setenv "PATH" (concat (string-join (exec-path) ":") ":" (getenv "PATH")))
(setq shell-command-switch "-ic")

;; Custom file safety
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file 'noerror 'nomessage))

;; Backups
(setq make-backup-files nil
      backup-directory-alist '((".*" . "~/.emacs.d/.trash")))

;; Editing defaults
(setq-default tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t)

(setq scroll-conservatively 4
      scroll-margin 2
      split-width-threshold nil)

;; Built-in utilities
(when (fboundp 'which-key-mode)
  (which-key-mode 1))

(global-set-key (kbd "C-,") #'duplicate-line)

(provide 'init-core)
;;; init-core.el ends here
