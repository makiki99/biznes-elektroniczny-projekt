<?php
/**
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License (OSL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/osl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

header("Access-Control-Allow-Origin: *");

include_once(dirname(__FILE__).'../../../config/config.inc.php');
include_once(dirname(__FILE__).'../../../init.php');

Configuration::updateValue('PS_WEBSERVICE', 1);
$length = 32;
$x='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
$newKey = Tools::substr(str_shuffle(str_repeat($x, ceil($length/Tools::strlen($x)))), 1, $length);
$apiAccess = new WebserviceKey();
$apiAccess->key = $newKey;
$apiAccess->description = 'Webservice key for engage';
$apiAccess->save();
/*
$permissions = [
  'shops' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'customers' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'orders' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'addresses' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'currencies' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'countries' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'products' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'languages' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'categories' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'order_states' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'configurations' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
  'stock_availables' => ['GET' => 1, 'POST' => 0, 'PUT' => 0, 'DELETE' => 0, 'HEAD' => 1],
];
*/

$permissions = [
  'shops' => ['GET' => 1, 'HEAD' => 1],
  'customers' => ['GET' => 1, 'HEAD' => 1],
  'orders' => ['GET' => 1, 'HEAD' => 1],
  'addresses' => ['GET' => 1, 'HEAD' => 1],
  'currencies' => ['GET' => 1, 'HEAD' => 1],
  'countries' => ['GET' => 1, 'HEAD' => 1],
  'products' => ['GET' => 1, 'HEAD' => 1],
  'languages' => ['GET' => 1, 'HEAD' => 1],
  'categories' => ['GET' => 1, 'HEAD' => 1],
  'order_states' => ['GET' => 1, 'HEAD' => 1],
  'configurations' => ['GET' => 1, 'HEAD' => 1],
  'stock_availables' => ['GET' => 1, 'HEAD' => 1],
];

WebserviceKey::setPermissionForAccount($apiAccess->id, $permissions);

switch (Tools::getValue('method')) {
    case 'myMethod':
        $return = array('result' => $newKey);
        echo json_encode($return);
        break;
    default:
        exit;
}
