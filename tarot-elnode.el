(require 'elnode)
(require 'tarot)

(tarot-choose-deck "javetarot")

(defun tarot-elnode-handler (httpcon)
  "elnode hanlder that shows a random tarot card"
   (elnode-http-start httpcon 200 '("Content-Type" . "text/html"))
   (elnode-http-return 
       httpcon
       (let ((card (random-aref tarot-deck)))
         (format 
          "<html><body><h1>%s</h1>
<img src=\"/tarot-static/jave_tarot/%s.svg\">
</body></html>"   (aref (car card) 0)  (aref (car card) 0)))))

(defconst tarot-elnode-urls
  `(("tarot/$" . tarot-elnode-handler)
    ("tarot-static/\\(.*\\)$" . ,  (elnode-webserver-handler-maker "/home/joakim/current/git/el-tarot/"))))

(defun tarot-elnode-dispatcher-handler (httpcon)
  (elnode-dispatcher httpcon tarot-elnode-urls))

;(elnode-start 'tarot-elnode-handler :port 8028 :host "localhost")
;(elnode-start 'tarot-elnode-static-handler :port 8040 :host "localhost")
;(elnode-start  (elnode-webserver-handler-maker "/home/joakim/current/git/el-tarot") :port 8041 :host "localhost") 
;(elnode-start 'tarot-elnode-dispatcher-handler :port 8031 :host "localhost")

;; http://localhost:8031/tarot
