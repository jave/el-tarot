(require 'elnode)
(require 'tarot)

(tarot-choose-deck "javetarot")

(defun tarot-elnode-handler (httpcon)
  "elnode handler that shows a random tarot card"
   (elnode-http-start httpcon 200 '("Content-Type" . "text/html"))
   (elnode-http-return 
       httpcon
       (let* ((card (random-aref tarot-deck))
              (title (aref (car card) 0))
              (info-url (aref (car card) 2)))
         
         (format 
          "<html><body>
<a href=\"%s\"> <img alt=\"%s\" src=\"/tarot-static/jave_tarot/%s.svg\"> </a>
</body></html>"   info-url title title))))

(defconst tarot-elnode-urls
  `(("tarot/$" . tarot-elnode-handler)
    ("tarot-static/\\(.*\\)$" . ,  (elnode-webserver-handler-maker
                                    (file-name-directory
                  (buffer-file-name 
                   (car
                    (save-excursion 
                      (find-definition-noselect 'tarot-elnode-handler nil)))))))))

(defun tarot-elnode-dispatcher-handler (httpcon)
  (elnode-dispatcher httpcon tarot-elnode-urls))

;(elnode-start 'tarot-elnode-handler :port 8028 :host "localhost")
;(elnode-start 'tarot-elnode-static-handler :port 8040 :host "localhost")
;(elnode-start  (elnode-webserver-handler-maker "/home/joakim/current/git/el-tarot") :port 8041 :host "localhost") 
;(elnode-start 'tarot-elnode-dispatcher-handler :port 8031 :host "localhost")

;; http://localhost:8031/tarot
