(global-auto-revert-mode t)

(global-linum-mode)

;; (global-visual-line-mode 1)
;; (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

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

(use-package aggressive-indent 
  :commands (aggressive-indent-mode))

(use-package smartparens
  :commands (smartparens-mode smartparens-strict-mode)
  :config
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
   ;; ("C-c ("  . wrap-with-parens)
   ;; ("C-c ["  . wrap-with-brackets)
   ;; ("C-c {"  . wrap-with-braces)
   ;; ("C-c '"  . wrap-with-single-quotes)
   ;; ("C-c \"" . wrap-with-double-quotes)
   ;; ("C-c _"  . wrap-with-underscores)
   ;; ("C-c `"  . wrap-with-back-quotes)
   )
  
  (use-package rainbow-mode))
