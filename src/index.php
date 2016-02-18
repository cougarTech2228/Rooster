<?php
/**
 * File: index.php
 * User: zacharydubois
 * Date: 2016-02-17
 * Time: 19:21
 * Project: Rooster
 */

define('DS', DIRECTORY_SEPARATOR);
define('PATH', __DIR__ . DS);
define('APP', PATH . 'rooster' . DS);
define('STORAGE', PATH . 'storage' . DS);

// DO NOT EDIT
define('VERSION', 'v0.0.1');

require APP . 'inc' . DS . 'load.php';