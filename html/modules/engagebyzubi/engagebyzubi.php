<?php
/**
* 2007-2020 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2020 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*
* Don't forget to prefix your containers with your own identifier
* to avoid any conflicts with others containers.
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class EngageByZubi extends Module
{
    protected $zubiUrl = 'https://cors-dot-solutionsone-211314.ew.r.appspot.com/'.
    'https://realtime-dot-solutionsone-211314.appspot.com/v1/recommendations/products';

    public function __construct()
    {
        $this->name = 'engagebyzubi';
        $this->tab = 'smart_shopping';
        $this->version = '1.0.2';
        $this->author = 'zubi.ai';
        $this->need_instance = 0;

        /**
         * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
         */
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Product Recommendations by engage');
        $this->description = $this->l('Product Recommendations Module For Prestashop');

        $this->confirmUninstall = $this->l('Are you sure you want to uninstall? All recommendations will stop'.
        " displaying when the module is uninstalled. Remember to deactivate the webservice key when it's no".
        " longer needed.");

        $this->ps_versions_compliancy = array('min' => '1.6.1', 'max' => _PS_VERSION_);
        $this->module_key = 'f42de9e9099f75ab1c2d545055844f0e';
    }

    public function buildRecommendationDiv()
    {
        $recommend = '';
        $config = json_decode(Configuration::get('ZUBI_CONFIG'), true);
        $products = Context::getContext()->cart->getProducts();
        $product_ids = [];
        foreach ($products as $product) {
            $product_ids[] = (int) $product['id_product'];
        }
        $tid = '';
        $page = Tools::strtolower($this->context->controller->php_self);
        if ($page == 'product') {
            $tid = (int)$config['product_tpl'];
            $product_id = (string) Tools::getValue('id_product');
        } elseif ($page == 'order' || $page == 'order-opc') {
            $tid = (int)$config['order_tpl'];
            $product_id = implode(',', $product_ids);
        } elseif ($page == 'index') {
            $tid = (int)$config['index_tpl'];
            $product_id = implode(',', $product_ids);
        } elseif ($page == 'category') {
            $tid = (int)$config['category_tpl'];
            $product_id = implode(',', $product_ids);
        } elseif ($page == 'search') {
            $tid = (int)$config['search_tpl'];
            $product_id = implode(',', $product_ids);
        } elseif ($page == 'cart') {
            $tid = (int)$config['cart_tpl'];
            $product_id = implode(',', $product_ids);
        }
        if ($tid == '' || $tid == 0) {
            return $recommend;
        }
        $data = [
            '_token' => $config['user_token'],
            'origin' => 'ps',
            'tid' => $tid,
            'store' => '', # Possibly to be used for shop id
            'pid' => $product_id,
        ];
        $jsonData = json_encode($data);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->zubiUrl);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type:application/json']);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
        $result = curl_exec($ch);

        $recommend = '';
        if (curl_errno($ch)) {
            // this would be your first hint that something went wrong
            return $recommend;
        } else {
            // check the HTTP status code of the request
            $resultStatus = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            if ($resultStatus == 200) {
                // everything went better than expected
                $someArray = json_decode($result, true);
            } else {
                // the request did not complete as expected. common errors are 4xx and 5xx
                return $recommend;
            }
        }
        curl_close($ch);

        $count = 0;
        $link = new Link();
        $block_split = explode('<% |zl-pipe| %>', $someArray['html']);
        $products_received = $someArray['products'];
        $language_id = (int) Context::getContext()->language->id;
        array_pop($block_split);
        if (isset($products_received) && is_array($products_received)) {
            foreach ($block_split as $block) {
                $product = new Product((int)$products_received[$count], true, $language_id);
                $product_price = Product::getPriceStatic((int) $product->id);
                $product_url = $product->getLink(); //$link->getProductLink($product);
                if (strpos($product_url, '?') !== false) {
                    $product_url .= '&zlt_source=v1';
                } else {
                    $product_url .= '?zlt_source=v1';
                }
                $id_product_attribute = $product->cache_default_attribute;
                $image = Image::getCover($product->id);
                $img_link = new Link(); //because getImageLInk is not static function
                $imagePath = $img_link->getImageLink(
                    $product->link_rewrite,
                    $image['id_image'],
                    $this->getFormattedName('large')
                );
                $imagePath = 'https://' . $imagePath;
                $block = str_replace('<% product_name %>', $product->name, $block);
                $block = str_replace('<% add_to_cart_price %>', Tools::displayPrice($product_price), $block);
                $block = str_replace('<% product_price %>', Tools::displayPrice($product_price), $block);
                $block = str_replace('<% product_url %>', $product_url, $block);
                $block = str_replace('<% product_img %>', $imagePath, $block);

                if (_PS_VERSION_ >= 1.7) {
                    $block = str_replace(
                        '<% product_to_cart_url %>',
                        $link->getAddToCartURL($product->id, $id_product_attribute) . '&zlt_source=v1',
                        $block
                    );
                    $block = str_replace(
                        '<% add_to_cart %>',
                        $this->trans('Add to cart', [], 'Shop.Theme.Actions'),
                        $block
                    );
                } else {
                    $block = str_replace(
                        '<% product_to_cart_url %>',
                        $link->getProductLink($product->id) . '?zlt_source=v1',
                        $block
                    );
                    $block = str_replace('<% add_to_cart %>', $this->l('Add to cart'), $block);
                }
                $count += 1;
                $recommend .= $block;
            }
        }
        ?>
        <script type="text/javascript">
            var axr = "<?php  echo $someArray['font']; ?>";
        </script>
        <?php
        $recommend.= '
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.26/webfont.js"></script>
        <script type="text/javascript">
            if(axr != "inherit"){
                ty =axr ;
                WebFont.load({
                    google: {
                        families: [ axr,axr ]
                    }
                });
            }
        </script> ';

        return $recommend;
    }

    public function install()
    {
        if (file_exists(_PS_MODULE_DIR_ . 'engagebyzubi/keys.txt')) {
            $str = Tools::file_get_contents(_PS_MODULE_DIR_ . 'engagebyzubi/keys.txt');
            $envarr = explode(PHP_EOL, $str);
            $envvar = implode('&', $envarr);
            $arr = [];
            $envv = [];
            parse_str($envvar, $arr);
            foreach ($arr as $k => $e) {
                $envv[Tools::strtolower($k)] = $e;
            }
            $jsonRecords = json_encode([
                'user_token' => $envv['ebz_user_token'],
                'tracker_key' => $envv['ebz_tracker_key'],
                ]);
            Configuration::updateValue('ZUBI_CONFIG', $jsonRecords);
        } else {
            $jsonRecords = json_encode([
                'user_token' => '',
                'tracker_key' => '',
                ]);
            Configuration::updateValue('ZUBI_CONFIG', $jsonRecords);
        }

        return parent::install()
        //# Actions
        && $this->registerHook('actionFrontControllerSetMedia')
        && $this->registerHook('actionSearch')
        //# Tracker
        && $this->registerHook('displayProductExtraContent')
        && $this->registerHook('displayOrderConfirmation')
        //# Header
        && $this->registerHook('displayBanner')
        //# Top
        && $this->registerHook('displayTop')
        && $this->registerHook('displayWrapperTop')
        //# Column
        && $this->registerHook('displayTopColumn')
        && $this->registerHook('displayLeftColumn')
        && $this->registerHook('displayRightColumnProduct')
        //# Content
        && $this->registerHook('displayProductAdditionalInfo')
        //# Bottom
        && $this->registerHook('displayWrapperBottom')
        && $this->registerHook('displayBeforeBodyClosingTag')
        //# Footer
        && $this->registerHook('displayFooterBefore')
        && $this->registerHook('displayFooter')
        //# Home specific
        && $this->registerHook('displayHome')
        //# Cart specific
        && $this->registerHook('displayCrossSellingShoppingCart');
    }

    public function uninstall()
    {
        Configuration::deleteByName('ZUBI_CONFIG');

        return parent::uninstall();
    }

    /**
     * Check which hook should be used of the ones fired.
     * Return boolean
     */
    public function zubiChecker($hook)
    {
        if (!isset($this->context->controller->php_self)) {
            return false;
        }
        $page = Tools::strtolower($this->context->controller->php_self);
        $zubiConfig = json_decode(Configuration::get('ZUBI_CONFIG'), true);
        if (!array_key_exists($page, $zubiConfig)) {
            return false;
        }
        if ($hook != $zubiConfig[$page]) {
            return false;
        }
        Media::addJsDef(['tkey' => $zubiConfig['tracker_key']]);

        return true;
    }

    public function hookDisplayBanner($params)
    {
        if (!$this->zubiChecker('hookDisplayBanner')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayTop($params)
    {
        if (!$this->zubiChecker('hookDisplayTop')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayWrapperTop($params)
    {
        if (!$this->zubiChecker('hookDisplayWrapperTop')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayTopColumn($params)
    {
        if (!$this->zubiChecker('hookDisplayTopColumn')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayLeftColumn($params)
    {
        if (!$this->zubiChecker('hookDisplayLeftColumn')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayProductAdditionalInfo($params)
    {
        if (!$this->zubiChecker('hookDisplayProductAdditionalInfo')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayWrapperBottom($params)
    {
        if (!$this->zubiChecker('hookDisplayWrapperBottom')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayBeforeBodyClosingTag($params)
    {
        if (!$this->zubiChecker('hookDisplayBeforeBodyClosingTag')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayFooterBefore($params)
    {
        if (!$this->zubiChecker('hookDisplayFooterBefore')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayFooter($params)
    {
        if (!$this->zubiChecker('hookDisplayFooter')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayHome($params)
    {
        if (!$this->zubiChecker('hookDisplayHome')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayCrossSellingShoppingCart($params)
    {
        if (!$this->zubiChecker('hookDisplayCrossSellingShoppingCart')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayRightColumnProduct($params)
    {
        if (!$this->zubiChecker('hookDisplayRightColumnProduct')) {
            return '';
        }
        return $this->buildRecommendationDiv();
    }

    public function hookDisplayProductExtraContent($params)
    {
        $product = $params['product'];
        Media::addJsDef(['product_id' => $product->id]);
        Media::addJsDef(['product_name' => $product->name]);
        Media::addJsDef(['product_price' => $product->price]);
    }

    public function hookDisplayOrderConfirmation($params)
    {
        if (array_key_exists('order', $params)) {
            $order = $params['order'];
        } else {
            $order = $params['objOrder'];
        }

        $customer = new Customer((int) $order->id_customer);
        $address = new Address((int) $order->id_address_delivery);
        $address2 = new Address((int) $order->id_address_invoice);
        $products = $order->getProducts();

        $order_info = array(
          'order_id' => $order->id,
          'payment' => $order->payment,
          'gift' => $order->gift,
          'total_discounts' => $order->total_discounts,
          'total_paid' => $order->total_paid,
          'total_paid_tax' => (float)$order->total_paid_tax_incl - (float)$order->total_paid_tax_excl,
          'total_shipping' => $order->total_shipping,
          'total_wrapping' => $order->total_wrapping,
          'date_add' => $order->date_add,
          'date_upd' => $order->date_upd
        );
        $address_billing_info = array(
          'country' => $address2->country,
          'company' => $address2->company,
          'lastname' => $address2->lastname,
          'firstname' => $address2->firstname,
          'address1' => $address2->address1,
          'address2' => $address2->address2,
          'postcode' => $address2->postcode,
          'city' => $address2->city,
          'phone' => $address2->phone,
          'phone_mobile' => $address2->phone_mobile,
          'vat_number' => $address2->vat_number
        );
        $address_shipping_info = array(
          'country' => $address->country,
          'company' => $address->company,
          'lastname' => $address->lastname,
          'firstname' => $address->firstname,
          'address1' => $address->address1,
          'address2' => $address->address2,
          'postcode' => $address->postcode,
          'city' => $address->city,
          'phone' => $address->phone,
          'phone_mobile' => $address->phone_mobile,
          'vat_number' => $address->vat_number
        );

        Media::addJsDef(['order_info' => $order_info]);
        Media::addJsDef(['user_id' => $customer->email]);
        Media::addJsDef(['address_billing_info' => $address_billing_info]);
        Media::addJsDef(['address_shipping_info' => $address_shipping_info]);
        Media::addJsDef(['products' => $products]);
    }

    public function hookActionSearch($params)
    {
        Media::addJsDef(['expr' => $params['expr']]);
        Media::addJsDef(['total' => $params['total']]);
    }

    public function hookActionFrontControllerSetMedia($params)
    {
        $ZUBI_CONFIG = Configuration::get('ZUBI_CONFIG');
        $recommendation_settings = json_decode($ZUBI_CONFIG, true);
        Media::addJsDef(['tkey' => $recommendation_settings['tracker_key']]);
        $this->context->controller->addJS([$this->_path . 'views/js/maintracker.js']);
    }

    private function getFormattedName($name) {
        if (method_exists("ImageType", "getFormattedName")) {
            return ImageType::getFormattedName($name);
        } else {
            return ImageType::getFormatedName($name);
        }
    }

    //for configure section///
    public function getContent()
    {
        $this->context->controller->addJS([$this->_path . 'views/js/configure.js']);
        $this->context->controller->addCSS([
          'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css',
          'https://assets.zubitracker.io/v1/editor/css/spectrum.min.css',
          'https://assets.zubitracker.io/v1/editor/css/ps/jquery.toolbar.css',
          'https://assets.zubitracker.io/v1/editor/css/dragula.min.css',
          'https://assets.zubitracker.io/v1/editor/css/slick.css',
          'https://assets.zubitracker.io/v1/editor/css/slick-theme.css',
          'https://assets.zubitracker.io/v1/editor/css/fontselect-default.css',
          'https://assets.zubitracker.io/v1/editor/css/style.css?organizationId=976124082806',
          'https://fonts.googleapis.com/icon?family=Material+Icons',
          'https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css',
          'https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css'
        ]);

        $this->context->controller->addJS([
          //'https://assets.zubitracker.io/v1/editor/js/jquery-3.4.1.min.js',
          'https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js',
          'https://assets.zubitracker.io/v1/editor/js/jquery-ui.min.js',
          'https://assets.zubitracker.io/v1/editor/js/jquery.toolbar.min.js',
          'https://assets.zubitracker.io/v1/editor/js/spectrum.min.js',
          'https://assets.zubitracker.io/v1/editor/js/dragula.min.js',
          'https://assets.zubitracker.io/v1/editor/js/jquery.fontselect.min.js',
          'https://assets.zubitracker.io/v1/editor/js/slick.min.js'
        ]);

        $msg = '';
        if (Tools::isSubmit('savebutton')) {
            $place_product_page = Tools::getValue('product');
            $place_category_page = Tools::getValue('category');
            $place_start_page = Tools::getValue('index');
            $place_checkout_page = Tools::getValue('order');
            $place_cart_page = Tools::getValue('cart');
            $place_mincart_page = Tools::getValue('mincart');
            $place_search_page = Tools::getValue('search');

            $place_product_page_tpl = Tools::getValue('product_tpl');
            $place_category_page_tpl = Tools::getValue('category_tpl');
            $place_start_page_tpl = Tools::getValue('index_tpl');
            $place_checkout_page_tpl = Tools::getValue('order_tpl');
            $place_cart_page_tpl = Tools::getValue('cart_tpl');
            $place_mincart_page_tpl = Tools::getValue('mincart_tpl');
            $place_search_page_tpl = Tools::getValue('search_tpl');

            $user_token = Tools::getValue('user_token');
            $tracker_key = Tools::getValue('tracker_key');

            if (!$user_token || empty($user_token) || !Validate::isGenericName($user_token)) {
                $msg .= '<p style="text-align:center; color:red">Invalid user token</p>';
            } elseif (!$tracker_key || empty($tracker_key) || !Validate::isGenericName($tracker_key)) {
                $msg .= '<p style="text-align:center; color:red">Invalid tracker key</p>';
            } else {
                $jsonRecords = json_encode([
                    'product' => $place_product_page,
                    'category' => $place_category_page,
                    'index' => $place_start_page,
                    'order' => $place_checkout_page,
                    'order-opc' => $place_checkout_page,
                    'cart' => $place_cart_page,
                    'mincart' => $place_mincart_page,
                    'search' => $place_search_page,

                    'product_tpl' => $place_product_page_tpl,
                    'category_tpl' => $place_category_page_tpl,
                    'index_tpl' => $place_start_page_tpl,
                    'order_tpl' => $place_checkout_page_tpl,
                    'order-opc_tpl' => $place_checkout_page_tpl,
                    'cart_tpl' => $place_cart_page_tpl,
                    'mincart_tpl' => $place_mincart_page_tpl,
                    'search_tpl' => $place_search_page_tpl,

                    'user_token' => $user_token,
                    'tracker_key' => $tracker_key,
                    ]);

                Configuration::updateValue('ZUBI_CONFIG', $jsonRecords);
                $msg = '<p style="text-align:center; color:green">Configuration Data Save Successfully</p>';
            }
        }

        $id_shop = (int)Context::getContext()->shop->id;
        $ZUBI_CONFIG = Configuration::get('ZUBI_CONFIG');
        $PS_SHOP_EMAIL = Configuration::get('PS_SHOP_EMAIL');
        //$PS_MULTISHOP_FEATURE_ACTIVE = Configuration::get('PS_MULTISHOP_FEATURE_ACTIVE');
        $PS_SHOP_DOMAIN = Configuration::get('PS_SHOP_DOMAIN_SSL');
        if (empty($PS_SHOP_DOMAIN)) {
            $PS_SHOP_DOMAIN = Configuration::get('PS_SHOP_DOMAIN');
        }

        /*if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on') {
            $link= "https";
        } else {
            $link= "http";
        }*/
        $link = "https://";
        $link.= $_SERVER['HTTP_HOST'];
        $link.= $_SERVER['REQUEST_URI'];
        $link.= "&zl=1";

        $original_link = str_replace("&zl=1", "&zl=0", $link);

        $products = Product::getProducts($this->context->cookie->id_lang, 0, 8, 'name', 'ASC', false, true);
        $zl_products = array();
        foreach ($products as $tmpproduct) {
            $zl_product = [];
            $product = new Product($tmpproduct['id_product'], true, $this->context->language->id);
            $images = $product->getImages($this->context->language->id);
            if (isset($images) && !empty($images)) {
                $zl_product['image'] = $this->context->link->getImageLink(
                    $product->link_rewrite,
                    $images[0]['id_image'],
                    $this->getFormattedName('large')
                );
                if (sizeof($images) > 1) {
                    $zl_product['image2'] = $this->context->link->getImageLink(
                        $product->link_rewrite,
                        $images[1]['id_image'],
                        $this->getFormattedName('large')
                    );
                } else {
                    $zl_product['image2'] = $zl_product['image'];
                }
            } else {
                $zl_product['image'] = 'https://via.placeholder.com/450x450.png?text=No+image+found';
                $zl_product['image2'] = 'https://via.placeholder.com/450x450.png?text=No+image+found';
            }
            $zl_product['pid'] = $product->id;
            $zl_product['handle'] = '';
            $zl_product['name'] = $product->name;
            $product_price = Product::getPriceStatic((int) $product->id);
            $zl_product['price'] = Tools::displayPrice($product_price);
            array_push($zl_products, $zl_product);
        };

        //$PS_SHOP_DEFAULT = Configuration::get('PS_SHOP_DEFAULT');
        $this->context->smarty->assign([
                'imagePath' => $this->_path . 'views/img/engage_logo.png',
                'msg' => $msg,
                'ZUBI_CONFIG' => $ZUBI_CONFIG,
                'USER_TOKEN' => json_decode($ZUBI_CONFIG)->user_token,
                'storeVersion' => _PS_VERSION_,
                'PS_SHOP_EMAIL' => $PS_SHOP_EMAIL,
                'PS_SHOP_DOMAIN' => $PS_SHOP_DOMAIN,
                'PS_SHOP_ID' => $id_shop,
                'EDITOR_URL' => $link,
                'START_URL' => $original_link,
                'ZUBI_PRODS' => json_encode($zl_products)
            ]);
        if (Tools::getValue('zl') == '1') {
            return $this->display(__FILE__, 'views/templates/admin/newdesign.tpl');
        } else {
            return $this->display(__FILE__, 'views/templates/admin/configure.tpl');
        }
    }
}
