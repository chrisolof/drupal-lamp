name "solr"
description "Install solr."

env_run_lists "_default" => [
                "recipe[drupal-solr]"
              ]
