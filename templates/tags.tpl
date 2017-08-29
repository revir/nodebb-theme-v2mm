<div class="tags">
    <!-- IMPORT partials/breadcrumbs.tpl -->

    <!-- IF !tags.length -->
    <div class="alert alert-warning">
        <strong>[[tags:no_tags]]</strong>
    </div>
    <!-- ENDIF !tags.length -->

    <input class="form-control" type="text" id="tag-search" placeholder="[[global:search]]"/>
    <br/>

    <div class="category row">
        <div class="col-md-12 tag-list clearfix" data-nextstart="{nextStart}">
            <!-- IMPORT partials/tags_list.tpl -->
        </div>
        <div class="col-md-12">
            <div widget-area="footer" class="tags-footer">
                <!-- BEGIN widgets.footer -->
                {{widgets.footer.html}}
                <!-- END widgets.footer -->
            </div>
        </div>
    </div>
</div>
