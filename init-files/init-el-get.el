;;; init-el-get.el ---

;; Copyright (C) 2015  Vladimir Ivanov

;; Author: Vladimir Ivanov <ivvl82@gmail.com>
;; Keywords:

;;; Commentary:

;;

;;; Code:

(defvar my:builtin-packages
  '(auto-insert                   ; auto-inserts text into new buffers
    flyspell)                     ; on-the-fly spell checking
  "A list of built-in packages, initialization files for which
  are loaded at launch.")
(defvar my:el-get-packages
  '(adaptive-wrap             ; smart line-wrapping
    auctex                    ; writing and formatting TeX/LaTeX files
    essh                      ; emulates for bash what ESS is to R
    fullscreen                ; full-screen support
    hungry-delete             ; hungry delete whitespaces
    magit                     ; interface to Git
    nlinum                    ; displays line numbers
    org-protocol-jekyll       ; Jekyll's handler for org-protocol
    realgud                   ; interacting with external debuggers
    sdcv                      ; interface for sdcv
    solarized-emacs           ; Solarized colour theme
    structured-haskell-mode   ; structured editing mode for Haskell
    window-margin)            ; auto margins for Visual Line mode
  "A list of packages to ensure are installed at launch.")

;; Declare extra custom recipes
(setq el-get-sources
      '((:name sdcv
               :depends showtip
               :build
               `(("patch" "sdcv.el"
                  ,(expand-file-name "sdcv-start-process.patch"
                                     (concat user-emacs-directory
                                             (file-name-as-directory "patches")))))
               :compile "sdcv.el")))

;; Load initialization files for built-in packages
(let ((init-files (mapcar (lambda (pkg)
                            (concat (file-name-as-directory
                                     el-get-user-package-directory)
                                    "init-" (symbol-name pkg) ".el"))
                          my:builtin-packages)))
  (dolist (file init-files)
    (load-file (expand-file-name file el-get-user-package-directory))))

(el-get-cleanup my:el-get-packages)
(el-get 'sync my:el-get-packages)

;;; init-el-get.el ends here
