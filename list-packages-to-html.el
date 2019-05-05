;;; list-packages-to-html.el --- Render list-packages with HTML  -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Xu Chunyang

;; Author: Xu Chunyang <mail@xuchunyang.me>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(defun list-packages-to-html--escape (s)
  (mapconcat
   (lambda (char)
     (pcase char
       (?& "&amp;")
       (?< "&lt;")
       (?> "&gt;")
       ;; really needed?
       (?\" "&quot;")
       (?' "&#39;")
       (_ (string char))))
   s ""))

(defun list-packages-to-html--insert-pkg (pkg)
  (insert (format
           "
        <tr>
          <td><a href=\"%s\">%s</a></td>
          <td>%s</td>
          <td>%s</td>
          <td>%s</td>
          <td>%s</td>
        </tr>
"
           (or (alist-get :url (package-desc-extras pkg)) "#")
           (list-packages-to-html--escape (symbol-name (package-desc-name pkg)))
           (list-packages-to-html--escape (package-version-join (package-desc-version pkg)))
           (list-packages-to-html--escape (package-desc-status pkg))
           (list-packages-to-html--escape (package-desc-archive pkg))
           (list-packages-to-html--escape (package-desc-summary pkg)))))

(defun list-packages-to-html ()
  (interactive)
  (mapc #'list-packages-to-html--insert-pkg
        (mapcar #'cadr package-archive-contents)))

(provide 'list-packages-to-html)
;;; list-packages-to-html.el ends here
