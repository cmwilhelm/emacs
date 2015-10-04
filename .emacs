(add-to-list 'load-path "~/.emacs.d/lisp")

;; package management
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; for environment portability
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(projectile
		      perspective
		      persp-projectile
		      helm
		      neotree
		      auto-complete
		      flycheck
		      discover-my-major
		      smex
		      enh-ruby-mode
		      robe
		      inf-ruby
		      slim-mode
		      scss-mode
		      js2-mode
		      haskell-mode
		      shm
		      ac-haskell-process
		      smartparens
		      color-theme
		      atom-dark-theme
		      sublime-themes
		      solarized-theme
		      zenburn-theme
		      monokai-theme))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; formatting
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; global
(add-hook 'after-init-hook 'smartparens-global-mode)
(load-theme 'wombat t)
(setq linum-format "%d ")
(setq default-truncate-lines t)
(global-set-key (kbd "C-j") 'backward-word)
(global-set-key (kbd "C-l") 'forward-word)
(global-set-key (kbd "M-0") 'neotree-toggle)


;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


;; javascript
(setq js-indent-level 2)
(add-hook 'js-mode-hook 'auto-complete-mode)
(add-hook 'js-mode-hook 'linum-mode)


;; ruby
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'auto-complete-mode)
(add-hook 'ruby-mode-hook 'linum-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)


;; python
(setq py-indent-level 4)
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'linum-mode)


;; haskell
(add-hook 'haskell-mode-hook 'auto-complete-mode)
(add-hook 'haskell-mode-hook 'linum-mode)
(setq shm-program-name "~/Library/Haskell/bin/structured-haskell-mode")
(add-hook 'haskell-mode-hook 'structured-haskell-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "4f2ede02b3324c2f788f4e0bad77f7ebc1874eff7971d2a2c9b9724a50fb3f65" "19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d" "3ed645b3c08080a43a2a15e5768b893c27f6a02ca3282576e3bc09f3d9fa3aaa" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))


;; alignment!
(defun align-to-colon (begin end)
  "Align region to colon"
  (interactive "r")
  (align-regexp begin end
		       (rx ":" (group (zero-or-more (syntax whitespace))) ) 1 1 ))

(defun align-to-comma (begin end)
  "Align region to colon"
  (interactive "r")
  (align-regexp begin end
		       (rx "," (group (zero-or-more (syntax whitespace))) ) 1 1 ))

(defun neotree-projectile-show ()
  (interactive)
  (neotree-dir (projectile-project-root)))

(defun title-transform-persp-name (name)
  (if (string= name (persp-name persp-curr))
      (concat "**" (upcase name) "**")
    name))

(defun set-persp-name-to-frame ()
  (interactive)
  (setq frame-title-format (mapconcat 'title-transform-persp-name (persp-names) " | ")))

(defun start-projectile ()
  (interactive)
  (progn
    (projectile-global-mode)
    (setq projectile-enable-caching t)
    (persp-mode)
    (global-set-key (kbd "M-0") 'neotree-projectile-show)
    (global-set-key (kbd "M--") 'neotree-hide)
    (global-set-key (kbd "C-z") 'visit-project-term-buffer)
    (global-set-key (kbd "s-{") 'persp-prev)
    (global-set-key (kbd "s-}") 'persp-next)
    (set-persp-name-to-frame)
    (add-hook 'persp-activated-hook 'set-persp-name-to-frame)))

(defun persp-ansi-buffer-name ()
  (interactive)
  (concat "*ansi-term-" (persp-name persp-curr)))

(defun visit-project-term-buffer ()
  "Create or visit a terminal buffer."
  (interactive)
  (if (not (get-buffer (persp-ansi-buffer-name)))
      (progn
	(split-window-sensibly (selected-window))
	(other-window 1)
	(ansi-term (getenv "SHELL"))
	(rename-buffer (persp-ansi-buffer-name)))
    (switch-to-buffer-other-window (persp-ansi-buffer-name))))

(defun init-clean-graphical-emacs ()
  (progn
    (setq inhibit-splash-screen t)
    (setq initial-scratch-message nil)
    (menu-bar-mode -1)
    (setq fill-column 80)
    (when (functionp 'tool-bar-mode)
      (tool-bar-mode -1))
    (load-theme 'brin t)
    (scroll-bar-mode -1)
    (start-projectile)))

(defun sequester-backup-turds ()
  (let ((dir "~/.emacs_backups"))
    (progn
      (unless (file-exists-p dir)
	(make-directory dir))
      (setq backup-directory-alist dir))))

(if window-system (init-clean-graphical-emacs))
(sequester-backup-turds)

;;; .emacs ends here
