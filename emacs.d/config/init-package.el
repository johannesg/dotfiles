(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
                                        ;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

;; Activate installed packages
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; ----------
;; Misc
(eval-when-compile
  (require 'use-package)
  (use-package diminish)
  (require 'bind-key)                ;; if you use any :bind variant

  (setq use-package-verbose t)
  (setq use-package-always-ensure t)
  )
;; (require 'diminish)                ;; if you use :diminish

;; (use-package diminish)

(provide 'init-package)
