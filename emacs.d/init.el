;;; package --- Summary

;;; Commentary:

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

(require 'init-package)

(use-package better-defaults)

(require 'init-editor)

;; ------------
(use-package pt
  :commands (pt-regexp projectile-pt)
  :config
  '(evil-set-initial-state 'pt-search-mode 'emacs)
  )

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


;; -------------
(use-package powershell
  :mode (("\\.ps1\\'" . powershell-mode )))

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode )))

(use-package company
  :commands (company-mode))

(use-package nginx-mode
  :commands (nginx-mode))

(require 'init-elisp)

(require 'init-web)
(require 'init-clojure)
(require 'init-csharp)
(require 'init-fsharp)
;; (require 'init-go)
;; (require 'init-elm)
(require 'init-php)

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


;;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)
;;; emacs.el ends here
