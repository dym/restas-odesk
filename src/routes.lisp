; -*- coding: utf-8; mode: common-lisp; -*-

(in-package :restas.odesk)

;;; Simple Auth
(restas:define-route odesk-auth-page (*odesk-auth-page-url*)
  (let ((redirect-url (hunchentoot:get-parameter *odesk-redirect-field-name*)))
    (odesk:with-odesk (:auth :simple
                       :format :json
                       :key *odesk-api-key*
                       :secret *odesk-api-secret*)
      (if redirect-url
          (hunchentoot:set-cookie *odesk-redirect-session-key*
                                  :path "/"
                                  :value redirect-url))
      (restas:redirect (odesk:make-auth-url)))))

(restas:define-route odesk-auth-callback (*odesk-auth-callback-url*)
  (odesk:with-odesk (:auth :simple
                     :format :json
                     :key *odesk-api-key*
                     :secret *odesk-api-secret*)
    (let* ((frob (string-downcase (hunchentoot:get-parameter "frob")))
           (json-text (first (odesk:auth/get-token :parameters (list (cons "frob" frob)))))
           (token (gethash "token" (json:parse json-text)))
           (redirect-url (hunchentoot:cookie-in *odesk-redirect-session-key*)))
      (apply *token-callback* token)
      (restas:redirect redirect-url))))

;;; OAuth
(restas:define-route odesk-oauth-page (*odesk-oauth-page-url*)
  (let ((redirect-url (hunchentoot:get-parameter *odesk-redirect-field-name*)))
    (odesk:with-odesk (:auth :oauth
                       :format :json
                       :key *odesk-api-key*
                       :secret *odesk-api-secret*)
      (if redirect-url
          (hunchentoot:set-cookie *odesk-redirect-session-key*
                                  :path "/"
                                  :value redirect-url))
      (restas:redirect (odesk:make-auth-url)))))

(restas:define-route odesk-oauth-callback (*odesk-oauth-callback-url*)
  )