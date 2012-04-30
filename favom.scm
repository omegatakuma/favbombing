#!/usr/local/bin/gosh
(use srfi-1)
(use sxml.sxpath)
(use net.twitter)

(define cred
  (make <twitter-cred>
    :consumer-key "consumer-key"
    :consumer-secret "consumer-secret"
	:access-token "access-token"
	:access-token-secret "access-token-secret"))

(define (main args)
  (display "target> ")(flush)
  (let* 
	((id (read-line))
	 (tweet-status (twitter-user cred :screen-name id :count 1000))
	 (tweet-id ((sxpath "/statuses/status/id/text()")tweet-status)))
	(for-each
	  (lambda(n x)
		(begin(twitter-fav cred x)(print "["n"]:爆撃")))
	  (iota (length tweet-id) 1) tweet-id)))
