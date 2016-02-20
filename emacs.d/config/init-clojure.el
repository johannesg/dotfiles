
(use-package clojure-mode
             :mode (("\\.clj\\'" . clojure-mode ))
             :config
             ;; (add-hook 'clojure-mode-hook #'paredit-mode)
             (add-hook 'clojure-mode-hook #'smartparens-mode)
             (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
             )

(use-package cider
             :commands (cider-jack-in)
             :config
             ;; (add-hook 'cider-repl-mode-hook #'paredit-mode)
             (add-hook 'cider-repl-mode-hook #'smartparens-mode)
             (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
             (evil-set-initial-state 'cider-repl-mode 'emacs)
             (evil-set-initial-state 'cider-stacktrace-mode 'emacs)
             )

(provide 'init-clojure)
