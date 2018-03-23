(use-package erlang
  :mode (("\\.erl\\'" . erlang-mode )
         ("rebar.config" . erlang-mode ))
  :config
  ;; (use-package distel)
  ;; (use-package company-distel)

  ;; (flycheck-define-checker erlang-otp
  ;;                          "An Erlang syntax checker using the Erlang interpreter."
  ;;                          :command ("erlc" "-o" temporary-directory "-Wall"
  ;;                                    "-I" "../include" "-I" "../../include"
  ;;                                    "-I" "../../../include" source)
  ;;                          :error-patterns
  ;;                          ((warning line-start (file-name) ":" line ": Warning:" (message) line-end)
  ;;                           (error line-start (file-name) ":" line ": " (message) line-end)))

  (add-hook 'erlang-mode-hook
            (lambda ()
              ;; (flycheck-select-checker 'erlang-otp)
              (flycheck-mode)
              (company-mode)
              (setq company-backends '(company-distel))
              ))

  (add-to-list 'load-path "~/.emacs.d/modules/distel/elisp")
  (require 'distel)
  (distel-setup)

  (use-package company-distel
    :config
    ;; (add-to-list 'company-backends 'company-distel)
    (setq company-distel-popup-help t)
    (setq company-distel-popup-height 30)
    )

  ;; prevent annoying hang-on-compile
  (defvar inferior-erlang-prompt-timeout t)
  ;; default node name to emacs@localhost
  ; (setq inferior-erlang-machine-options '("-sname" "emacs"))
  ; ;; tell distel to default to that node
  ; (setq erl-nodename-cache
  ;       (make-symbol
  ;        (concat
  ;         "emacs@"
  ;         ;; Mac OS X uses "name.local" instead of "name", this should work
  ;         ;; pretty much anywhere without having to muck with NetInfo
  ;         ;; ... but I only tested it on Mac OS X.
  ;         (car (split-string (shell-command-to-string "hostname"))))))
  
  )

(provide 'init-erlang)
