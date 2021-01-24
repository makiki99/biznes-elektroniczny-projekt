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
<div style="max-width:900px;margin:0 auto;">
<form method="POST">
	<div class="row">
		<div class="col-sm-12">
			<div class="panel-body">
				<div style="text-align:center;">
					<img src="{if $storeVersion gte 1.7}{$imagePath}{else}{$imagePath|escape:'htmlall':'utf-8'}{/if}" width="70%">
				</div>
			</div>
		</div>
		<br><br>
		{if $storeVersion gte 1.7}{$msg}{else}{$msg|escape:'htmlall':'utf-8'}{/if}
		<br><br>
		<div style="padding: 10px;width: 100%;display: flex;justify-content: flex-end;">
			<a href="https://engage.zubi.help" target="_blank">Visit the <i>engage</i> help center</a>
		</div>
	</div>
	<div class="panel" style="display: flex;align-items: center;">
		<div class="col-sm-12">
			<div class="row isRegistered">
				<div class="col-sm-12">
					<h3>Recommendation blocks</h3>
					<table id="zl_designs" class="table">
					  <thead>
					    <tr>
					      <th>#</th>
					      <th>Recommendation Block</th>
					      <th></th>
					      <th></th>
					      <th></th>
					    </tr>
					  </thead>
					  <tbody>
					  </tbody>
					</table>
					<div style="text-align:right;margin-top:20px;">
						<button id="start_editor" type="button" class="btn btn-primary"> + Create recommendation block</button>
					</div>
				</div>
			</div>
			<div class="getRegistered" style="display:none;text-align:center;">
				<p class="description" style="text-align:center;margin-top:40px;margin-bottom:10px;">Get started by connecting your store to <i>engage</i>.<br>
				This will setup the necessary webservice key and permissions.</p>
				<!-- Button trigger modal -->
				<button id="modal_connect_btn" type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
				  Connect your store
				</button>
				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content" style="text-align:left;">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				        <h4 class="modal-title" id="myModalLabel">Connect</h4>
				      </div>
				      <div class="modal-body">
				      Connect {$PS_SHOP_DOMAIN} to the <i>engage</i> platform to get started. <i>engage</i> will extract your data, analyze it and build the models required to serve smart recommendations. <br/><br/>
							<fieldset class="form-group">
							<label class="form-control-label" for="exampleInput3">Email</label>
							 <input id="emailfieldvalue" type="text" class="form-control edit" value="{$PS_SHOP_EMAIL}"></input>
							</fieldset>
							<fieldset class="form-group">
							<label class="form-control-label" for="exampleInput3">Password</label>
							 <input id="textfieldvalue" placeholder="Set your password" type="password" class="form-control edit"></input>
							</fieldset>
							<i>engage</i> is an e-commerce personalization platform that helps online stores to increase sales and improve customer experience through AI-powered personalization.<br /><br />
							By signing up, you agree to the <a href="https://docs.engage.zubi.ai/terms-and-conditions-1/terms-and-conditions" target="_blank">terms</a> and our <a href="https://docs.engage.zubi.ai/terms-and-conditions-1/privacy-policy" target="_blank">privacy policy</a>.
				      </div>
				      <div class="modal-footer">
				        <button id="modal_cancel" type="button" class="btn btn-tertiary-outline btn-lg" data-dismiss="modal">Close</button>
				        <button id="gkey" type="button" class="btn btn-primary btn-lg">Connect</button>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
		</div>
		</div>

		<div class="panel isRegistered">
			<div class="" style="width: 100%;display: flex;">
				<h3 style="width: 100%;">Product Recommendation statistics</h3>
			</div>
			<table id="statistics" class="table">
				<thead>
					<tr>
						<th>Month</th>
						<th>Recommendations</th>
						<th>Interactions</th>
						<th>Indirect Attributable Revenue</th>
						<th>Direct Attributable Revenue</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<div style="width: 100%;display: flex;justify-content: flex-end;">
				<a href="https://engage.zubi.ai" target="_blank">Get more stats</a>
			</div>
		</div>


			<div class="isRegistered">
				<h2 style="margin: 60px 0 20px 0;text-align: center;">Deploy Recommendation Blocks</h2>
				<hr style="border-top: 1px solid #555;margin-bottom:0;">
				<div class='panel-footer' style="text-align: right;">
					<button id="savebutton" class='btn btn-success' type='submit' name='savebutton'>Save</button>
				</div>
				<h3 style="margin: 20px 0 0;">Product page recommendations</h3>
				<div class="panel" style="display: flex;">
					<div class="col-sm-7">
				  	<div class="form-group">
				    	<label for="product">Where on the product page would you like to display the recommendations?</label>
				    	<select name="product" id="product" class="form-control">
								<option value="" >Do not display</option>
								<option value="hookDisplayBanner" >displayBanner</option>
								<option value="hookDisplayTop" >displayTop</option>
								{if $storeVersion gte 1.7}<option value="hookDisplayWrapperTop" >displayWrapperTop</option>{/if}
								{if $storeVersion lt 1.7}<option value="hookDisplayTopColumn" >displayTopColumn</option>{/if}
								{if $storeVersion lt 1.7}<option value="hookDisplayRightColumnProduct" >displayRightColumnProduct</option>{/if}
								{if $storeVersion gte 1.7}<option value="hookDisplayProductAdditionalInfo" >displayProductAdditionalInfo</option>{/if}
								{if $storeVersion gte 1.7}<option value="hookDisplayWrapperBottom" >displayWrapperBottom</option>{/if}
								{if $storeVersion gte 1.7}<option value="hookDisplayBeforeBodyClosingTag" >displayBeforeBodyClosingTag</option>{/if}
								<option value="hookDisplayFooter" >displayFooter</option>
							</select>
				  	</div>
					</div>
					<div class="col-sm-5">
				  	<div class="form-group">
				    	<label for="product">Which recommendation block would you like to use?</label>
				    	<select name="product_tpl" id="product_tpl" class="form-control zl-tpl">
								<option value="">None</option>

							</select>
				  	</div>
					</div>
				</div>
				<h3 style="margin: 20px 0 0;">Category page recommendations</h3>
				<div class="panel" style="display: flex;">
					<div class="col-sm-7">
				  	<div class="form-group">
				    	<label for="category">Where on the category page would you like to display the recommendations?</label>
				    	<select name="category" id="category" class="form-control">
								<option value="" >Do not display</option>
								<option value="hookDisplayBanner" >displayBanner</option>
								<option value="hookDisplayTop" >displayTop</option>
								{if $storeVersion gte 1.7}<option value="hookDisplayWrapperTop" >displayWrapperTop</option>{/if}
								{if $storeVersion lt 1.7}<option value="hookDisplayTopColumn" >displayTopColumn</option>{/if}
								<option value="hookDisplayLeftColumn" >displayLeftColumn</option>
								{if $storeVersion gte 1.7}<option value="hookDisplayWrapperBottom" >displayWrapperBottom</option>{/if}
								{if $storeVersion gte 1.7}<option value="hookDisplayBeforeBodyClosingTag" >displayBeforeBodyClosingTag</option>{/if}
								{if $storeVersion gte 1.7}<option value="hookDisplayFooterBefore" >displayFooterBefore</option>{/if}
								<option value="hookDisplayFooter" >displayFooter</option>
							</select>
				  	</div>
					</div>
					<div class="col-sm-5">
				  	<div class="form-group">
				    	<label for="product">Which recommendation block would you like to use?</label>
				    	<select name="category_tpl" id="category_tpl" class="form-control zl-tpl">
								<option value="">None</option>

							</select>
				  	</div>
					</div>
				</div>


				<h3 style="margin: 20px 0 0;">Start page recommendations</h3>
				<div class="panel" style="display: flex;">
				<div class="col-sm-7">
		  	<div class="form-group">
		    	<label for="index">Where on the start page would you like to display the recommendations?</label>
		    	<select name="index" id="index" class="form-control">
					<option value="" >Do not display</option>
					<option value="hookDisplayBanner" >displayBanner</option>
					<option value="hookDisplayTop" >displayTop</option>
					{if $storeVersion gte 1.7}<option value="hookDisplayWrapperTop" >displayWrapperTop</option>{/if}
					<option value="hookDisplayHome" >displayHome</option>
					{if $storeVersion lt 1.7}<option value="hookDisplayTopColumn" >displayTopColumn</option>{/if}
					{if $storeVersion gte 1.7}<option value="hookDisplayWrapperBottom" >displayWrapperBottom</option>{/if}
					{if $storeVersion gte 1.7}<option value="hookDisplayBeforeBodyClosingTag" >displayBeforeBodyClosingTag</option>{/if}
					{if $storeVersion gte 1.7}<option value="hookDisplayFooterBefore" >displayFooterBefore</option>{/if}
					<option value="hookDisplayFooter" >displayFooter</option>
				</select>
		  	</div>
		  	</div>
				<div class="col-sm-5">
					<div class="form-group">
						<label for="product">Which recommendation block would you like to use?</label>
						<select name="index_tpl" id="index_tpl" class="form-control zl-tpl">
							<option value="">None</option>

						</select>
					</div>
				</div>
		  	</div>

				<h3 style="margin: 20px 0 0;">Checkout page recommendations</h3>
				<div class="panel" style="display: flex;">
				<div class="col-sm-7">
		  	<div class="form-group">
		    	<label for="order">Where on the checkout page would you like to display the recommendations?</label>
		    	<select name="order" id="order" class="form-control">
					<option value="" >Do not display</option>
					{if $storeVersion lt 1.7}<option value="hookDisplayBanner" >displayBanner</option>{/if}
					{if $storeVersion lt 1.7}<option value="hookDisplayTop" >displayTop</option>{/if}
					{if $storeVersion gte 1.7}<option value="hookDisplayWrapperTop" >displayWrapperTop</option>{/if}
					{if $storeVersion lt 1.7}<option value="hookDisplayTopColumn" >displayTopColumn</option>{/if}
					{if $storeVersion lt 1.7}<option value="hookDisplayLeftColumn" >displayLeftColumn</option>{/if}
					<option value="hookDisplayWrapperBottom" >displayWrapperBottom</option>
					<option value="hookDisplayBeforeBodyClosingTag" >displayBeforeBodyClosingTag</option>
					{if $storeVersion lt 1.7}<option value="hookDisplayFooterBefore" >displayFooterBefore</option>{/if}
					{if $storeVersion lt 1.7}<option value="hookDisplayFooter" >displayFooter</option>{/if}
				</select>
		  	</div>
		  	</div>
				<div class="col-sm-5">
					<div class="form-group">
						<label for="product">Which recommendation block would you like to use?</label>
						<select name="order_tpl" id="order_tpl" class="form-control zl-tpl">
							<option value="">None</option>

						</select>
					</div>
				</div>
		  	</div>

				{if $storeVersion gte 1.7}
				<h3 style="margin: 20px 0 0;">Cart page recommendations</h3>
				<div class="panel" style="display: flex;">
				<div class="col-sm-7">
		  	<div class="form-group">
		    	<label for="cart">Where on the cart page would you like to display the recommendations?</label>
		    	<select name="cart" id="cart" class="form-control">
					<option value="" >Do not display</option>
					<option value="hookDisplayBanner" >displayBanner</option>
					<option value="hookDisplayTop" >displayTop</option>
					<option value="hookDisplayWrapperTop" >displayWrapperTop</option>
					<option value="hookDisplayWrapperBottom" >displayWrapperBottom</option>
					<option value="hookDisplayBeforeBodyClosingTag" >displayBeforeBodyClosingTag</option>
					<option value="hookDisplayFooterBefore" >displayFooterBefore</option>
					<option value="hookDisplayFooter" >displayFooter</option>
				</select>
		  	</div>
		  	</div>
				<div class="col-sm-5">
					<div class="form-group">
						<label for="product">Which recommendation block would you like to use?</label>
						<select name="cart_tpl" id="cart_tpl" class="form-control zl-tpl">
							<option value="">None</option>

						</select>
					</div>
				</div>
		  	</div>
				{/if}

		  	<!-- <br><br>
		  	<h3>Mini cart page recommendations</h3>
		  	<div class="form-group">
		    	<label for="place_mincart_page">Where on the mini cart page would you like to display the recommendations?</label>


		    	<select name="place_mincart_page" id="place_mincart_page" class="form-control">
					<option value="0" >Do not display</option>
					<option value="1" >After summary</option>
					<option value="2" >After product</option>
				</select>
			</div> -->


		<h3 style="margin: 20px 0 0;">Search page recommendations</h3>
		<div class="panel" style="display: flex;">
		<div class="col-sm-7">
	  	<div class="form-group">
	    	<label for="search">Where on the search page would you like to display the recommendations?</label>
	    	<select name="search" id="search" class="form-control">
					<option value="" >Do not display</option>
					<option value="hookDisplayBanner" >displayBanner</option>
					<option value="hookDisplayTop" >displayTop</option>
					{if $storeVersion gte 1.7}<option value="hookDisplayWrapperTop" >displayWrapperTop</option>{/if}
					{if $storeVersion lt 1.7}<option value="hookDisplayTopColumn" >displayTopColumn</option>{/if}
					{if $storeVersion lt 1.7}<option value="hookDisplayLeftColumn" >displayLeftColumn</option>{/if}
					<option value="hookDisplayWrapperBottom" >displayWrapperBottom</option>
					<option value="hookDisplayBeforeBodyClosingTag" >displayBeforeBodyClosingTag</option>
					<option value="hookDisplayFooterBefore" >displayFooterBefore</option>
					<option value="hookDisplayFooter" >displayFooter</option>
				</select>
	  	</div>
		</div>
		<div class="col-sm-5">
			<div class="form-group">
				<label for="product">Which recommendation block would you like to use?</label>
				<select name="search_tpl" id="search_tpl" class="form-control zl-tpl">
					<option value="">None</option>

				</select>
			</div>
		</div>
	</div>

	<!--			<br><br><br>
		  	<h4>Image option</h4>
				<hr>
		  	<div class="form-group">
		    	<label for="center_squared">Center and square images to improve the display of recommendations.</label>
		    	<select name="center_squared" id="center_squared" class="form-control">
					<option value="1" >Center & Square images</option>
					<option value="0" >Do not Center & Square</option>
				</select>
			</div> -->
