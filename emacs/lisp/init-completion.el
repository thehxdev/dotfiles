;;; init-completion.el --- Completion framework configuration -*- lexical-binding: t; -*-

(require 'init-packages)

;; Ido and Smex
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq-default ido-use-filename-at-point nil)

(hx/install-packages 'smex 'ido-completing-read+)
(require 'ido-completing-read+)
(global-set-key (kbd "M-x") #'smex)

;; Company
(hx/install-packages 'company)
(require 'company)
(global-company-mode 1)

(provide 'init-completion)
;;; init-completion.el ends here
