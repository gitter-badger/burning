<?php
/**
 * @file
 * burning_camp.features.inc
 */

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
