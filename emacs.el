;;; package --- Summary

;;; Commentary:

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("196cc00960232cfc7e74f4e95a94a5977cb16fd28ba7282195338f68c84058ec" default)))
 '(inhibit-startup-screen t))

;;; package init
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

(ensure-package-installed 'evil
			  'evil-leader
			  'evil-easymotion
                          'helm
			  'monokai-theme
			  'go-mode
			  'flycheck)

(load-theme 'monokai)
;(set-face-attribute 'default nil :font "Consolas-11.0")

;;; Evil mode
(require 'evil)
(require 'evil-leader)
(require 'evil-easymotion)

(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key
  "f" 'find-file
  "b" 'switch-to-buffer)

(evilem-default-keybindings "SPC")

(evil-mode t)

(require 'helm-config)
(helm-mode t)

;; Go
(require 'go-mode-autoloads)

(defun my-go-mode-hook ()
  ; Call gofmt before save
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'after-init-hook #'global-flycheck-mode)

(provide 'emacs)
;;; emacs.el ends here
