(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/melpa-stable/")
                         ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")))
(global-linum-mode 1)
(setq linum-format "%d ")
;;(require 'modern-cpp-font-lock)
(require 'unicad)
(package-initialize) ;; You might already have this line
;;(modern-c++-font-lock-global-mode t)

(show-paren-mode 1)

;;-----------------------------------------
;;Coding config

(prefer-coding-system 'gb18030)
(prefer-coding-system 'utf-8)

;;-----------------------------------------
;;Markdown Support

(autoload 'markdown-mode "markdown-mode"
         "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
        "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;;-------------------------------------------
;;node.js
;;-------------------------------------------
(require 'js2-mode)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;-------------------------------------------
;;Lisp SLIME
;;-------------------------------------------

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime)
(slime-setup '(slime-fancy slime-tramp slime-asdf))
(slime-require :swank-listener-hooks)

;;-------------------------------------------
;;Auto complete
;;-------------------------------------------

(require 'rust-mode)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode) ;;启动flycheck

(use-package company
  :diminish
  :config (global-company-mode 1))

(use-package lsp-mode
  :diminish "L"
  :init (setq lsp-keymap-prefix "C-l"
              lsp-enable-file-watchers t
              lsp-pyls-disable-warning t
              )
  :hook
  (c-mode-common . lsp-deferred)
  ;;(sh-mode . lsp-deferred)
  (python-mode . lsp-deferred)
  (rust-mode . lsp-deferred)
;;  (lisp-mode . lsp-deferred)
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :init (setq lsp-ui-doc--from-mouse-current t
              lsp-ui-doc-show-with-cursor nil
;;              lsp-ui-doc-show-with-mouse t
              )
  )

;;(setq lsp-enable-links nil)

(use-package ccls
  :init (setq ccls-sem-highlight-method 'font-lock)
  :hook ((c-mode c++-mode objc-mode) . (lambda () (require 'ccls) (lsp-deferred))))

(setq ccls-sem-highlight-method 'font-lock)

(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

;;--------------------------------------------
;;Neo tree
;;--------------------------------------------
(require 'neotree)
(global-set-key [f5] 'neotree-toggle)

;;--------------------------------------------
;;Common config
;;--------------------------------------------
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(blink-cursor-mode 0)
(setq-default indent-tabs-mode nil);

(setq
     backup-by-copying t ; 自动备份
     backup-directory-alist
     '(("." . "~/.em_backup")) ; 自动备份在目录"~/.em_backup"下
     delete-old-versions t ; 自动删除旧的备份文件
     kept-new-versions 3 ; 保留最近的3个备份文件
     kept-old-versions 1 ; 保留最早的1个备份文件
     version-control t) ; 多次备份

(setq scroll-step 1
      scroll-margin 3;;可以在靠近屏幕边沿3行时就开始滚动
      scroll-conservatively 10000);;设置为每次翻滚一行，可以使页面更连续

(global-hl-line-mode t);高亮当前行

(tool-bar-mode 0);关闭工具栏

(require 'indent-guide)
;;(indent-guide-global-mode)
;;(set-face-background 'indent-guide-face "dimgray")
(setq indent-guide-char ":")
;;(set-face-background 'indent-guide-face "dimgray")
(setq indent-guide-recursive t)
;;为orgmode开启自动折行
(add-hook 'org-mode-hook
	  (lambda()
	    (setq truncate-lines nil)))

(setq inhibit-startup-message t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(blink-cursor-mode nil)
 '(compilation-message-face 'default)
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("0cd00c17f9c1f408343ac77237efca1e4e335b84406e05221126a6ee7da28971" "8b58ef2d23b6d164988a607ee153fd2fa35ee33efc394281b1028c2797ddeebb" default))
 '(display-time-mode t)
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100)))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   '(flycheck-rust darkokai-theme slime dash typescript-mode lsp-intellij company-plisp javap-mode java-imports lsp-java ccls company lsp-ui lox-mode lsp-mode pkgbuild-mode package-build nodejs-repl go-mode pos-tip popup-complete popup-imenu auctex-latexmk auctex-cluttex lua-mode auctex renpy monokai-theme indent-guide color-theme-modern neotree pandoc markdown-mode+ unicad use-package))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 128 :width normal)))))
