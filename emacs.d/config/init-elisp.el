(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (aggressive-indent-mode)
            (paredit-mode)
            (rainbow-delimiters-mode)))

