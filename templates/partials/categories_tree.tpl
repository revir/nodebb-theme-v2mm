<div class="categories-tree dropdown-menu" aria-labelledby="dropdown-categories">
    <!-- BEGIN categories -->
    <div class="dropdown-item">
        <span class="category-root">
            <!-- IF categories.link -->
            <a href="{categories.link}" itemprop="url" target="_blank">
            <!-- ELSE -->
            <a href="{config.relative_path}/category/{categories.slug}" itemprop="url">
            <!-- ENDIF categories.link -->
            <span>{categories.name}</span>
            </a>
        </span>

        <span class="category-children">
            <!-- BEGIN children -->
            <!-- IF categories.children.link -->
            <a href="{categories.children.link}" itemprop="url" target="_blank">
            <!-- ELSE -->
            <a href="{config.relative_path}/category/{categories.children.slug}" itemprop="url">
            <!-- ENDIF categories.children.link -->
            <span>{categories.children.name}</span>
            </a>
            <!-- END children -->
        </span>
    </div>
    <!-- END categories -->

</div>
