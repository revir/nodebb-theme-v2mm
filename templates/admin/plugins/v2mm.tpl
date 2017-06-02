<div class="col-lg-9">
	<div class="panel panel-default">
		<div class="panel-heading">V2MM Theme Settings</div>
		<div class="panel-body">
			<form>
				<label>Disable Masonry
					<input id="disableMasonry" type="checkbox" data-field="disableMasonry" />
				</label>

			</form>
		</div>
	</div>

	<div class="panel panel-default">
		<div class="panel-heading">Topic Labels</div>
		<div class="panel-body">
			<ul class="list-group topic-label-list">
				<!-- BEGIN availabelLabels -->
				<li class="list-group-item topic-label-li" data-name={availabelLabels.name}>
					<span class="labels">
						<a class="label topic-label" 
							href="" 
							style="background-color: {availabelLabels.bkColor}; color: {availabelLabels.color}; padding: 3px 4px; font-weight: 600; border-radius: 2px;">
							{availabelLabels.value}
	            		</a>
	            	</span>

            		<label for="bkColor">Background Colour:</label>
            		<input placeholder="#ffffff" data-name="bkcolor" value="{availabelLabels.bkColor}" class="bkColor color-picker" />
					
					<label for="color">Text Colour:</label>
            		<input placeholder="#ffffff" data-name="color" value="{availabelLabels.color}" class="color color-picker" />
					
					<button class="btn btn-sm btn-default save-label-item">Save</button>

            		<a href="" class="remove" title="Remove">
            		    <i class="fa fa-fw fa-remove"></i>
            		</a>

				</li>
				<!-- END availabelLabels -->
				<li class="list-group-item">
					<input id="create-label" type="text" placeholder="Input label name">
				</li>
			</ul>
		</div>
	</div>
</div>

<div class="col-lg-3 acp-sidebar">
	<div class="panel panel-default">
		<div class="panel-heading">Save Settings</div>
		<div class="panel-body">
			<button class="btn btn-primary btn-md" id="save">Save Changes</button>
			<button class="btn btn-warning btn-md" id="revert">Revert Changes</button>
		</div>
	</div>
</div>

<!-- <script>
	require(['admin/settings'], function(Settings) {
		Settings.prepare();
	});
</script> -->
