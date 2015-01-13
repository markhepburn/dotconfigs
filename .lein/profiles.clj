;;; http://z.caudate.me/give-your-clojure-workflow-more-flow/
{:user {:plugins [[cider/cider-nrepl "0.8.2"]
                  [lein-try "0.3.2"]
                  [lein-pprint "1.1.1"]
                  [lein-midje    "3.1.3"]
                  [lein-midje-doc "0.0.18"]
                  [lein-simpleton "1.3.0"] ; serve up a directory
                  [codox "0.6.6"]
                  [refactor-nrepl "0.2.2"]
                  ]

        :dependencies [[aprint "0.1.0"]
                       [spyscope "0.1.5"]
                       [org.clojure/tools.namespace "0.2.8"]
                       [org.clojure/tools.nrepl "0.2.5"]
                       [leiningen #=(leiningen.core.main/leiningen-version)]
                       [im.chit/vinyasa "0.2.2"]
                       ]

        :injections [(require '[aprint.core :refer [aprint ap]]) ; prettier printing
                     (require 'spyscope.core)                    ; debugging, tracing, etc
                     (require '[clojure.tools.namespace.repl :refer [refresh]]) ; smarter code reloading

                     (require '[vinyasa.inject :as inject])
                     (inject/in
                      ;; note that `:refer, :all and :exclude can be used
                      [vinyasa.inject :refer [inject [in inject-in]]]
                      [vinyasa.lein :all]
                      [vinyasa.pull :all]
                      )

                     ]}}
