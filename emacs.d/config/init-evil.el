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
    :commands (evil-smartparens-mode))
  )

(provide 'init-evil)
