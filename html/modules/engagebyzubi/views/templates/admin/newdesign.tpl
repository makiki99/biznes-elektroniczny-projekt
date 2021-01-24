<!-- /**
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
*/ -->

<script >
	$(document).ready(function(){
		validate({if $storeVersion gte 1.7}{$ZUBI_CONFIG}{else}{$ZUBI_CONFIG|escape:'quotes':'utf-8'}{/if});
		if ($('#user_token').val() == '' || $('#tracker_key').val() == '') {
			$('.getRegistered').css('display','');
			$('.isRegistered').css('display','none');
		};
	});
</script>
	<div class="panel">
		<div class="row" style="display: flex;align-items: baseline;">
			<div class="col-sm-8">
				<h4 style="margin: 20px 0 0;">Design</h4>
			</div>
			<div class="col-sm-4" style="text-align: right;">
				<button id="zl_go_back" type="button" class="btn btn-default">Cancel and go back</button>
			</div>
		</div>
		<div class="panel-body">
			<div class="row isRegistered">
				<div id="zlEditor"></div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.26/webfont.js"></script>
<script type="text/javascript" src="https://assets.zubitracker.io/v1/editor/js/editor.js" data-key="{if $storeVersion gte 1.7}{$USER_TOKEN}{else}{$USER_TOKEN|escape:'quotes':'utf-8'}{/if}" data-name="editorjs"></script>


<script type="text/javascript">

function removeParam(key, sourceURL) {
    var rtn = sourceURL.split("?")[0],
        param,
        params_arr = [],
        queryString = (sourceURL.indexOf("?") !== -1) ? sourceURL.split("?")[1] : "";
    if (queryString !== "") {
        params_arr = queryString.split("&");
        for (var i = params_arr.length - 1; i >= 0; i -= 1) {
            param = params_arr[i].split("=")[0];
            if (param === key) {
                params_arr.splice(i, 1);
            }
        }
        rtn = rtn + "?" + params_arr.join("&");
    }
    return rtn;
}

	$( "#zl_go_back" ).on( "click", function(e) {
		var editorURL = "{if $storeVersion gte 1.7}{{$START_URL}}{else}{{$START_URL|escape:'quotes':'utf-8'}}{/if}";
		editorURL = removeParam('zl',editorURL);
		editorURL = removeParam('edit_id',editorURL);
		window.location.href = editorURL;
	});

	const zlcallBack = function() {
     jQuery( "#save" ).on( "new_design_added", function( event, design_id, design_name ) {
			 window.location.href = "{if $storeVersion gte 1.7}{{$START_URL}}{else}{{$START_URL|escape:'quotes':'utf-8'}}{/if}";
     });
  };
	var zl_products = {if $storeVersion gte 1.7}{{$ZUBI_PRODS}}{else}{{$ZUBI_PRODS|escape:'quotes':'utf-8'}}{/if};
	const urlParams = new URLSearchParams(window.location.search);
  const edit_id = urlParams.get('edit_id');
	if(edit_id != "" && edit_id != null && typeof edit_id != undefined && typeof edit_id != 'undefined' ){
     const editor = new zlEditor("edit",edit_id,zl_products,zlcallBack);
	editor.init();
    }else{
     const editor = new zlEditor("new","",zl_products,zlcallBack);
	editor.init();
    }
</script>
