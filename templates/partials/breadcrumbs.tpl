<!-- IF breadcrumbs.length -->
<ol class="breadcrumb">
    <!-- BEGIN breadcrumbs -->
    <li<!-- IF @last --> component="breadcrumb/current"<!-- ENDIF @last --> itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb" <!-- IF @last -->class="active hidden-xs hidden-sm"<!-- ENDIF @last -->>
        <!-- IF !@last --><a href="{breadcrumbs.url}" itemprop="url"><!-- ENDIF !@last -->
            <span itemprop="title">
                {breadcrumbs.text}
                <!-- IF @last -->
                <!-- IF !feeds:disableRSS -->
                <!-- IF rssFeedUrl --><a target="_blank" href="{rssFeedUrl}"><i class="fa fa-rss-square"></i></a><!-- ENDIF rssFeedUrl --><!-- ENDIF !feeds:disableRSS -->

                <a href="#" class='need-share-button' title="分享">
                    <i class="fa fa-share-alt" aria-hidden="true"></i>
                </a>

                <!-- ENDIF @last -->
            </span>
        <!-- IF !@last --></a><!-- ENDIF !@last -->
    </li>
    <!-- END breadcrumbs -->
</ol>
<!-- ENDIF breadcrumbs.length -->
