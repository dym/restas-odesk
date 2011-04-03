; -*- coding: utf-8; mode: common-lisp; -*-

(restas:define-module #:restas.odesk
  (:use #:cl)
  (:export #:*odesk-api-public-key*
           #:*odesk-api-secret-key*
           #:*odesk-authenticate-url*
           #:*odesk-callback-url*
           #:*odesk-token-session-key*
           #:*odesk-redirect-session-key*))

(in-package :restas.odesk)

(defparameter *odesk-api-public-key* nil)

(defparameter *odesk-api-secret-key* nil)

(defparameter *odesk-authenticate-url* "auth/authenticate/")

(defparameter *odesk-callback-url* "auth/callback/")

(defparameter *odesk-token-session-key* "_odesk_api_token")

(defparameter *odesk-redirect-session-key* "_odesk_redirect_url")