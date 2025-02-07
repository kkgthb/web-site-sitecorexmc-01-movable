I have not actually yet written this codebase.

It's gonna take me forever to reverse-engineer other people's codebases configuring XM Cloud and guess how to write it as tiny as possible, since Sitecore for some inexplicable reason refuses to do a developer instance program like Sanity CMS, Salesforce, AWS, etc. do.

(Do they not _want_ people to have any confidence in XM Cloud before migrating to it?  Dudes.  Let developers Hello World properly.)

## Misc

`./.config/dotnet-tools.json` is how your computer knows to install the Sitecore CLI for you on whatever computer you end up downloading this repo onto.

`./sitecore.json` is how your computer knows which Sitecore CLI plugins to install and tells the Sitecore CLI a little bit about your project file structure choices.

`./.sitecore/schemas/` has 3 `*.schema.json` files in it that ... honestly, I haven't had a chance to look into what they do, but they came with `sitecore init` and I also see them in [an XM Cloud example](https://github.com/Sitecore/Sitecore.Demo.XmCloud.PlaySummit/tree/main/.sitecore/schemas).

It looks like `C:\license\license.xml` is a [standard place on a host system](https://github.com/Sitecore/Sitecore.Demo.XmCloud.PlaySummit/blob/main/docs/prerequisites.md) to keep a copy of a Sitecore 10 license file.

---

2/7/25:  Although I see `Path: /sitecore/templates/Project/myfirstsitecollection/Page`-typed `Page.yml` files in many projects, I see some where it exists, but its ID never show up as the actual `Template: ` value in any serialized content items _(whereas in other projects, said ID does appear in many content items that way)_ -- nor, in such projects, do its grandchild `Path: /sitecore/templates/Project/myfirstsitecollection/Page/Content/Title`-typed or `Path: /sitecore/templates/Project/myfirstsitecollection/Page/Content/Title`-typed definition item IDs ever get referenced from real content item serializations..  I wonder if I can get away with just not bothering to have the `Page.yml` file and `Page` folder in my codebase at all under `./authoringsrc/items/templates/Project/myfirstsitecollection/`.

---

My "templates" is the depth-equivalent of [XM Cloud Intro's](https://github.com/Sitecore/XM-Cloud-Introduction/tree/main):

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