; -*- coding: utf-8; mode: common-lisp; -*-

(restas:define-module #:restas.odesk
  (:use #:cl)
  (:export #:*index-page-title*
           #:*odesk-api-public-key*
           #:*odesk-api-secret-key*))

(in-package :restas.odesk)

(defparameter *index-page-title* "index")

(defparameter *odesk-api-public-key* nil)

(defparameter *odesk-api-secret-key* nil)

(defparameter *odesk-authenticate-url* "auth/authenticate/")

(defparameter *odesk-callback-url* "auth/callback/")