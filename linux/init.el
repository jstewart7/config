;; .emacs -> (load "~/git/config/linux/init.el")
;;
;; ----------------- Packages  ----------------------
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

;; ----------------- Graphical ----------------------

;; turn off the tool bar

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(tool-bar-mode -1)
;; turn off help screen
(setq inhibit-startup-screen t)
;;turn on line numbers
(global-linum-mode t)

;; whitespace-mode stuff
(require 'whitespace)
(setq whitespace-line-column 100)
(setq whitespace-style '(face trailing tabs lines-tail))
;;(setq whitespace-style '(face lines-tail))
(setq whitespace-line "font-lock-warning-face")
(global-whitespace-mode t)

;; ------------------ Bindings ----------------------

;; re-bind buffer-list to buffer-menu
;(global-set-key "\C-x\C-b" 'ibuffer)

;; make it easy to change between buffers
(global-set-key "\M-[" 'previous-multiframe-window)
(global-set-key "\M-]" 'next-multiframe-window)

(define-key global-map (kbd "C-j") 'ace-jump-mode)
(define-key global-map (kbd "C-c C-c") 'comment-region)

;;------------------------------------------------------------------------------
;; --- Experimental ergonomics ---
;;------------------------------------------------------------------------------

;; Rebind C-u to do C-x
;; (keyboard-translate ?\C-u ?\C-x)

;; Kind of god mode but just for browsing
;; (defhydra hydra-browse (:color blue)
;;   "Browse"
;;   ("n" next-line)
;;   ("p" previous-line)
;;   ("f" forward-char)
;;   ("b" backward-char)

;;   ("v" scroll-up-command)
;;   ("M-v" scroll-down-command)
;;   ("l" recenter-top-bottom)

;;   ("M-[" previous-multiframe-window)
;;   ("M-]" next-multiframe-window)
;;   ("q" nil "quit")
;;   ("i" nil "quit")
;;   )
;; (global-set-key (kbd "C-c r") 'hydra-browse/body)

(require 'god-mode)
;(global-set-key (kbd "<escape>") 'god-mode-all)
;; Was tab-to-tab-stop
(global-set-key (kbd "M-i") 'god-mode-all)

;(require 'color)
;; Indicators for god-mode
(require 'hl-line)
;(defadvice hl-line-mode (after
;                         dino-advise-hl-line-mode
;                         activate compile)
;  (set-face-background hl-line-face "gray13"))
(set-face-background 'hl-line "dim gray")
;(set-face-background hl-line-face "black")
(set-face-foreground 'highlight nil)

(with-eval-after-load 'god-mode
  (define-key god-local-mode-map (kbd ".") 'repeat)
  (define-key god-local-mode-map (kbd "i") 'god-mode-all)
  (global-set-key (kbd "C-x C-1") 'delete-other-windows)
  (global-set-key (kbd "C-x C-2") 'split-window-below)
  (global-set-key (kbd "C-x C-3") 'split-window-right)
  (global-set-key (kbd "C-x C-0") 'delete-window)
  (global-set-key (kbd "C-c C-n") 'compile)
  (global-set-key (kbd "C-c C-m") 'recompile)
;  (global-set-key "\C-x\ g" 'magit-status)
  ;; (global-set-key (kbd "C-x g") 'magit-status)

;  (add-to-list 'god-exempt-major-modes 'dired-mode)

  ;; Update the cursor based on the god mode state
  (defun god-mode-update-cursor ()
;    (setq cursor-type
;          (if (or god-local-mode buffer-read-only) 'hollow 'box)))
    (if (or god-local-mode buffer-read-only) (global-hl-line-mode 1) (global-hl-line-mode 0)))

  (add-hook 'god-mode-enabled-hook 'god-mode-update-cursor)
  (add-hook 'god-mode-disabled-hook 'god-mode-update-cursor))

;; turn bar red in god mode - grey otherwise
;; (defun me//god-mode-indicator ()
;;   (cond (god-local-mode
;;          (progn
;;            (set-face-background 'mode-line "red4")
;;            (set-face-foreground 'mode-line "gray")
;;            (set-face-background 'mode-line-inactive "gray30")
;;            (set-face-foreground 'mode-line-inactive "red")))
;;         (t
;;          (progn
;;            (set-face-background 'mode-line-inactive "gray30")
;;            (set-face-foreground 'mode-line-inactive "gray80")
;;            (set-face-background 'mode-line "gray75")
;;            (set-face-foreground 'mode-line "black")))))

;; (add-hook 'god-mode-enabled-hook #'me//god-mode-indicator)
;; (add-hook 'god-mode-disabled-hook #'me//god-mode-indicator)


(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;;------------------------------------------------------------------------------
;;------------------------------------------------------------------------------

;; ----------------- Environment --------------------
;;Disable backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Org mode
(setq org-log-done 'time)

;; display a list of recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 16)
;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Helm Mode Bindings
(helm-mode 1)
(global-set-key "\C-x\ \C-r" 'helm-recentf)
;(global-set-key "\C-x\C-b" 'helm-locate)
(global-set-key "\C-x\C-b" 'helm-mini)

;; Magit bindings
(global-set-key "\C-x\ g" 'magit-status)

;; Dumb Jump Bindings
(global-set-key "\M-." 'dumb-jump-go)
(global-set-key "\M-," 'dumb-jump-back)

;; Recompile binding
(global-set-key "\C-c\ n" 'compile)
(global-set-key "\C-c\ m" 'recompile)
(setq compilation-auto-jump-to-first-error nil)
(setq compilation-scroll-output 1) ;;Follow-mode

;; Aliases
(defalias 'rs 'replace-string)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (god-mode keyfreq hydra ace-jump-mode dumb-jump helm haskell-mode magit go-mode)))
 '(tool-bar-mode nil))

;;indents as 2 spaces
(setq default-tab-width 2)
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode 1)
            (setq tab-width 2)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'same-window-buffer-names "*compilation*")

(add-to-list 'auto-mode-alist '("\\.cppm\\'" . c++-mode))

;; Remove foreground from highlights, so that highlight bars show syntax highlighting
(set-face-foreground 'highlight nil)
