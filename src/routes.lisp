; -*- coding: utf-8; mode: common-lisp; -*-

(in-package :restas.odesk)

(restas:define-route odesk-authenticate-page (*odesk-authenticate-url*)
  (let ((redirect-url (or (hunchentoot:get-parameter *odesk-redirect-field-name*)
                          "/")))
    (odesk:with-odesk (:format :json
                       :public-key *odesk-api-public-key*
                       :secret-key *odesk-api-secret-key*)
      (if redirect-url
          (hunchentoot:set-cookie *odesk-redirect-session-key*
                                  :path "/"
                                  :value redirect-url))
      (restas:redirect (odesk:auth-url)))))

(restas:define-route odesk-callback-page (*odesk-callback-url*)
  (odesk:with-odesk
      (:format :json
       :public-key *odesk-api-public-key*
       :secret-key *odesk-api-secret-key*)
    (let* ((frob (string-downcase (hunchentoot:get-parameter "frob")))
           (json-text (first (odesk:auth/get-token :parameters (list (cons "frob" frob)))))
           (token (gethash "token" (json:parse json-text)))
           (redirect-url (hunchentoot:cookie-in *odesk-redirect-session-key*)))
      (funcall *token-callback* token)
      (restas:redirect redirect-url))))