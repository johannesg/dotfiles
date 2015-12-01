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

(tool-bar-mode 0)

;;; package init
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;(setq package-enable-at-startup nil)

;; Activate installed packages
(package-initialize)

;; ----------
;; Misc
(eval-when-compile
  (require 'use-package))
;(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

;(setq use-package-verbose t)
(setq use-package-always-ensure t)

(global-auto-revert-mode t)

(global-linum-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
;(set-face-attribute 'default nil :font "Consolas-11.0")

(use-package monokai-theme
  :config
  (load-theme 'monokai)
  )

;; ----------
;; Evil mode
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-fine-undo 'fine)
  :config
  (evil-mode t)
  )

(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "f" 'helm-find-files
    "b" 'switch-to-buffer
    "g" 'pt-regexp)
  )

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "SPC")
  )

(use-package evil-surround
  :config
  (global-evil-surround-mode 1)
  )

(use-package evil-jumper
  :config
  (evil-jumper-mode t)
  )

;; ------------
(use-package pt
  :commands (pt-regexp)
  :config)

;; ------------
;; Powerline
(use-package powerline
  :config
  (use-package powerline-evil)
  ;(powerline-default-theme)
  ;(powerline-evil-center-color-theme)
  (powerline-evil-vim-color-theme)
)

;; ----------
;; Helm
(use-package helm
  :config
  (use-package helm-ls-git
    :commands (helm-ls-git-ls)
    :config
    )
  (helm-mode t)
  (global-set-key (kbd "C-<f6>") 'helm-ls-git-ls)
  (global-set-key (kbd "C-x C-d") 'helm-browse-project)
)


(use-package auto-complete
  :defer t
  :config
  (ac-config-default)
)

;; ----------
;; Flycheck
;; http://www.flycheck.org/manual/latest/index.html

(use-package flycheck
  :defer t
  :config
  ;; turn on flychecking globally
  (add-hook 'after-init-hook #'global-flycheck-mode)
  )

;; ----------
;; Go

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call gofmt before save
  (add-hook 'before-save-hook 'gofmt-before-save)

  ;; (if (not (string-match "go" compile-command))
  ;;     (set (make-local-variable 'compile-command)
  ;;          "go build -v && go test -v && go vet")) ; godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))

  ; (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")

(use-package magit
             :commands (magit-status magit-dispatch-popup)
             :init
             (bind-key "C-x g" 'magit-status)
             (bind-key "C-x M-g" 'magit-dispatch-popup)
             :config
             (use-package evil-magit)
             (require 'evil-magit)
             )

(use-package go-mode
             :mode "\\.go\\'"
             :config
             (add-hook 'go-mode-hook 'my-go-mode-hook)
             (use-package go-autocomplete)
;             (use-package go-dlv)
             (use-package go-rename)
             ; (require 'go-mode-autoloads)
             ; (require 'go-autocomplete)
             ; (require 'auto-complete-config)
             )

;; ------------
;; protobuf
(use-package protobuf-mode
  :mode "\\.proto\\'"
  :config
  (use-package flycheck-protobuf)
  )

;; -----------
;; Web

(use-package json-mode
             :mode "\\.json\\'"
             :config 
             (setq-default flycheck-disabled-checkers
                           (append flycheck-disabled-checkers
                                   '(json-jsonlist)))
             )

(use-package js2-mode
             :mode (( "\\.js\\'" . js2-mode ))
             :config
             (setq-default flycheck-disabled-checkers
                           (append flycheck-disabled-checkers
                                   '(javascript-jshint)))
             )

(use-package web-mode
             :mode (("\\.jsx\\'" . web-mode ))
             :mode (("\\.html\\'" . web-mode ))
             :config
             (setq web-mode-markup-indent-offset 2)
             (setq web-mode-css-indent-offset 2)
             (setq web-mode-code-indent-offset 2)
             (flycheck-add-mode 'javascript-eslint 'web-mode)
             )
;; -------------
(use-package elm-mode
             :mode (("\\.elm\\'" . elm-mode ))
             :config
             (add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
             (add-hook 'elm-mode-hook #'elm-oracle-setup-ac)
             )

;; -------------
(use-package powershell
             :mode (("\\.ps1\\'" . powershell-mode ))
             )
;; ---------
;; Docker
(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package docker
  :commands (docker-ps))

(use-package neotree
  :commands (neotree-toggle)
  :init
  (global-set-key [f8] 'neotree-toggle)
  :config
  )
;; ---------
;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
;(when (memq window-system '(mac ns))
;  (exec-path-from-shell-initialize))

;; ----------
;; Global Mappings


;; ----------
(provide 'emacs)
;;; emacs.el ends here
