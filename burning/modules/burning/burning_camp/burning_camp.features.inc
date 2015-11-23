<?php
/**
 * @file
 * burning_camp.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function burning_camp_ctools_plugin_api($module = NULL, $api = NULL) {
  if ($module == "feeds" && $api == "feeds_importer_default") {
    return array("version" => "1");
  }
}

/**
 * Implements hook_node_info().
 */
function burning_camp_node_info() {
  $items = array(
    'camp' => array(
      'name' => t('Camp'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  drupal_alter('node_info', $items);
  return $items;
}
