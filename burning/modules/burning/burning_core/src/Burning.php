<?php

/**
 * @contains Drupal\burning_core\Burning.
 */
namespace Drupal\burning_core;

use Kint;

class Burning {

  /**
   * Alias for Kint dump method.
   *
   * @param $value
   *   The value to evaluate.
   */
  static public function dpm($value) {
    Kint::dump($value);
  }

}