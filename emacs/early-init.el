(setq gc-cons-percentage 0.6
      inhibit-startup-screen t
      native-comp-speed 2
      initial-frame-alist '((top . 30) (left . 30) (width . 100) (height . 30)))

;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 500 1024 1024))))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(font . "Iosevka NFM-13"))
