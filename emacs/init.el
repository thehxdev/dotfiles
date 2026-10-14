;;; init.el --- Emacs initialization entry point -*- coding: utf-8-auto; lexical-binding: t; -*-

;; Add modular lisp and custom local packages to load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "local-packages" user-emacs-directory))

;; Load modular components
(require 'init-core)
(require 'init-packages)
(require 'init-ui)
(require 'init-completion)
(require 'init-prog)

;;; init.el ends here
