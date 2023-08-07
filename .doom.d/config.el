(setq user-full-name "Zakharchenko Dmitry"
      user-mail-address "wilsonept@gmail.com")

(setq doom-theme 'doom-one)

(setq org-directory "~/projects/org/")

(setq display-line-numbers-type t)

(global-display-fill-column-indicator-mode)
(add-hook 'org-mode-hook '(lambda () (setq fill-column 72)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(setq flycheck-flake8-maximum-line-length 88)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(use-package org-roam
    :ensure t
    :init
    (setq org-roam-v2-ack t)
    :custom
    (org-roam-directory "~/projects/org/roam")
    (org-roam-completion-everywhere t)
    (org-roam-capture-templates
     '(("d" "default" plain
        "#+STARTUP: hideblocks\n%?"
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
        :unnarrowed t)
       ("a" "Ansible multifile" plain
        (file "~/projects/org/roam/templates/ansible_multifile_template.org")
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
        :unnarrowed t)
       ("f" "New feature" plain
        (file "~/projects/org/roam/templates/feature_template.org")
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
        :unnarrowed t)
       ("l" "Programming language" plain
        "#+STARTUP: hideblocks\n\n* Описание.\n%?\n\n* Пример.\n"
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
        :unnarrowed t)))
    :bind (("C-c n l" . org-roam-buffer-toggle)
           ("C-c n f" . org-roam-node-find)
           ("C-c n i" . org-roam-node-insert)
           :map org-mode-map
           ("C-M-i" . completion-at-point))
    :config
    (org-roam-setup))

(setq org-hide-emphasis-markers t)
;;(org-mode-restart)

(setq projectile-project-search-path (list "~/projects" "~/projects/org"))
;;(projectile-reset-known-projects)

(require 'google-translate)
(require 'google-translate-default-ui)

;; Sample jar configuration

(setq plantuml-jar-path "/home/zaharchenko/.emacs.d/.local/etcplantuml.jar")
(setq plantuml-default-exec-mode 'jar)

;; Sample executable configuration
(setq plantuml-executable-path "/usr/bin/dot")
(setq plantuml-default-exec-mode 'executable)

;; Предварительно не забудь добавить установку пакета в packages.el
(require 'ox-pandoc)

(require 'org-timer)
(setq org-timer-default-timer 60)
(add-hook 'org-timer-done-hook
          (lambda ()
            (message-box "Время на анжумання и перекус!")))

(setq gptel-api-key "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")
(setq gptel-model "gpt-3.5-turbo")