</div>
<div class="isRegistered">
	<h2 style="margin: 60px 0 20px 0;text-align: center;">Other Settings</h2>
	<!-- <h4 class="getRegistered" style="margin: 60px 0 20px 0;text-align: center;">Or connect manually using API keys</h4> -->
	<hr style="border-top: 1px solid #555;margin-bottom:0;">
	<div class='panel-footer' style="text-align: right;">
		<button id="savebutton" class='btn btn-success' type='submit' name='savebutton'>Save</button>
	</div>
	<h3 style="margin: 20px 0 0;">Set User Token and Tracker Key</h3>
	<div class="panel" style="display: flex;">
		<div class="col-sm-6">
			<label ><strong>User token</strong></label><br>
			<input name="user_token" id="user_token" value="" placeholder="Insert your user token here" class='form-control'>
		</div>
		<div class="col-sm-6">
			<label><strong>Tracker key</strong></label><br>
			<input name="tracker_key" id="tracker_key" class="form-control"  value="" placeholder="Insert your tracker key here">
		</div>
	</div>
	<!-- <div class='panel-footer'>
		<button id="savebutton" class='btn btn-success' type='submit' name='savebutton'>Save</button>
	</div> -->
</form>
</div>

<!-- Modal -->
<div class="modal fade" id="confirmDelete" tabindex="-1" role="dialog" aria-labelledby="confirmDelete" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content" style="text-align:left;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Delete Recommendation Block</h4>
			</div>
			<div class="modal-body">
				This will delete the recommendation block. Any page displaying recommendations using this recommendation block will stop showing recommendations.
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-tertiary-outline btn-lg" data-dismiss="modal">Close</button>
				<button id="zlDeleteMe" type="button" class="btn btn-danger btn-lg">Delete</button>
			</div>
		</div>
	</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
