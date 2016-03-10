

(use-package clojure-mode
  :mode (("\\.clj\\'" . clojure-mode ))
  :config
  ;; (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'clojure-mode-hook (lambda ()
                                 (paredit-mode)
                                 (rainbow-delimiters-mode)
                                 (company-mode)
                                 (aggressive-indent-mode))))

(use-package cider
  :commands (cider-jack-in)
  :config
  ;; (add-hook 'cider-repl-mode-hook #'paredit-mode)
  (defun cider-figwheel-repl ()
    (interactive)
    (save-some-buffers)
    (with-current-buffer (cider-current-repl-buffer)
      (goto-char (point-max))
      (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
             (figwheel-sidecar.repl-api/cljs-repl)")
      (cider-repl-return)))

  (add-hook 'cider-mode-hook (lambda ()
                               (company-mode)))

  (add-hook 'cider-repl-mode-hook (lambda ()
                                    (smartparens-mode)
                                    (rainbow-delimiters-mode)
                                    (company-mode)
                                    (local-set-key (kbd "C-c C-f") #'cider-figwheel-repl)))

  (evil-set-initial-state 'cider-repl-mode 'emacs)
  (evil-set-initial-state 'cider-stacktrace-mode 'emacs))

(provide 'init-clojure)
