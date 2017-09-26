(global-auto-revert-mode t)

(global-linum-mode)

;; (global-visual-line-mode 1)
;; (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(windmove-default-keybindings)

;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)

(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;(set-face-attribute 'default nil :font "Consolas-11.0")

;diminish modes
(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))

; Set backup dir to temp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory )))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq create-lockfiles nil)

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

;; (use-package monokai-theme
;;   :config
;;   (load-theme 'monokai)
;;   )

(use-package material-theme
  :config
  (load-theme 'material)
  )

(use-package linum-relative
  :config
  (linum-relative-global-mode)
  (setq linum-relative-current-symbol ""))

(use-package smooth-scrolling
  :config
  (setq scroll-margin 5
        scroll-conservatively 9999
        scroll-step 1))

(use-package aggressive-indent 
  :commands (aggressive-indent-mode))

(use-package rainbow-mode)

(use-package smartparens
  :commands (smartparens-mode smartparens-strict-mode)
  :config
  
  ;; remove quote for clojure/lisp
  ;; (sp-local-pair '(lisp-mode
  ;;                  emacs-lisp-mode
  ;;                  clojure-mode
  ;;                  cider-repl-mode) "'" nil :actions nil)

  ;; emacs is lisp hacking enviroment, so we set up some most common
  ;; lisp modes too
  (sp-with-modes sp--lisp-modes
    ;; disable ', it's the quote character!
    (sp-local-pair "'" nil :actions nil)
    ;; also only use the pseudo-quote inside strings where it serve as
    ;; hyperlink.
    (sp-local-pair "`" "'" :when '(sp-in-string-p))
    (sp-local-pair "(" nil
                   :pre-handlers '(live-sp-add-space-before-sexp-insertion)
                   :post-handlers '(live-sp-add-space-after-sexp-insertion)))

  (bind-keys
   :map smartparens-mode-map
   ("C-M-a" . sp-beginning-of-sexp)
   ("C-M-e" . sp-end-of-sexp)

   ;; ("C-<down>" . sp-down-sexp)
   ;; ("C-<up>"   . sp-up-sexp)
   ;; ("M-<down>" . sp-backward-down-sexp)
   ;; ("M-<up>"   . sp-backward-up-sexp)

   ;; ("C-M-f" . sp-forward-sexp)
   ;; ("C-M-b" . sp-backward-sexp)

   ;; ("C-M-n" . sp-next-sexp)
   ;; ("C-M-p" . sp-previous-sexp)

   ;; ("C-S-f" . sp-forward-symbol)
   ;; ("C-S-b" . sp-backward-symbol)

   ("C-<right>" . sp-forward-slurp-sexp)
   ("C-<left>" . sp-forward-barf-sexp)
   ("M-<left>" . sp-backward-slurp-sexp)
   ("M-<right>" . sp-backward-barf-sexp)

   ;; ("C-M-t" . sp-transpose-sexp)
   ;; ("C-M-k" . sp-kill-sexp)
   ;; ("C-k"   . sp-kill-hybrid-sexp)
   ;; ("M-k"   . sp-backward-kill-sexp)
   ;; ("C-M-w" . sp-copy-sexp)

   ;; ("C-M-d" . delete-sexp)

   ;; ("M-<backspace>" . backward-kill-word)
   ;; ("C-<backspace>" . sp-backward-kill-word)
   ;; ([remap sp-backward-kill-word] . backward-kill-word)

   ;; ("M-[" . sp-backward-unwrap-sexp)
   ;; ("M-]" . sp-unwrap-sexp)

   ;; ("C-x C-t" . sp-transpose-hybrid-sexp)
   ("C-c ("  . (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "(")))
   ("C-c ["  . (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "[")))
   ("C-c {"  . (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "{")))
   ("C-c '"  . (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "'")))
   ("C-c \"" . (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "\"")))
   ("C-c _"  . (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "_")))
   ("C-c `"  . (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "`")))
   ))

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

  (use-package evil-commentary
    :config
    (evil-commentary-mode)
    :diminish evil-commentary-mode)

  (use-package evil-smartparens
    :commands (evil-smartparens-mode)))

;; ------------
;; Powerline
(use-package powerline-evil
  :config
                                        ;(powerline-default-theme)
                                        ;(powerline-evil-center-color-theme)
  (powerline-evil-vim-color-theme))

(provide 'init-editor)
