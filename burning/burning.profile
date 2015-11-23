<?php

/**
 * Implements hook_install_tasks().
 */
function burning_install_tasks($install_state) {
  $tasks = array();

  // OS flavors (production, development, etc).
  $tasks['burning_settings'] = array(
    'display_name' => t('Import content settings'),
    'type' => 'form',
  );

  $tasks['burning_migrate_content'] = array(
    'display_name' => t('Importing content'),
    'type' => 'batch',
    'display' => variable_get('dh_dummy_content'),
    'run' => variable_get('dh_dummy_content') ? INSTALL_TASK_RUN_IF_REACHED : INSTALL_TASK_SKIP,
  );

  $tasks['burning_variables_set'] = array(
    'display_name' => t('Setting variables'),
  );

  return $tasks;
}

/**
 * Implements hook_install_tasks_alter().
 */
function burning_install_tasks_alter(&$tasks, $install_state) {
  $tasks['install_finished']['function'] = 'burning_install_finished';
  $tasks['install_finished']['display_name'] = t('Finished');
  $tasks['install_finished']['type'] = 'normal';
}

/**
 * Flavor selection form.
 */
function burning_settings($form, &$form_state) {
  $form['dummy_content'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add dummy content'),
    '#description' => t('If checked, dummy content will be added to your burning site.'),
  );

  $form['he_default_language'] = array(
    '#type' => 'checkbox',
    '#title' => t('Hebrew default language'),
    '#description' => t('Define Hebrew as default language. uncheck for testing environment.'),
    '#default_value' => TRUE,
  );

  $form['submit'] = array(
    '#type' => 'submit',
    '#value' => t('Next'),
  );

  return $form;
}

/**
 * Submit handler; Set the variable for indicate if the profile task of migrate
 * content need to be invoked.
 */
function burning_settings_submit($form, $form_state) {
  variable_set('dh_dummy_content', $form_state['values']['dummy_content']);
  variable_set('he_default_language', $form_state['values']['he_default_language']);
}

/**
 * Migrating content from csv.
 */
function burning_migrate_content() {
  $migrations = migrate_migrations();
  foreach ($migrations as $machine_name => $migration) {
    $operations[] = array('_burning_migrate_content', array($machine_name, t('Importing content.')));
  }

  $batch = array(
    'title' => t('Importing content'),
    'operations' => $operations,
  );

  return $batch;
}

/**
 * Batch callback function - migrating the content from csv files.
 */
function _burning_migrate_content($class, $type, &$context) {
  $context['message'] = t('Importing @class', array('@class' => $class));
  $migration =  Migration::getInstance($class);
  $migration->processImport();
}

/**
 * Step for setting up variables.
 */
function burning_variables_set() {
  $variables = array(
    'theme_default' => 'seven',
    'admin_theme' => 'seven',
    'node_options_page',
    'node_options_page' => array('status'),
    'comment_page' => COMMENT_NODE_HIDDEN,
    'node_submitted_page' => FALSE,
    'user_pictures' => '1',
    'user_picture_dimensions' => '1024x1024',
    'user_picture_file_size' => '800',
    'user_picture_style' => 'thumbnail',
    'user_register' => USER_REGISTER_VISITORS_ADMINISTRATIVE_APPROVAL,
    'node_admin_theme' => 1,
    'jquery_update_jquery_version' => 1.8,
    'jquery_update_jquery_admin_version' => 1.5,
    'caret_position' => 'profiles/burning/libraries/jquery_caret_position',
    'page_manager_node_view_disabled' => FALSE,
    'page_manager_user_view_disabled' => FALSE,
    'page_manager_term_view_disabled' => FALSE,
    'site_frontpage' => 'node',
    'entity_view_count_track_user' => array(),
    'user_picture_path' => '',
    'pusher' => array(
      'app_id' => '',
      'key' => '',
      'secret' => ''
    ),
    'recaptcha_secret' => '',
    'entity_translation_settings_node__camp' => array(
      'default_language' => LANGUAGE_NONE,
      'hide_language_selector' => FALSE,
      'exclude_language_none' => TRUE,
      'lock_language' => FALSE,
      'shared_fields_original_only' => FALSE,
    ),
    'language_content_type_camp' => ENTITY_TRANSLATION_ENABLED,
//    'feeds_jsonpath_library_dir' => DRUPAL_ROOT . '/profiles/burning/libraries/jsonpath',
  );

  foreach ($variables as $name => $value) {
    variable_set($name, $value);
  }
}

/**
 * Running the function when the installation process is finished.
 */
function burning_install_finished(&$install_state) {
  drupal_set_title(st('burning installation complete'));
  $messages = drupal_get_messages();
  $output = '<p>' . st('Congratulations, you\'ve successfully installed burning!') . '</p>';
  if (isset($messages['error'])) {
    $output .= '<p>' . st('There are some problems. Please check them.') . '</p>';
  }
  else {
    $output .= '<p>' . st('Your site has installed fully.') . '</p>';
  }

  $output .= '<p>' . t('Please go ahead and visit your <a href="@url">Website</a>', array('@url' => url(''))) . '</p>';

  // Flush all caches to ensure that any full bootstraps during the installer
  // do not leave stale cached data, and that any content types or other items
  // registered by the install profile are registered correctly.
  drupal_flush_all_caches();

  // Remember the profile which was used.
  variable_set('install_profile', drupal_get_profile());

  // Install profiles are always loaded last
  db_update('system')
    ->fields(array('weight' => 1000))
    ->condition('type', 'module')
    ->condition('name', drupal_get_profile())
    ->execute();

  // Cache a fully-built schema.
  drupal_get_schema(NULL, TRUE);

  // Remove the variable we used during the installation.
  variable_del('dh_dummy_content');

  // Run cron to populate update status tables (if available) so that users
  // will be warned if they've installed an out of date Drupal version.
  // Will also trigger indexing of profile-supplied content or feeds.
  drupal_cron_run();

  return $output;
}
