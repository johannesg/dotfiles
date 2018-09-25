
;; Emacs config insipirations:
;; https://github.com/purcell/emacs.d

(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-windows* (eq system-type 'windows-nt))

(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

(require 'init-package)

(use-package better-defaults)

(require 'init-editor)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

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

(use-package all-the-icons)

(use-package neotree
  :bind ([f8] . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  )

(use-package projectile
  :diminish
  :config
  (projectile-global-mode)
  (setq projectile-mode-line
        '(:eval (format " Projectile[%s]"
                        (projectile-project-name))))
  (setq projectile-switch-project-action 'neotree-projectile-action)
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

(use-package popup)

;; ----------
;; Flycheck
;; http://www.flycheck.org/manual/latest/index.html

(use-package flycheck
  :defer t
  :config
  ;; turn on flychecking globally
  ;; (add-hook 'after-init-hook #'global-flycheck-mode)

  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'web-mode)

  (use-package flycheck-popup-tip)
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
  :config
  (add-hook 'after-init-hook #'global-company-mode)
  :commands (company-mode))

(use-package nginx-mode
  :commands (nginx-mode))

(use-package cmake-mode)

(use-package eredis)

(require 'init-elisp)

(require 'init-web)
(require 'init-clojure)
(require 'init-csharp)
(require 'init-fsharp)
;; (require 'init-go)
;; (require 'init-elm)
(require 'init-php)
(require 'init-python)
(require 'init-erlang)

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
  (server-start)
  (server-mode))

(provide 'init)
;;; emacs.el ends here
