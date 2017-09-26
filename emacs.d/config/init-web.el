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
  :mode (("\\.jsx\\'" . web-mode ))
  :mode (("\\.html\\'" . web-mode ))
  :config
  (add-hook 'web-mode-hook (lambda()
                             (flycheck-mode)))

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(provide 'init-web)
