;;; lisp/major/mu4e.el -*- lexical-binding: t; -*-

(set-email-account! "Pessoal"
  '((mu4e-sent-folder       . "/Inbox")
    (mu4e-drafts-folder     . "/rascunhos")
    (mu4e-trash-folder      . "/lixeira")
    (mu4e-refile-folder     . "/todos")
    (smtpmail-smtp-user     . "lucasvianareis@gmail.com"))
  t)
