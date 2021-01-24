<?php
/* Smarty version 3.1.34-dev-7, created on 2021-01-24 19:26:31
  from '/var/www/html/admin220galuyv/themes/default/template/content.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_600dbbd7d4aac3_84366652',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '05e7fa292226987741cb4b490f069095c5c7234a' => 
    array (
      0 => '/var/www/html/admin220galuyv/themes/default/template/content.tpl',
      1 => 1610363806,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_600dbbd7d4aac3_84366652 (Smarty_Internal_Template $_smarty_tpl) {
?><div id="ajax_confirmation" class="alert alert-success hide"></div>
<div id="ajaxBox" style="display:none"></div>

<div class="row">
	<div class="col-lg-12">
		<?php if (isset($_smarty_tpl->tpl_vars['content']->value)) {?>
			<?php echo $_smarty_tpl->tpl_vars['content']->value;?>

		<?php }?>
	</div>
</div>
<?php }
}
