
(use-package fsharp-mode
  :mode "\\.fs[x]\\'"
  :config
  (add-hook 'fsharp-mode-hook #'smartparens-mode)
  ;; (add-hook 'csharp-mode-hook #'omnisharp-mode)
  (setq-default fsharp-indent-offset 2)
  )

(provide 'init-fsharp)
