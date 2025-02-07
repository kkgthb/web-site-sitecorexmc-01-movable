This is the depth-equivalent of [XM Cloud Intro's](https://github.com/Sitecore/XM-Cloud-Introduction/tree/main):

* sitecore.json
* /authoring
    * /platform
    * /items
        * /Sugcon2024
            * /Sugcon
                * sugcon.module.json
                * /Sugcon
                    * /Templates
                        * Sugcon2024.yml & Sugcon2024/ _("Path: /sitecore/templates/Project/Sugcon2024"; parent 825b30b4-b40b-422e-9920-23a1b6bda89c (/sitecore/templates/Project))_
                            * Headless Site.yml & Headless Site/
                            * Headless Tenant.yml & Headless Tenant/
                            * Page.yml & Page/
                            * etc. _(JSS Settings.yml&/, Page Design Folder.yml&/, Page Designs.yml&/, Partial Design Folder.yml&/, Partial Designs.yml&/)_


But instead, to match [Robbert Hock's style guide](https://www.kayee.nl/category/sitecore/sitecore-content-serialization-scs/), it's:

* sitecore.json
* /authoringsrc
    * /platform
    * /items
        * /whatever _(folder name does not matter, but I might want more one day)_
            * /Project.FirstAttempt
                * maybe_any_name.module.json
                * /items
                    * /templates
                        * myfirstsitecollection.yml & myfirstsitecollection/ _("Path: Path: /sitecore/templates/Project/myfirstsitecollection"; parent 825b30b4-b40b-422e-9920-23a1b6bda89c (/sitecore/templates/Project))_
                            * Headless Site.yml & Headless Site/
                            * Headless Tenant.yml & Headless Tenant/
                            * _(thus far, I've skipped Page.yml & Page/ because it doesn't always seem to get used in all setups)_
                            * _(maybe one day "etc.")_

Also the depth-equivalent of [XM Cloud Intro's](https://github.com/Sitecore/XM-Cloud-Introduction/tree/main):

* sitecore.json
* /authoring
    * /platform
    * /items
        * /Mvp
            * /Project.MvpSite
                * MvpSite.module.json
                * /items
                    * /templates
                        * MvpSite.yml & MvpSite/ _("Path: /sitecore/templates/Project/mvp2025"; parent 825b30b4-b40b-422e-9920-23a1b6bda89c (/sitecore/templates/Project))_
                            * Page.yml & Page/
                            * Page Components Folder.yml & Page Components Folder/
                            * Homepage.yml & Homepage/ _(interesting, must not be headless -- that's it)_