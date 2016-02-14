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
    ("38ba6a938d67a452aeb1dada9d7cdeca4d9f18114e9fc8ed2b972573138d4664" "0fb6369323495c40b31820ec59167ac4c40773c3b952c264dd8651a3b704f6b5" default)))
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

(global-auto-revert-mode t)

(global-linum-mode)

;; (global-visual-line-mode 1)
;; (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;(set-face-attribute 'default nil :font "Consolas-11.0")

;diminish modes
(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))

; Set backup dir to temp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; Purge old backups
(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (nth 5 (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))

(use-package monokai-theme
  :config
  (load-theme 'monokai)
  )

(use-package smooth-scrolling
  :config
  (setq scroll-margin 5
        scroll-conservatively 9999
        scroll-step 1))
;; ----------
;; Evil mode
(use-package evil
  :init
  (setq evil-want-fine-undo 'fine)
  :config
  (evil-mode t)

  (setq evil-emacs-state-cursor '("red" box))
  (setq evil-normal-state-cursor '("green" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("red" bar))
  (setq evil-replace-state-cursor '("red" box))
  (setq evil-operator-state-cursor '("red" hollow))

  (define-key evil-normal-state-map (kbd "C-j") 'evil-scroll-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-scroll-up)

  (use-package evil-leader
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ",")
    (evil-leader/set-key
      "f" 'projectile-find-file
      "b" 'switch-to-buffer
      "g" 'pt-regexp))

  (use-package evil-easymotion
    :config
    (evilem-default-keybindings "SPC"))

  (use-package evil-surround
    :config
    (global-evil-surround-mode 1))

  (use-package evil-jumper
    :config
    (evil-jumper-mode t))

  (use-package evil-commentary
    :config
    (evil-commentary-mode)
    :diminish evil-commentary-mode)
  )

(use-package rainbow-mode)

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
  (powerline-evil-vim-color-theme)
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
  :diminish auto-complete-mode
  :config
  (ac-config-default)
)

(use-package rainbow-delimiters
  ;; :commands (rainbow-delimiters-mode)
  ;; :diminish
  :config
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(use-package smartparens
  ;; :diminish smartparens-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
  ;; remove quote for clojure/lisp
  (sp-local-pair '(lisp-mode
                   emacs-lisp-mode
                   clojure-mode
                   cider-repl-mode) "'" nil :actions nil)) 

(use-package evil-smartparens
  :diminish evil-smartparens-mode
  :config
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))

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

(use-package go-mode
             :mode "\\.go\\'"
             :config
             (add-hook 'go-mode-hook (lambda ()
                                        ; Use goimports instead of go-fmt
;                                       (setq gofmt-command "goimports")
                                        ; Call gofmt before save
                                       (add-hook 'before-save-hook 'gofmt-before-save)

                                       ;; (if (not (string-match "go" compile-command))
                                       ;;     (set (make-local-variable 'compile-command)
                                       ;;          "go build -v && go test -v && go vet")) ; godef jump key binding
                                       (local-set-key (kbd "M-.") 'godef-jump)
                                       (flycheck-mode)
                                       )
                       )
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
(use-package elm-mode
             :mode (("\\.elm\\'" . elm-mode ))
             :config
             (add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
             (add-hook 'elm-mode-hook #'elm-oracle-setup-ac)
             )

(use-package clojure-mode
             :mode (("\\.clj\\'" . clojure-mode ))
             :config
             ;; (add-hook 'clojure-mode-hook #'paredit-mode)
             (add-hook 'clojure-mode-hook #'smartparens-mode)
             (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
             )

(use-package cider
             :commands (cider-jack-in)
             :config
             ;; (add-hook 'cider-repl-mode-hook #'paredit-mode)
             (add-hook 'cider-repl-mode-hook #'smartparens-mode)
             (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
             (evil-set-initial-state 'cider-repl-mode 'insert)
             )

;; -------------
(use-package powershell
             :mode (("\\.ps1\\'" . powershell-mode ))
             )

(require 'init-csharp)

;; ---------
;; Docker
(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package docker
  :commands (docker-ps))

;(use-package neotree
;  :commands (neotree-toggle)
;  :init
;  (global-set-key [f8] 'neotree-toggle)
;  :config
;  )

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
