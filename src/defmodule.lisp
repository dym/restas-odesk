; -*- coding: utf-8; mode: common-lisp; -*-

(restas:define-module #:restas.odesk
  (:use #:cl)
  (:export #:*odesk-api-key*
           #:*odesk-api-secret*
           #:*odesk-auth-page-url*
           #:*odesk-auth-callback-url*
           #:*odesk-oauth-page-url*
           #:*odesk-oauth-callback-url*
           #:*odesk-token-session-key*
           #:*odesk-redirect-session-key*
           #:*odesk-redirect-field-name*
           #:*token-callback*))

(in-package :restas.odesk)

(defparameter *odesk-api-key* nil)

(defparameter *odesk-api-secret* nil)

(defparameter *odesk-auth-page-url* "auth/authenticate/")

(defparameter *odesk-auth-callback-url* "auth/callback/")

(defparameter *odesk-oauth-page-url* "oauth/authenticate/")

(defparameter *odesk-oauth-callback-url* "oauth/callback")

(defparameter *odesk-token-session-key* "_odesk_api_token")

(defparameter *odesk-redirect-session-key* "_odesk_redirect_url")

(defparameter *odesk-redirect-field-name* "next")

(defparameter *token-callback* 'default-token-callback)

(defun default-token-callback (token)
  (hunchentoot:set-cookie *odesk-token-session-key* :value token))