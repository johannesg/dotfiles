(use-package elm-mode
  :mode (("\\.elm\\'" . elm-mode ))
  :config
  (add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
  (add-hook 'elm-mode-hook #'elm-oracle-setup-ac)
  )
