(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (aggressive-indent-mode)
            (smartparens-strict-mode)
            (evil-smartparens-mode)
            (rainbow-delimiters-mode)))

