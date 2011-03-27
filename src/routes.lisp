; -*- coding: utf-8; mode: common-lisp; -*-

(in-package :restas.odesk)

(restas:define-route odesk-authenticate-page (*odesk-authenticate-url*)
  (odesk:with-odesk connection
      (:format :json
               :public-key *odesk-api-public-key*
               :secret-key *odesk-api-secret-key*)
    (restas:redirect (odesk:auth-url connection))))

(restas:define-route odesk-callback-page (*odesk-callback-url*)
  (odesk:with-odesk connection
      (:format :json
               :public-key *odesk-api-public-key*
               :secret-key *odesk-api-secret-key*)
    (let* ((frob (string-downcase (hunchentoot:get-parameter "frob")))
           (json-text (first (odesk:auth/get-token connection
                                                   :params (list (cons "frob" frob)))))
           (token (gethash "token" (json:parse json-text))))
      (format nil "<h1>Callback</h1><h3>~a</h3><h3>~a</h3>" frob token))))