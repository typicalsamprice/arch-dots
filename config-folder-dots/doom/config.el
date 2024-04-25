(setq user-name "Sam Price"
      user-email "sam@typicalsamprice.com")

(setq doom-font (font-spec :family "CodeNewRoman Nerd Font" :size 19))

(setq catppucin-flavor 'latte)
(load-theme 'catppuccin t t)
(catppuccin-reload)

(after! latex
  (add-to-list 'tex--prettify-symbols-alist '("\\eps" . 949))
  (setq lsp-tex-server 'digestif))

;; Make doing this so nice and easy
(add-to-list 'display-buffer-alist (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

(setq async-shell-command-buffer #'new-buffer)

(defun open-zathura-texpdf ()
  (interactive)
  (async-shell-command (concat "zathura " (file-name-sans-extension (buffer-name)) ".pdf")))

(after! lsp
  (setq lsp-clangd-binary-path "/usr/bin/clangd"))
