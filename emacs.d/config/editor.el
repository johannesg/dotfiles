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

(use-package paredit
  :commands (paredit-mode))

(use-package rainbow-mode)
