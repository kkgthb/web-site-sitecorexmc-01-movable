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

---

* `a87a00b1-e6db-45ab-8b54-636fec3b5523` is a `Template: `-able GUID that seems to mean "folder" _(Sitecore built-in; the template of many of its other built-in folder types)_.
* `f5f0fbe3-61ad-4967-a5d8-8d760331d6a1` as a parent is a [magic GUID](https://github.com/Sitecore/Sitecore.Demo.Platform/blob/1691cebd27decf4c2a52f39670109325643caea7/src/items/Foundation.Serialization.Project.Layout.PlaceholderSettings/Project.yml#L4) for "`/sitecore/layout/Placeholder Settings/Project`"; use it as parent of your ancestriest "Placeholder Settings" / "Placeholder Settings Folder" definition item.
    * Its parent `1ce3b36c-9b0c-4eb5-a996-bfcb4eaa5287` is a [magic GUID](https://www.powershellgallery.com/packages/Sitecore.Pathfinder/0.11.0/Content/bin%5Cfiles%5Creferences%5CSitecore.Master.1.0.0.exports.xml) for `/sitecore/layout/Placeholder Settings` that you shouldn't ever need yourself.
    * I can't tell if YAML files with this as a parent are supposed to [have](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Mvp2025/Mvp/Mvp/PlaceholderSettings/mvp2025.yml) `Template: 3d281bf8-5336-4686-9dd6-ab4ab5b3fd5d` or [have](https://github.com/jflheureux/jss-nextjs-storybook/blob/5db1d3a9138d7f566c5fda7cd1ce9f715ebec359/src/items/placeholders/jss-nextjs-storybook.yml) `Template: c3b037a0-46e5-4b67-ac7a-a144b962a56f`.  I'm so confused.
        * This & 326 other repos [say](https://www.powershellgallery.com/packages/Sitecore.Pathfinder/0.11.0/Content/bin%5Cfiles%5Creferences%5CSitecore.Master.1.0.0.exports.xml) [2](https://github.com/PratikSatikunvar/SitecoreHackathon2017/blob/1b180f4a175301a6379c63733e90947a2991ad22/src/Project/Common/tds/Sitecore.Common.Website.Master/sitecore/layout/Placeholder%20Settings/Project/Common/Columns.item#L9): `<Template Id="{C3B037A0-46E5-4B67-AC7A-A144B962A56F}" Path="/sitecore/templates/System/Layout/Placeholder Settings Folder" BaseTemplates="{A87A00B1-E6DB-45AB-8B54-636FEC3B5523}" /><Item Id="{D5A0C201-0257-4DF0-8998-D3C731B9152E}" Template="{C3B037A0-46E5-4B67-AC7A-A144B962A56F}" Path="/sitecore/templates/System/Layout/Placeholder Settings Folder/__Standard Values" />`, [supporting](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/System/Layout/Placeholder%20Settings%20Folder/__Standard%20Values.yml#L4) the latter idea.
        * Only 32 repos include `3d281bf8-5336-4686-9dd6-ab4ab5b3fd5d`, which I guess is defined [here](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/Foundation/JSS%20Experience%20Accelerator/Multisite/Folders/Placeholder%20Settings%20Folder.yml#L4).  It in turn is just a basic System.Template.  Its parent is yet another GUID I can't place.
        * It seems that `3d281bf8-5336-4686-9dd6-ab4ab5b3fd5d` is a [weird JSS-SXA redefinition of "Placeholder Settings Folder"](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/Foundation/JSS%20Experience%20Accelerator/Multisite/Folders/Placeholder%20Settings%20Folder.yml#L4) _(`Path: /sitecore/templates/Foundation/JSS Experience Accelerator/Multisite/Folders/Placeholder Settings Folder`)_, whereas `c3b037a0-46e5-4b67-ac7a-a144b962a56f` is just [straight-up "Placeholder Settings Folder"](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/System/Layout/Placeholder%20Settings%20Folder.yml#L4) _(`Path: /sitecore/templates/System/Layout/Placeholder Settings Folder`)_.  I'm gonna follow the crowd and use the normal one.



* Trivia:  [fb6b721e-d64d-4392-a1f0-a15194cbfad9](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/System/Layout.yml#L4) -- System/Layout, and its parent, [4bf98ef5-1d09-4dd1-9afe-795f9829fd44](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/System.yml#L4), System.  And its parent, [3c1715fe-6a13-4fcf-845f-de308ba9741d](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates.yml#L4) templates.  And that one's parent 11111111-1111-1111-1111-111111111111 / template [ab86861a-6030-46c5-b394-e8f99e8b87db](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/System/Main%20section.yml#L4) (main section).

* `1995806f-0a84-42b5-93b0-88f0e2ff872c` = magic GUID for `Path: /sitecore/layout/Renderings/Project`, I think, for use as `Parent: ` in your "Renderings" YAML files that have a `Path: "/sitecore/layout/Renderings/Project/thefileorfolderfoldernameorsomething"`
    * Also for those YAML, if folder:  `7ee0975b-0698-493e-b3a2-0b2ef33d0522` [normal Rendering Folder](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/System/Layout/Renderings/Rendering%20Folder.yml#L4) for use as `Template: `; * `840d4a46-5503-49ec-bf9d-bd090946c63d` [weird JSS-SXA Rendering Folder reimplementation](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/Foundation/JSS%20Experience%20Accelerator/Multisite/Folders/Rendering%20Folder.yml#L4) for use as `Template: ` _(Sugcon uses it)_
    * And if actual rendering, your YAML file's `Template: ` will be `04646a89-996f-4ee7-878a-ffdbf1f0ef0d` [Path: /sitecore/templates/Foundation/JavaScript Services/Json Rendering](https://github.com/mahen1105/XmCloudTest/blob/89fdf5750c479f2e1e5d0a79fba92ac992a7bc9b/src/items/templates/templates/Foundation/JavaScript%20Services/Json%20Rendering.yml#L4)


---

Ponder:  [knowing that](https://www.powershellgallery.com/packages/Sitecore.Pathfinder/0.11.0/Content/bin%5Cfiles%5Creferences%5CSitecore.Master.1.0.0.exports.xml) Sitecore did the following **item UUIDv3** hashings, can we figure out their namespacing algorithm?

1. `00000000-0000-0000-0000-000000000000` -> (null)
1. `11111111-1111-1111-1111-111111111111` -> `/sitecore`
1. `EB2E4FFD-2761-4653-B052-26A64D385227` -> `/sitecore/layout`
1  `1b59149d-7ed3-4d58-86a9-32eded8c0368` -> `/sitecore/layout/Placeholder Settings/Feature`
1. `928a480f-8d07-4cc1-8b73-b46e20aabacc` -> `/sitecore/layout/Placeholder Settings/Foundation`
1. `f5f0fbe3-61ad-4967-a5d8-8d760331d6a1` -> `/sitecore/layout/Placeholder Settings/Project`
1. `3C1715FE-6A13-4FCF-845F-DE308BA9741D` -> `/sitecore/templates`
1. `825b30b4-b40b-422e-9920-23a1b6bda89c` -> `/sitecore/templates/Project`
1. `4BF98EF5-1D09-4DD1-9AFE-795F9829FD44` -> `/sitecore/templates/System`
1. `633549D3-4B7D-40EB-B58F-EDA50BA5F7F0` -> `/sitecore/templates/System/Templates`
1. `AB86861A-6030-46C5-B394-E8F99E8B87DB` -> `/sitecore/templates/System/Templates/Template`

I want to stick to it when I generate my own for strings like:

1. `/sitecore/layout/Placeholder Settings/Project/foo`
1. `/sitecore/layout/Placeholder Settings/Project/foo/bar`
1. `/sitecore/templates/Project/foo`
1. `/sitecore/templates/Project/foo/bar`
