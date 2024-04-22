(setq user-name "Sam Price"
      user-email "sam@typicalsamprice.com")

(setq doom-font (font-spec :family "GeistMono Nerd Font" :size 18))

(setq catppucin-flavor 'latte)
(load-theme 'catppuccin t t)
(catppuccin-reload)

(add-to-list 'tex--prettify-symbols-alist '("\\eps" . 1013))

;; Make doing this so nice and easy
(add-to-list 'display-buffer-alist (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

(setq async-shell-command-buffer #'new-buffer)

(defun open-zathura-texpdf ()
  (interactive)
  (async-shell-command (concat "zathura " (file-name-sans-extension (buffer-name)) ".pdf")))
