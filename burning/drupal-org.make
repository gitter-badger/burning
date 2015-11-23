core = 7.x
api = 2

projects[admin_menu][subdir] = "contrib"
projects[admin_menu][version] = 3.0-rc5

projects[addressfield][subdir] = "contrib"
projects[addressfield][version] = 1.2

projects[ctools][subdir] = "contrib"
projects[ctools][version] = 1.9

projects[commerce][subdir] = "contrib"
projects[commerce][version] = 1.11

projects[date][subdir] = "contrib"
projects[date][version] = 2.9

projects[devel][subdir] = "contrib"
projects[devel][version] = 1.5

projects[diff][subdir] = "contrib"
projects[diff][version] = 3.2

projects[email][subdir] = "contrib"
projects[email][version] = 1.3

projects[entity][subdir] = "contrib"
projects[entity][branch] = 7.x-1.x
projects[entity][patch][] = https://www.drupal.org/files/issues/2086225-entity-access-check-18.patch

projects[entitycache][subdir] = "contrib"
projects[entitycache][version] = "1.2"

projects[entityreference][subdir] = "contrib"
projects[entityreference][version] = 1.1

projects[entityreference_prepopulate][subdir] = "contrib"
projects[entityreference_prepopulate][version] = 1.5

projects[entity_validator][subdir] = "contrib"
projects[entity_validator][download][type] = git
projects[entity_validator][download][url] = "https://github.com/Gizra/entity_validator.git"
projects[entity_validator][download][branch] = "7.x-1.x"
projects[entity_validator][download][revision] = "dc2615490d2bd7ea42fb6f16992ea8f6b5936d4d"

projects[entity_translation][subdir] = "contrib"
projects[entity_translation][version] = 1.0-beta4

projects[facetapi][subdir] = "contrib"
projects[facetapi][version] = 1.5

projects[feeds][subdir] = "contrib"
projects[feeds][version] = 2.0-beta1

projects[feeds_jsonpath_parser][subdir] = "contrib"
projects[feeds_jsonpath_parser][version] = 1.0

projects[features][subdir] = "contrib"
projects[features][version] = 2.7

projects[job_scheduler][subdir] = "contrib"
projects[job_scheduler][version] = 2.0-alpha3

projects[gravatar][version] = "1.1"
projects[gravatar][subdir] = contrib

projects[geolocation][version] = "1.6"
projects[geolocation][subdir] = contrib

projects[link][subdir] = "contrib"
projects[link][version] = 1.3

projects[libraries][subdir] = "contrib"
projects[libraries][version] = 2.2

projects[message][version] = "1.10"
projects[message][subdir] = contrib

projects[message_ui][version] = "1.4"
projects[message_ui][subdir] = contrib

projects[message_notify][version] = "2.5"
projects[message_notify][subdir] = contrib

projects[message_subscribe][version] = "1.0-rc2"
projects[message_subscribe][subdir] = contrib

projects[module_filter][subdir] = "contrib"
projects[module_filter][version] = 2.0

projects[migrate][subdir] = "contrib"
projects[migrate][version] = 2.8

projects[migrate_extras][subdir] = "contrib"
projects[migrate_extras][version] = 2.5

projects[oauth][version] = 3.2
projects[oauth][subdir] = contrib

projects[og][subdir] = contrib
projects[og][version] = 2.7

projects[restful][subdir] = "contrib"
projects[restful][download][type] = git
projects[restful][download][url] = "https://github.com/RESTful-Drupal/restful.git"
projects[restful][download][branch] = "7.x-1.x"
projects[restful][download][revision] = "14a145e4423df8bc3975c18bb50c4aae6d82f7ca"

projects[strongarm][subdir] = "contrib"
projects[strongarm][version] = 2.0

projects[views][subdir] = "contrib"
projects[views][version] = 3.11

projects[views_bulk_operations][subdir] = "contrib"

projects[votingapi][subdir] = "contrib"
projects[votingapi][version] = "2.12"

projects[token][subdir] = "contrib"
projects[token][version] = 1.6

projects[twitter][version] = "5.8"
projects[twitter][subdir] = contrib

projects[title][version] = "1.0-alpha7"
projects[title][subdir] = contrib

projects[search_api][version] = "1.16"
projects[search_api][subdir] = contrib

projects[search_api_solr][version] = "1.9"
projects[search_api_solr][subdir] = contrib

projects[rules][version] = "2.9"
projects[rules][subdir] = contrib

projects[xautoload][version] = "5.5"
projects[xautoload][subdir] = contrib

; Libraries.
libraries[pusher][type] = "libraries"
libraries[pusher][download][type] = git
libraries[pusher][download][url] = "https://github.com/pusher/pusher-http-php.git"

libraries[reCaptcha][type] = "libraries"
libraries[reCaptcha][download][type] = git
libraries[reCaptcha][download][url] = "https://github.com/google/recaptcha.git"

libraries[jsonpath][type] = "libraries"
libraries[jsonpath][download][type] = file
libraries[jsonpath][download][url] = "http://jsonpath.googlecode.com/svn/trunk/src/php/jsonpath.php"
