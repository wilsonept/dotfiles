(setq user-full-name "Zakharchenko Dmitry"
      user-mail-address "wilsonept@gmail.com")

(setq doom-theme 'doom-one)

(setq org-directory "~/projects/org/")

(setq display-line-numbers-type t)

(global-display-fill-column-indicator-mode)

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
