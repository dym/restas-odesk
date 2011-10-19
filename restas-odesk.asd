; -*- coding: utf-8; mode: common-lisp; -*-

(defpackage :restas-odesk-asd
  (:use :cl
        :asdf))

(in-package :restas-odesk-asd)

(defsystem #:restas-odesk
  :name "oDesk API Plugin for RESTAS"
  :version "0.3.0"
  :author "Dmitriy Budashny <dmitriy.budashny@gmail.com>"
  :license "BSD"
  :components
  ((:module "src"
            :components
            ((:file "defmodule")
             (:file "routes" :depends-on ("defmodule")))))
  :depends-on (#:restas #:odesk #:yason))