
(use-package clojure-mode
             :mode (("\\.clj\\'" . clojure-mode ))
             :config
             ;; (add-hook 'clojure-mode-hook #'paredit-mode)
             (add-hook 'clojure-mode-hook (lambda ()
                                               (smartparens-mode)
                                               (rainbow-delimiters-mode)
                                               (company-mode)
                                               ))
             )

(use-package cider
             :commands (cider-jack-in)
             :config
             ;; (add-hook 'cider-repl-mode-hook #'paredit-mode)
             (add-hook 'cider--mode-hook (lambda ()
                                               (company-mode)
                                               ))

             (add-hook 'cider-repl-mode-hook (lambda ()
                                               (smartparens-mode)
                                               (rainbow-delimiters-mode)
                                               (company-mode)
                                               ))


             (evil-set-initial-state 'cider-repl-mode 'emacs)
             (evil-set-initial-state 'cider-stacktrace-mode 'emacs)
             )

(provide 'init-clojure)
