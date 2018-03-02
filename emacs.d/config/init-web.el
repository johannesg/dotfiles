(use-package json-mode
  :mode "\\.json\\'"
  :config
  )

(use-package js2-mode
  :mode (( "\\.js\\'" . js2-mode ))
  :config
  (add-hook 'js2-mode-hook (lambda()
                             (flycheck-mode))))

(use-package web-mode
  :mode (("\\.jsx\\'" . web-mode )
         ("\\.html\\'" . web-mode )
         ("\\.djhtml\\'" . web-mode ))
  :config
  (add-hook 'web-mode-hook (lambda()
                             (flycheck-mode)))

  (setq web-mode-engines-alist '(("django" . "\\.djhtml\\'")))

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-css-colorization t))

(use-package graphql-mode
  :mode "\\.graphql\\'")

(provide 'init-web)
