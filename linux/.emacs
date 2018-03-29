;; ----------------- Graphical ----------------------

;; turn off the tool bar
(tool-bar-mode -1)

;;turn on line numbers
(global-linum-mode t)

;;indents as 2 spaces
(setq default-tab-width 2)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(inhibit-startup-screen t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-trailing ((t (:foreground "PaleVioletRed1" :strike-through t)))))

;; whitespace-mode stuff
(require 'whitespace)
;(setq whitespace-style '(face trailing tabs lines-tail))
(setq whitespace-style '(face lines-tail))
(setq whitespace-line "font-lock-warning-face")
(global-whitespace-mode t)

;; ------------------ Bindings ----------------------

;; re-bind buffer-list to buffer-menu
(global-set-key "\C-x\C-b" 'ibuffer)

;; make it easy to change between buffers
(global-set-key "\M-[" 'previous-multiframe-window)
(global-set-key "\M-]" 'next-multiframe-window)

;; ----------------- Environment --------------------
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

;;Disable backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; display a list of recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 16)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; default to use only spaces
(setq-default indent-tabs-mode nil)

;; avoid accidental closing
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

;(when window-system
(global-set-key (kbd "C-x C-c") 'ask-before-closing);)

;; omit uninteresting files from dired
(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))

(put 'erase-buffer 'disabled nil)