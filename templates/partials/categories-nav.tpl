<div class="categories-nav">
    <ul class="nav nav-pills">
        <!-- BEGIN categories -->
        <li>
            <!-- IF categories.link -->
            <a href="{categories.link}" itemprop="url" target="_blank">
            <!-- ELSE -->
            <a href="{config.relative_path}/category/{categories.slug}" itemprop="url">
            <!-- ENDIF categories.link -->
            <h4>{categories.name}</h4>
            </a>
        </li>
        <!-- END categories -->
    </ul>

    <!-- IF cid -->
    <ul class="nav nav-pills">
        <!-- BEGIN subCategories -->
        <li>
            <!-- IF subCategories.link -->
            <a href="{subCategories.link}" itemprop="url" target="_blank">
            <!-- ELSE -->
            <a href="{config.relative_path}/category/{subCategories.slug}" itemprop="url">
            <!-- ENDIF subCategories.link -->
            <h4>{subCategories.name}</h4>
            </a>
        </li>
        <!-- END subCategories -->
    </ul>

