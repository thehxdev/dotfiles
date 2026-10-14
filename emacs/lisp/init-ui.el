;;; init-ui.el --- Visual and theme configuration -*- lexical-binding: t; -*-

(require 'init-packages)

;; Visual feedback modes
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

;; Font setup
(add-to-list 'default-frame-alist '(font . "Iosevka NFM-16"))

;; Theme setup
(use-package gruvbox-theme
  :straight t
  :config
  (load-theme 'gruvbox-dark-medium t))

(provide 'init-ui)
;;; init-ui.el ends here
