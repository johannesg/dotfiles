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
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2))

(custom-set-faces



 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; package init
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

(require 'cl-lib)
(defvar my/packages
  '(evil
    evil-leader
    evil-easymotion
    evil-magit
    powerline
    powerline-evil
    pt
    magit
    helm
    monokai-theme
    flycheck
    go-mode
    js2-mode
    json-mode
    web-mode)
  )
(defun my/install-packages ()
  "Ensure the packages I use are installed. See `my/packages'."
  (interactive)
  (let ((missing-packages (cl-remove-if #'package-installed-p my/packages)))
    (when missing-packages
      (message "Installing %d missing package(s)" (length missing-packages))
      (package-refresh-contents)
      (mapc #'package-install missing-packages))))

(my/install-packages)

;; ----------
;; Misc
(load-theme 'monokai)
;(set-face-attribute 'default nil :font "Consolas-11.0")

;; ----------
;; Evil mode
(setq evil-want-C-u-scroll t)
(require 'evil)
(require 'evil-leader)
(require 'evil-easymotion)
(require 'evil-magit)

(evil-mode t)

(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key
  "f" 'find-file
  "b" 'switch-to-buffer
  "g" 'magit-status)

(evilem-default-keybindings "SPC")

;; ------------
;; Powerline
(require 'powerline)
(require 'powerline-evil)
;(powerline-default-theme)
;(powerline-evil-center-color-theme)
(powerline-evil-vim-color-theme)

;; ----------
;; Helm
(require 'helm-config)
(helm-mode t)

;; ----------
;; Flycheck
;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; ----------
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; ----------
;; Go
(require 'go-mode-autoloads)

(defun my-go-mode-hook ()
  ; Call gofmt before save
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))

(add-hook 'go-mode-hook 'my-go-mode-hook)

;; ----------
;; Web development
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;(setq js-indent-level 2)

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; ---------
;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
;(when (memq window-system '(mac ns))
;  (exec-path-from-shell-initialize))

;; ----------
(provide 'emacs)
;;; emacs.el ends here
