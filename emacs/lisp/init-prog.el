;;; init-prog.el --- Programming languages and development tools -*- lexical-binding: t; -*-

(require 'init-packages)

;; Formatting: Astyle
(defun astyle-buffer ()
  "Format current buffer with Astyle."
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr --indent-preproc-block"
     nil
     t)
    (goto-line saved-line-number)))

(global-set-key (kbd "C-c f") #'astyle-buffer)

;; Tree-sitter
(require 'treesit)

;; Multiple Cursors
(hx/install-packages 'multiple-cursors)
(global-set-key (kbd "C->")     #'mc/mark-next-like-this)
(global-set-key (kbd "C-<")     #'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") #'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")    #'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")     #'mc/skip-to-previous-like-this)

;; Smartparens
(hx/install-packages 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode 1)

;; Dired configuration
(with-eval-after-load 'dired
  (require 'dired-x))
(setq-default dired-dwim-target t)
(setq dired-mouse-drag-files t
      dired-listing-switches "-agho --group-directories-first")
(put 'dired-find-alternate-file 'disabled nil)

;; Magit & VCS
(hx/install-packages 'magit 'vc-fossil)
(global-set-key (kbd "C-c m s") #'magit-status)
(global-set-key (kbd "C-c m l") #'magit-log)

;; Programming languages & utilities
(hx/install-packages
 'yaml-mode
 'json-mode
 'markdown-mode
 'reformatter
 'zig-mode
 'lua-mode
 'go-mode
 'typescript-mode
 'cuda-mode
 'php-mode
 'rust-mode)

;; C-mode settings
(setq c-basic-offset 4
      c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "bsd")))

(add-hook 'c-mode-hook
          (lambda ()
            (c-set-offset 'comment-intro 0)
            (c-toggle-comment-style -1)))

;; LSP: Eglot
(require 'eglot)
(add-to-list 'eglot-server-programs
             '((python-mode python-ts-mode)
               "basedpyright-langserver" "--stdio"))

(provide 'init-prog)
;;; init-prog.el ends here
