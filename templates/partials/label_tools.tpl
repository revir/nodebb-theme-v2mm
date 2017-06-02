<!-- IF privileges.isAdminOrMod -->
<div class="btn-group label-tools">
    <button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">
        <span class="visible-sm-inline visible-md-inline visible-lg-inline">[[v2mm:label_tools.title]]</span>
        <span class="visible-xs-inline"><i class="fa fa-fw fa-leaf"></i></span>
        <span class="caret"></span>
    </button>
    <ul class="dropdown-menu pull-right">
        <!-- BEGIN availabelLabels -->
        <li>
            <a href=""
            class="toggle-label"
            style="background-color: {availabelLabels.bkColor}; color: {availabelLabels.color}"
            data-name={availabelLabels.name}>

            {availabelLabels.value}
            </a>
        </li>
        <!-- END availabelLabels -->

        <li>
            <a href="" class="removeAllLabels">
                <i class="fa fa-fw fa-remove"></i> [[v2mm:label_tools.removeAllLabels]]
            </a>
        </li>
      
    </ul>
</div>
<!-- ENDIF privileges.isAdminOrMod -->
