;;; http://z.caudate.me/give-your-clojure-workflow-more-flow/
{:repl {:plugins [[lein-try "0.3.2"]
                  [lein-pprint "1.1.1"]
                  [lein-midje    "3.1.3"]
                  ;; [lein-midje-doc "0.0.18"] ; conflicts with cider-nrepl 0.9.0-snapshot, via rewrite_clj
                  [lein-simpleton "1.3.0"] ; serve up a directory
                  [codox "0.6.6"]
                  [refactor-nrepl "1.2.0"]
                  ]

        :dependencies [[aprint "0.1.0"]
                       [spyscope "0.1.5"]
                       [org.clojure/tools.namespace "0.2.8"]
                       [leiningen #=(leiningen.core.main/leiningen-version)]
                       [im.chit/vinyasa "0.2.2"]
                       ]

        :injections [(require '[aprint.core :refer [aprint ap]]) ; prettier printing
                     (require 'spyscope.core)                    ; debugging, tracing, etc
                     ;(require '[clojure.tools.namespace.repl :refer [refresh]]) ; smarter code reloading

                     ;; Prettier pretty-printing (see also, cider-repl-use-pretty-printing)
                     (alter-var-root #'clojure.pprint/pprint
                                     (constantly @#'aprint.core/aprint))

                     (require '[vinyasa.inject :as inject])
                     ;; (inject/inject clojure.core
                     ;;                '[[clojure.tools.namespace.repl [refresh refresh]]
                     ;;                  [clojure.repl apropos dir doc find-doc source]])
                     (inject/in
                      ;; note that `:refer, :all and :exclude can be used
                      [vinyasa.inject :refer [inject [in inject-in]]]
                      [vinyasa.lein :all]
                      [vinyasa.pull :all]

                      clojure.core [clojure.tools.namespace.repl refresh]
                      ;; clojure.core [clojure.repl apropos dir doc find-doc source]
                      )

                     ]
        }}
