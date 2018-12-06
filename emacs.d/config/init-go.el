(use-package go-mode
  :mode "\\.go\\'"
  :config
  (add-hook 'go-mode-hook (lambda ()
                                        ; Use goimports instead of go-fmt
                                        ;                                       (setq gofmt-command "goimports")
                                        ; Call gofmt before save
                            (add-hook 'before-save-hook 'gofmt-before-save)

                            ;; (if (not (string-match "go" compile-command))
                            ;;     (set (make-local-variable 'compile-command)
                            ;;          "go build -v && go test -v && go vet")) ; godef jump key binding
                            (local-set-key (kbd "M-.") 'godef-jump)
                            (flycheck-mode)
                            )
            )
  (use-package go-autocomplete)
                                        ;             (use-package go-dlv)
  (use-package go-rename)
                                        ; (require 'go-mode-autoloads)
                                        ; (require 'go-autocomplete)
                                        ; (require 'auto-complete-config)
  )

;; (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")


(provide 'init-go)
