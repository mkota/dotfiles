;;;; Org-mode
;; Acknowledgements: @Yoo (http://stackoverflow.com/q/2736087)

(eval-after-load "org"
  '(progn
     (require 'latex)
     (define-key org-mode-map (kbd "C-c C-t") 'LaTeX-environment)

     ;; Smart quotes when exporting to html and latex
     ;; (require 'ox)
     (require 'ox-latex)
     (setq-default org-export-with-smart-quotes t)
     (add-to-list 'org-export-smart-quotes-alist
		  '("en-GB"
		    (opening-double-quote :utf-8 "“" :html "<q>" :latex "\\textquote{" :texinfo "``")
		    (closing-double-quote :utf-8 "”" :html "</q>" :latex "}" :texinfo "''")
		    (opening-single-quote :utf-8 "‘" :html "<q>" :latex "\\textquote{" :texinfo "`")
		    (closing-single-quote :utf-8 "’" :html "</q>" :latex "}" :texinfo "'")
		    (apostrophe :utf-8 "’" :html "&rsquo;" :latex "'" :texinfo "'")))

     ;; LaTeX exports
     (setq org-latex-listings 'listings)
     (unless (boundp 'org-latex-classes)
       (setq org-latex-classes nil))
     (add-to-list 'org-latex-classes
		  '("book"
		    "\\RequirePackage[l2tabu, orthodox]{nag}
\\documentclass{book}
\\usepackage[a4paper]{geometry}
\\usepackage{graphicx}
\\usepackage{mathptmx, tgtermes}
\\usepackage[T1]{fontenc}
\\usepackage{microtype}
\\usepackage{siunitx}
\\usepackage{booktabs}
\\usepackage[listings, mathtools, fixlayout]{custom}
\\usepackage[british]{babel}
\\usepackage{csquotes}
                    [NO-DEFAULT-PACKAGES]
                    [PACKAGES]

                    [EXTRA]

\\usepackage[colorlinks=false, pdfborder={0 0 0}]{hyperref}
\\usepackage{cleveref}"
		    ("\\chapter{%s}" . "\\chapter*{%s}")
		    ("\\section{%s}" . "\\section*{%s}")
		    ("\\subsection{%s}" . "\\subsection*{%s}")
		    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		    ("\\paragraph{%s}" . "\\paragraph*{%s}")))

     ;; HTML exports
     (setq org-html-postamble t)
     (setq org-html-postamble-format '(("en" "<p class=\"author\">Author: %a</p>\n<p>Last Updated: %T</p>")))

     (defun my-org-mode-hook ()
       ;; The following two lines of code is run from the mode hook.
       ;; These are for buffer-specific things.
       ;; In this setup, you want to enable flyspell-mode
       ;; as well as auto-fill-mode for every org buffer.
       (flyspell-mode 1)
       (auto-fill-mode 1))
     (add-hook 'org-mode-hook 'my-org-mode-hook)

     (defun custom-org-confirm-babel-evaluate (flag)
       ;; Report the setting of org-confirm-babel-evaluate.
       ;; If invoked with C-u, toggle the setting.
       ;; Credit: @jcs (http://irreal.org/blog/?p=69)
       (interactive "P")
       (if (equal flag '(4))
	   (setq org-confirm-babel-evaluate (not org-confirm-babel-evaluate)))
       (message "Babel evaluation confirmation is %s"
		(if org-confirm-babel-evaluate "on" "off")))))

     ;; (defun custom-org-confirm-babel-evaluate (lang body)
     ;;   (not (string= lang "R")))	; don't ask for R
     ;; (setq org-confirm-babel-evaluate 'custom-org-confirm-babel-evaluate)))

;; Source code execution
(org-babel-do-load-languages 'org-babel-load-languages
			     '((emacs-lisp . t)
			       (ditaa . t)
			       (latex . t)
			       (R . t)
			       (octave . t)
			       (sh . t)
			       (python . t)
			       (org . t)))
;; Fontify source code blocks
(setq org-src-fontify-natively t)

;;;; Publish

;; ;; Use a personal style sheet instead
;; (setq org-html-head-include-default-style nil)
;; (setq org-html-head-extra "<link rel=\"stylesheet\" href=\"stylesheets/main.css\" type=\"text/css\" />")
