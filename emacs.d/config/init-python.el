(use-package python
  :mode (("\\.py\\'" . python-mode )))

(use-package elpy
  :after python
  :config
  (elpy-enable)
  (when *is-windows*
    ;; Python for Windows does not contain readline
    (setq python-shell-completion-native-enable nil))
  )

(provide 'init-python)
