;;; package --- Summary

;;; Commentary:

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-cljs-lein-repl
   "(do (require 'weasel.repl.websocket) (cemerick.piggieback/cljs-repl (weasel.repl.websocket/repl-env :ip \"127.0.0.1\" :port 9001)))")
 '(custom-safe-themes
   (quote
    ("c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" "a800120841da457aa2f86b98fb9fd8df8ba682cebde033d7dbf8077c1b7d677a" "c59857e3e950131e0c17c65711f1812d20a54b829115b7c522672ae6ba0864cc" default)))
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2)
 '(package-selected-packages
   (quote
    (nginx-mode php-mode fsharp-mode yaml-mode web-mode use-package smooth-scrolling rainbow-mode rainbow-delimiters pt protobuf-mode projectile powershell powerline-evil omnisharp monokai-theme json-mode js2-mode helm go-mode flx-ido evil-surround evil-smartparens evil-magit evil-leader evil-jumper evil-easymotion evil-commentary elm-mode dockerfile-mode docker company cider aggressive-indent))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(tool-bar-mode 0)

;;; package init
(require 'package)

;; (add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

;; Activate installed packages
(package-initialize)

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

;; ----------
;; Misc
(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

(setq use-package-verbose t)
(setq use-package-always-ensure t)

(server-mode)

(load "editor.el")

(load "init-evil.el")

;; ------------
(use-package pt
  :commands (pt-regexp projectile-pt)
  :config
  '(evil-set-initial-state 'pt-search-mode 'emacs)
  )

;; ------------
;; Powerline
(use-package powerline-evil
  :config
  ;(powerline-default-theme)
  ;(powerline-evil-center-color-theme)
  (powerline-evil-vim-color-theme))

;; ----------
;; Helm
(use-package helm
  :config
  ;; (use-package helm-ls-git
  ;;   :commands (helm-ls-git-ls)
  ;;   :config
  ;;   )
  ;; (helm-mode t)
  (global-set-key (kbd "M-x") 'helm-M-x)
;;   (global-set-key (kbd "C-<f6>") 'helm-ls-git-ls)
;;   (global-set-key (kbd "C-x C-d") 'helm-browse-project)
 )

(use-package flx-ido
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil)
  )

(use-package projectile
  :config
  (projectile-global-mode)
  :diminish
  )

(use-package auto-complete
  :commands (auto-complete-mode)
  ;; :diminish auto-complete-mode
  ;; :config
  ;; (ac-config-default)
)

(use-package rainbow-delimiters
  ;; :commands (rainbow-delimiters-mode)
  ;; :diminish
  :config
  )

;; ----------
;; Flycheck
;; http://www.flycheck.org/manual/latest/index.html

(use-package flycheck
  :defer t
  :config
  ;; turn on flychecking globally
  ;(add-hook 'after-init-hook #'global-flycheck-mode)
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  )

;; ----------
;; Go


  ; (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")

(use-package magit
  :commands (magit-status magit-dispatch-popup)
  :init
  (bind-key "C-x g" 'magit-status)
  (bind-key "C-x M-g" 'magit-dispatch-popup)
  :config
  (use-package evil-magit)
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
             )

(use-package js2-mode
             :mode (( "\\.js\\'" . js2-mode ))
             :config
             (add-hook 'js2-mode-hook (lambda()
                                        (flycheck-mode)
                                        )
                       )
             )

(use-package web-mode
  :mode (("\\.jsx\\'" . web-mode ))
  :mode (("\\.html\\'" . web-mode ))
  :config
  (add-hook 'web-mode-hook (lambda()
                             (flycheck-mode)
                             )
            )
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )

;; -------------
(use-package powershell
  :mode (("\\.ps1\\'" . powershell-mode )))

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode )))

(use-package company
  :commands (company-mode))

(use-package nginx-mode
  :commands (nginx-mode))

(load "init-elisp.el")

(load "init-clojure.el")
(load "init-csharp.el")
(load "init-fsharp.el")
;; (load "init-go.el")
;; (load "init-elm.el")
(load "init-php.el")

;; ---------
;; Docker
(use-package dockerfile-mode
  :mode "Dockerfile\\'")

;; (use-package docker
;;   :commands (docker-ps))

;; (use-package neotree
;;   :commands (neotree-toggle)
;;   :init
;;   (global-set-key [f8] 'neotree-toggle)
;;   :config
;;   )

;; ---------
;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))

;; ----------
;; Global Mappings


;; ----------
(provide 'emacs)
;;; emacs.el ends here
