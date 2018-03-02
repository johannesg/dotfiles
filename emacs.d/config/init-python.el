(use-package python
  :mode (("\\.py\\'" . python-mode ))
  :config
  (setq python-shell-interpreter "python3")
  )

(use-package elpy
  :after python
  :config
  (elpy-enable)
  ;; (when *is-windows*
  ;;   ;; Python for Windows does not contain readline
  ;;   (setq python-shell-completion-native-enable t))

  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))

  (setq elpy-rpc-python-command "python3")

  (add-hook 'elpy-mode-hook 'flycheck-mode)
  (add-hook 'elpy-mode-hook (lambda ()
                              (add-hook 'before-save-hook 'elpy-format-code nil t)))

  (use-package ein)
  ;; (elpy-use-ipython)
  )

(provide 'init-python)