<script type="text/javascript">
	var zlConfig = {if $storeVersion gte 1.7}{$ZUBI_CONFIG}{else}{$ZUBI_CONFIG|escape:'quotes':'utf-8'}{/if};
	if (zlConfig['user_token'] != '') {
		$.ajax({
	    url : 'https://api-dot-solutionsone-211314.ew.r.appspot.com/v1/templates/onpagerecommendations',
	    type : 'GET',
	    data : {
	      "_token": zlConfig['user_token'],
	    },
	    dataType:'json',
	    success : function(data) {
	      if (data['message'] == 'success') {
	        for (const [key, value] of Object.entries(data['blocks'])) {
						$('.zl-tpl').each(function(e){
							var setSelcted = false;
							if (value['id'] == zlConfig[$(this).attr('name')]) { setSelcted = true; }
							$(this).append(new Option(value['name']['value'], value['id'], setSelcted, setSelcted));
						});
						$('#zl_designs tr:last').after('<tr><td scope="row">'+value['id']+'</td><td>'+value['name']['value']+'</td><td></td><td style=text-align:right;><button data-id="'+value['id']+'" class="zledit btn-link">Edit block</button></td><td style=text-align:right;><button data-id="'+value['id']+'" class="zldeleteme btn-link" data-toggle="modal" data-target="#confirmDelete">Delete block</button></td></tr>');
	        }

					$('.zledit').click(function (e) {
						e.preventDefault();
						e.stopImmediatePropagation();
						var id = $(this).attr('data-id');
						var f = "{if $storeVersion gte 1.7}{{$EDITOR_URL}}{else}{{$EDITOR_URL|escape:'quotes':'utf-8'}}{/if}";
						window.location.href = f+' &edit_id='+id+'&zl=1';
					});

					$('.zldeleteme').click(function (e) {
						e.preventDefault();
						e.stopImmediatePropagation();
						$('#zlDeleteMe').attr("data-id",$(this).attr('data-id'));
						$('#zlDeleteMe').attr('data-id');
						$('#confirmDelete').modal('show');
					});

					$('#zlDeleteMe').click(function (e) {
						e.preventDefault()
						e.stopImmediatePropagation();
						var id = $(this).attr('data-id');
						$.ajax({
							url : 'https://api-dot-solutionsone-211314.ew.r.appspot.com/v1/templates/onpagerecommendations',
							type : 'DELETE',
							data : {
								"id": id,
								"_token": zlConfig['user_token'],
							},
							dataType:'json',
							success : function(data) {
								if (data['message'] == 'success') {
									location.reload();
								}
							},
							error : function(request,error) {
								console.log(error);
							}
						});
						return false;
					});
	      }
	    },
	    error : function(request,error) {
	      console.log(error);
	    }
	  });

		$.ajax({
        url : 'https://api-dot-solutionsone-211314.ew.r.appspot.com/v1/statistics',
        type : 'GET',
        data : {
          "_token": zlConfig['user_token'],
          "period": 'one.year',
        },
        dataType:'json',
        success : function(data) {
          if (data['message'] == 'success') {
            for (const [key, value] of Object.entries(data['data'])) {
							$('#statistics tr:last').after('<tr><td scope="row">'+value['month']+'</td><td>'+value['recommendations']+'</td><td>'+value['interactions']+'</td><td>'+value['interact_revenue']+'</td><td>'+value['rec_revenue']+'</td></tr>');
            }
          }
        },
        error : function(request,error) {
          console.log(error);
        }
      });
	}



	$(document).ready(function(){
		$('#myTabBordered a').click(function (e) {
			e.preventDefault();
			$(this).tab('show');
		});

	});
	function isEmail(email) {
		{literal}var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;{/literal}
		return regex.test(email);
	}
	$( "#modal_connect_btn" ).on( "click", function(e) {
		$(this).html('<i class="fas fa-circle-notch fa-spin"></i> Connect your store');
		$(".error").remove();
	});

	$( "#modal_cancel" ).on( "click", function(e) {
		e.preventDefault();
		$("#modal_connect_btn").text('Connect your store');
		$('#myModal').modal('hide');
	});

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

    $( "#start_editor" ).on( "click", function(e) {
        var x = "{if $storeVersion gte 1.7}{{$EDITOR_URL}}{else}{{$EDITOR_URL|escape:'quotes':'utf-8'}}{/if}";
        x = removeParam('edit_id',x);
        window.location.replace(x);
    });


	$( "#gkey" ).on( "click", function(e) {
		e.preventDefault();
		var emailFieldValue = $("#emailfieldvalue").val();
		var textFieldValue = $("#textfieldvalue").val();
		$(".error").remove();
		if (emailFieldValue.length < 1) {
			$('#gkey').parent().before('<span class="error" style="padding: 15px;color: #bf0711;text-align: center;">Please provide an email address</span>');
			return;
		}
		if (!isEmail(emailFieldValue)) {
			$('#gkey').parent().before('<span class="error" style="padding: 15px;color: #bf0711;text-align: center;">Please provide a valid email address</span>');
			return;
		}
		if (textFieldValue.length < 1) {
			$('#gkey').parent().before('<span class="error" style="padding: 15px;color: #bf0711;text-align: center;">Please provide a password</span>');
			return;
		}
		var query = $.ajax({
			type: 'POST',
			url: '../modules/engagebyzubi/zubi-ajax.php',
			data: 'method=myMethod&pwd='+textFieldValue,
			dataType: 'json',
			success: function(jsonData) {
				var key = CryptoJS.enc.Hex.parse('6eb097bbc7912db4aa4e4a93fcb25029');
	      var iv  = CryptoJS.enc.Hex.parse('2f968784a0f40b54223b0088a7ecf069');
	      var encrypted = CryptoJS.AES.encrypt(textFieldValue, key, { iv:iv,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.ZeroPadding });
	      var password_base64 = encrypted.ciphertext.toString(CryptoJS.enc.Base64);

	      $.ajax({
	        url : 'https://cors-dot-solutionsone-211314.ew.r.appspot.com/https://api-dot-solutionsone-211314.appspot.com/v1/connect/app',
	        type : 'POST',
	        data : {
	          "pwd": password_base64,
	          "uid": emailFieldValue,
	          "email": emailFieldValue,
	          "platform": "presta",
						"store_id":"{if $storeVersion gte 1.7}{$PS_SHOP_DOMAIN}{else}{$PS_SHOP_DOMAIN|escape:'quotes':'utf-8'}{/if}",
						"shop_id":"{if $storeVersion gte 1.7}{$PS_SHOP_ID}{else}{$PS_SHOP_ID|escape:'quotes':'utf-8'}{/if}",
	          "api_token": jsonData['result'],
	        },
	        dataType:'json',
	        success : function(data) {
	          if (data['status'] == 'success') {
							$('#user_token').val(data['uk_key']);
							$('#tracker_key').val(data['tk_key']);
	          }
						$('#myModal').modal('hide');
						$( "#savebutton" ).trigger( "click" );
	        },
	        error : function(request,error) {
	          console.log(error);
	        }
	      });
			}
		});
	});
</script>
