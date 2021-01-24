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

$(document).ready(function () {
  window.TRACKER_KEY = tkey;
	function zltTrackOnLoad() {
    try {
      if (prestashop.customer.email !== null) {
        zlt.track('user', {
				    user_id: prestashop.customer.email
				});
      }
    } catch {}

    try {
      if (prestashop.page.page_name == 'product') {
				zlt.track('Product Viewed', {
				 product_id: product_id,
				 name: product_name,
				 price: product_price,
				 currency: prestashop.currency.iso_code,
				 product_url: window.location.href
				});
      } else if (prestashop.page.page_name == 'order-confirmation') {

				var line_items = [];
        if (Array.isArray(products)) {
          products.forEach(function(item){
  					line_items.push({
  						product_id: item['product_id'],
  						name: item['product_name'],
  						price: item['product_price'],
  						quantity: item['product_quantity']
  					});
  				});
        } else {
          item = products[Object.keys(products)[0]];
          line_items.push({
            product_id: item['product_id'],
            name: item['product_name'],
            price: item['product_price'],
            quantity: item['product_quantity']
          });
        }

        zlt.track('user', {
				    user_id: user_id
				});

				zlt.track('Order Completed', {
      		email: user_id,
			    billing_address_first_name: address_billing_info['firstname'],
			    billing_address_last_name: address_billing_info['lastname'],
			    billing_address_company: address_billing_info['company'],
			    billing_address_zip: address_billing_info['postcode'],
			    billing_address_phone: address_billing_info['phone'],
			    billing_address_mobile_phone: address_billing_info['phone_mobile'],
			    billing_address_address1: address_billing_info['address1'],
			    billing_address_address2: address_billing_info['address2'],
			    billing_address_city: address_billing_info['city'],
			    billing_address_country: address_billing_info['country'],
					shipping_address_first_name: address_shipping_info['firstname'],
					shipping_address_last_name: address_shipping_info['lastname'],
					shipping_address_company: address_shipping_info['company'],
					shipping_address_zip: address_shipping_info['postcode'],
					shipping_address_phone: address_shipping_info['phone'],
					shipping_address_mobie_phone: address_shipping_info['phone_mobile'],
					shipping_address_address1: address_shipping_info['address1'],
					shipping_address_address2: address_shipping_info['address2'],
					shipping_address_city: address_shipping_info['city'],
					shipping_address_country: address_shipping_info['country'],
          order_id: order_info['order_id'],
				  payment_method: order_info['payment'],
				  total: order_info['total_paid'],
				  shipping: order_info['total_shipping'],
				  tax: order_info['total_paid_tax'],
				  discount: order_info['total_discounts'],
				  wrapping: order_info['total_wrapping'],
				  coupons: order_info['gift'],
				  currency: prestashop.currency.iso_code,
				  products: line_items,
					created_at: order_info['date_add'],
					updated_at: order_info['date_upd']
				});
      }
    } catch {}

		try {
			zlt.track('Page Viewed', {page_type: prestashop.page.page_name});
		} catch {}
  }

  try {
		var helper={loadScript:function(e,t){var r,a,n;a=!1,(r=document.createElement("script")).type="text/javascript",r.src=e,r.onload=r.onreadystatechange=function(){a||this.readyState&&"complete"!=this.readyState||(a=!0,t&&t())},console.log(""),(n=document.getElementsByTagName("script")[0]).parentNode.insertBefore(r,n)}};String.prototype.hashCode=function(){if(Array.prototype.reduce)return this.split("").reduce(function(e,t){return(e=(e<<5)-e+t.charCodeAt(0))&e},0);var e=0;if(0===this.length)return e;for(var t=0;t<this.length;t++){e=(e<<5)-e+this.charCodeAt(t),e&=e}return e},window.zTCD=function(){navigator.userAgent;var e=document.referrer,t=window.location.href;return""==e&&(e="Direct Link"),{tracker_key:TRACKER_KEY,uid:"",user_ip:"",suid:"",uuid:t.hashCode(),page_url:t,referrer:e,dts:new Date}}(),"loading"!==document.readyState?void 0!==helper&&helper&&helper.loadScript&&helper.loadScript("https://assets.zubitracker.io/v1/tracker/js/zubitracker.js",zltTrackOnLoad):document.addEventListener("DOMContentLoaded",function(){void 0!==helper&&helper&&helper.loadScript&&helper.loadScript("https://assets.zubitracker.io/v1/tracker/js/zubitracker.js",zltTrackOnLoad)});
	} catch {}


});
