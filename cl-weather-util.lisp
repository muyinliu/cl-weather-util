;;;; cl-weather-util.lisp
;;;; Weather related utilities.

(defpackage cl-weather-util
  (:use :cl)
  (:nicknames :weather-util :wutil)
  #+:sbcl (:shadow :defconstant :search)
  #+:sb-package-locks (:lock t)
  (:export  #:wind-speed->name
            #:wind-speed->level
            #:aqi->name
            #:aqi->health-effects
            #:aqi->color))

(in-package :cl-weather-util)

;;; Wind utilities

(defun wind-speed->name (speed &key (language :chinese))
  "Wind speed to name."
  (assert (member language '(:chinese)))
  (case language
    (:chinese
     (cond ((<      speed   1) "无风")
           ((<=   1 speed   5) "软风")
           ((<=   6 speed  11) "轻风")
           ((<=  12 speed  19) "微风")
           ((<=  20 speed  28) "和风")
           ((<=  29 speed  38) "清风")
           ((<=  39 speed  49) "强风")
           ((<=  50 speed  61) "劲风")
           ((<=  62 speed  74) "大风")
           ((<=  75 speed  88) "烈风")
           ((<=  89 speed 102) "狂风")
           ((<= 103 speed 117) "暴风")
           (t "台风")))))

(defun wind-speed->level (speed &key (language :chinese))
  "Wind speed to level."
  (assert (member language '(:chinese)))
  (case language
    (:chinese
     (cond ((<      speed   1)  0)
           ((<=   1 speed   5)  1)
           ((<=   6 speed  11)  2)
           ((<=  12 speed  19)  3)
           ((<=  20 speed  28)  4)
           ((<=  29 speed  38)  5)
           ((<=  39 speed  49)  6)
           ((<=  50 speed  61)  7)
           ((<=  62 speed  74)  8)
           ((<=  75 speed  88)  9)
           ((<=  89 speed 102) 10)
           ((<= 103 speed 117) 11)
           ((<= 118 speed 134) 12)
           ((<= 135 speed 149) 13)
           ((<= 150 speed 166) 14)
           ((<= 167 speed 183) 15)
           ((<= 184 speed 201) 16)
           ((<= 202 speed 220) 17)
           (t "17级以上")))))

;;; Air Quality Index utilities

(defun aqi->health-effects (aqi &key (language :chinese))
  "AQI to health effects in Chinese or other language."
  (assert (member language '(:english :chinese)))
  (case language
    (:english
     (cond ((<=   0 aqi  50) "Little or no risk")
           ((<=  51 aqi 100) "Acceptable quality")
           ((<= 101 aqi 150) "General Public not likely affected")
           ((<= 151 aqi 200) "All may experience some effects")
           ((<= 201 aqi 300) "All may experience more serious effects")
           ((<= 301 aqi 500) "Emergency conditions")
           (t                "Emergency conditions")))
    (:chinese
     (cond ((<=   0 aqi  50) "良好")
           ((<=  51 aqi 100) "中等")
           ((<= 101 aqi 150) "对敏感人群不健康")
           ((<= 151 aqi 200) "不健康")
           ((<= 201 aqi 300) "非常不健康")
           ((<= 301 aqi 500) "有毒害")
           (t                "有毒害")))))

(defun aqi->name (aqi &key (language :chinese))
  "AQI to name in Chinese or other language."
  (assert (member language '(:english :chinese)))
  (case language
    (:english
     (cond ((<=   0 aqi  50) "Good")
           ((<=  51 aqi 100) "Moderate")
           ((<= 101 aqi 150) "Unhealthy for Sensitive Groups")
           ((<= 151 aqi 200) "Unhealthy")
           ((<= 201 aqi 300) "Very Unhealthy")
           ((<= 301 aqi 500) "Hazardous")
           (t                "Hazardous")))
    (:chinese
     (cond ((<=   0 aqi  50) "优")
           ((<=  51 aqi 100) "良")
           ((<= 101 aqi 150) "轻度污染")
           ((<= 151 aqi 200) "中度污染")
           ((<= 201 aqi 300) "重度污染")
           ((<= 301 aqi 500) "严重污染")
           (t                "严重污染")))))

(defun aqi->color (aqi &key (language :chinese))
  "AQI to color in Chinese or other language."
  (assert (member language '(:english :chinese)))
  (case language
    (:english 
     (cond ((<=   0 aqi  50) "green")
           ((<=  51 aqi 100) "yellow")
           ((<= 101 aqi 150) "orange")
           ((<= 151 aqi 200) "red")
           ((<= 201 aqi 300) "purple")
           ((<= 301 aqi 500) "maroon")
           (t                "maroon")))
    (:chinese
     (cond ((<=   0 aqi  50) "绿色")
           ((<=  51 aqi 100) "黄色")
           ((<= 101 aqi 150) "橙色")
           ((<= 151 aqi 200) "红色")
           ((<= 201 aqi 300) "紫色")
           ((<= 301 aqi 500) "褐红色")
           (t                "褐红色")))))
