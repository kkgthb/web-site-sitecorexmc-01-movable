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
1.  `1b59149d-7ed3-4d58-86a9-32eded8c0368` -> `/sitecore/layout/Placeholder Settings/Feature`
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

---

---

Some more values I don't want to lose track of:

1. `1930BBEB-7805-471A-A3BE-4858AC7CF696` -> `/sitecore/templates/System/Templates/Standard template`
1. `44a022db-56d3-419a-b43b-e27e4d8e9c41` -> `/sitecore/templates/Foundation/Experience Accelerator/StandardValues/_PerSiteStandardValues` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/Foundation/Experience%20Accelerator/StandardValues/_PerSiteStandardValues.yml) is a data template)_
1. `0437fee2-44c9-46a6-abe9-28858d9fee8c` -> `/sitecore/templates/System/Templates/Template Folder`
1. `455A3E98-A627-4B40-8035-E683A0331AC7` -> `/sitecore/templates/System/Templates/Template field`
1. `5D44F8DB-1F5C-40F5-9206-E6107E93CAE3` -> `/sitecore/templates/System/Templates/Template field/Data` ?
1. `19a69332-a23e-4e70-8d16-b2640cb24cc8` -> `/sitecore/templates/System/Templates/Template field/Data/Title` ?
1. `04bf00db-f5fb-41f7-8ab7-22408372a981` -> `/sitecore/templates/System/Templates/Sections/Layout/Layout/__Final Renderings` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/System/Templates/Sections/Layout/Layout/__Final%20Renderings.yml) is a template field)_
1. `04646a89-996f-4ee7-878a-ffdbf1f0ef0d` -> `/sitecore/templates/Foundation/JavaScript Services/Json Rendering` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/Foundation/JavaScript%20Services/Json%20Rendering.yml) is a data template)_
1. `1a7c85e5-dc0b-490d-9187-bb1dbcb4c72f` -> `/sitecore/templates/System/Layout/Sections/Rendering Options/Editor Options/Datasource Template` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/System/Layout/Sections/Rendering%20Options/Editor%20Options/Datasource%20Template.yml) is a template field)_
1. `1172f251-dad4-4efb-a329-0c63500e4f1e` -> `/sitecore/templates/System/Templates/Sections/Insert Options/Insert Options/__Masters`  _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/System/Templates/Sections/Insert%20Options/Insert%20Options/__Masters.yml) is a template field)_
1. `7ee0975b-0698-493e-b3a2-0b2ef33d0522` -> `/sitecore/templates/System/Layout/Renderings/Rendering Folder` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/System/Layout/Renderings/Rendering%20Folder.yml) is a data template)_
1. `F5BC7AE4-F62D-47CD-9AFB-2C9F85D8313B` -> `/sitecore/templates/System/Templates/Sections/Appearance`
1. `CD312499-F3D0-4AFC-B7BD-FD58AD20667B` -> `/sitecore/templates/System/Templates/Sections/Appearance` ?
1. `B5E02AD9-D56F-4C41-A065-A133DB87BDEB` -> `/sitecore/templates/System/Templates/Sections/Appearance/__Display name` ?
1. `BA3F86A2-4A1C-4D78-B63D-91C2779C1B5E` -> `/sitecore/templates/System/Templates/Sections/Appearance/__Sortorder` ?
1. `1105b8f8-1e00-426b-bf1f-c840742d827b` -> `/sitecore/templates/Foundation/JSS Experience Accelerator/Presentation/Page Design` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/Foundation/JSS%20Experience%20Accelerator/Presentation/Page%20Design.yml) is a data template)_
1. `0966b999-0d0e-4278-acc9-9da69d461fe6` -> `/sitecore/templates/Foundation/Experience Accelerator/Presentation/Base/_Base Page Design/Designing/PartialDesigns` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/Foundation/Experience%20Accelerator/Presentation/Base/_Base%20Page%20Design/Designing/PartialDesigns.yml) is a template field)_
1. `fd2059fd-6043-4dfe-8c04-e2437ce87634` -> `/sitecore/templates/Foundation/JSS Experience Accelerator/Presentation/Partial Design` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/Foundation/JSS%20Experience%20Accelerator/Presentation/Partial%20Design.yml) is a data template)_
1. `f1a1fe9e-a60c-4ddb-a3a0-bb5b29fe732e` -> `/sitecore/templates/System/Templates/Sections/Layout/Layout/__Renderings` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/System/Templates/Sections/Layout/Layout/__Renderings.yml) is a template field)_
1. `d2a6884c-04d5-4089-a64e-d27ca9d68d4c` -> `/sitecore/templates/Foundation/JSS Experience Accelerator/Placeholder Settings/Placeholder`  _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/Foundation/JSS%20Experience%20Accelerator/Placeholder%20Settings/Placeholder.yml) is a data template)_
1. `7256bdab-1fd2-49dd-b205-cb4873d2917c` -> `/sitecore/templates/System/Layout/Placeholder/Data/Placeholder Key` _([which](https://github.com/mahen1105/XmCloudTest/blob/main/src/items/templates/templates/System/Layout/Placeholder/Data/Placeholder%20Key.yml) is a template field)_

---

---

A bit of a teaser for what I hope can become trying to show off what I know about the content modeling data model that comes out of the box with Sitecore, and how it translates to the way content authoring screens look and the way web sites end up looking.

---

Within the "Sitecore User Group Convention North America 2024" web site backup:

The backup file called [Person.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/Basic%20Components/Person.yml) is an instance of the concept of a "[definition item](https://helix.sitecore.com/principles/sitecore-items/item-types.html#definition-items "https://helix.sitecore.com/principles/sitecore-items/item-types.html#definition-items")" -- more specifically of one called a "[data template](https://doc.sitecore.com/xp/en/developers/latest/sitecore-experience-manager/data-templates-1158191.html "https://doc.sitecore.com/xp/en/developers/latest/sitecore-experience-manager/data-templates-1158191.html")" -- within the underlying Sitecore CMS database.  Note its `cf5...` value of its `ID` property in line 2.  *(We know it's a* `*data template*` *because the value of its* `*Template*` *property is* `*ab86861a-6030-46c5-b394-e8f99e8b87db*` *-- that's a universal one used by all Sitecore databases worldwide.  I did a quixotic amount of reverse-engineering other people's Sitecore backups scattered around GitHub last year.)*

The backup file called [Eric Ramseur.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People/Organizer/Eric%20Ramseur.yml) is an instance of the concept of a "[content item](https://helix.sitecore.com/principles/sitecore-items/item-types.html#content-items "https://helix.sitecore.com/principles/sitecore-items/item-types.html#content-items")" within the underlying Sitecore CMS database.  Note that the `cf5...` value mentioned above is the value of its `Template` property in line 4.  This is how we know that within this particular Sitecore setup, `Eric Ramseur` is a `Person`.  Also, Eric's `ID` property is `f8f...` (line 2).

-   Interestingly, Eric's not inherently an "organizer" -- he's a "person" -- when it comes to what kinds of fields you need to fill out about him.  "Name," "JobRole," "Linkedin," etc.
-   However, his data file backup is *stored* within a *folder* named `Organizer`.  How did the backup process from the Sitecore database know that it'd be a good idea to create a folder called `Organizer` and store `Eric Ramseur.yml` within it?  Well, take a look at the value of Eric's `Parent` property on line 3:  it starts with `c6e...`.  It turns out that `c6e...` is the value of `ID` in a [Organizer.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People/Organizer.yml "https://github.com/sitecore/xm-cloud-introduction/blob/main/authoring/items/sugcon2024/sugcon/sugcon/sitena/na/data/people/organizer.yml") backup file (line 2).

The backup file called [Organizer.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People/Organizer.yml "https://github.com/sitecore/xm-cloud-introduction/blob/main/authoring/items/sugcon2024/sugcon/sugcon/sitena/na/data/people/organizer.yml") is also an instance of the concept of a "[definition item](https://helix.sitecore.com/principles/sitecore-items/item-types.html#definition-items "https://helix.sitecore.com/principles/sitecore-items/item-types.html#definition-items")" -- in this case, a custom one that the SugconNA2024 CMS administrators created -- within the underlying Sitecore CMS database.  *(We know it's custom-built because the value of its* `*Template*` *property is* `*bf4...*` *-- which is the* `*ID*` *of* [*Person Folder.yml*](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/Basic%20Components/Person%20Folder.yml "https://github.com/sitecore/xm-cloud-introduction/blob/main/authoring/items/sugcon2024/sugcon/sugcon/templates/sugcon2024/basic%20components/person%20folder.yml")*.)*

The backup file called [Person Folder.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/Basic%20Components/Person%20Folder.yml "https://github.com/sitecore/xm-cloud-introduction/blob/main/authoring/items/sugcon2024/sugcon/sugcon/templates/sugcon2024/basic%20components/person%20folder.yml") is an instance of the concept of a "[definition item](https://helix.sitecore.com/principles/sitecore-items/item-types.html#definition-items "https://helix.sitecore.com/principles/sitecore-items/item-types.html#definition-items")" -- more specifically, again, a "data template" -- within the underlying Sitecore CMS database -- which again we know because because the value of Person Folder.yml's `Template` property is `ab86861a-6030-46c5-b394-e8f99e8b87db`.

---

Eventually, we'll take a look at how people like Eric Ramseur -- and details like `https://www.linkedin.com/in/ericramseur/` -- make it onto <https://na.sugcon.events/Organizers>.

It's not just a matter of throwing `Eric Ramseur.yml` data straight into some HTML-producing code.  Nope!

First, there're a lot more in-Sitecore-CMS-admin-portal configurations ("definition items") to learn about, that take care of wrapping data `Eric Ramseur.yml` data up in easier-for-frontend-devs-to-work-with / friendlier-for-content-authors-to-work-with enhanced data formats.

Complexities like "[data templates](https://doc.sitecore.com/xp/en/developers/latest/sitecore-experience-manager/data-templates-1158191.html "https://doc.sitecore.com/xp/en/developers/latest/sitecore-experience-manager/data-templates-1158191.html")" whose fields include "Template Fields" (yet another "definition item" type) that hold "Multilist Query" (another "definition item" type) results.  And then even more "definition item" instances using "definition item" types like "Layout" & "Rendering" -- wrapping all of that!

(I think his name and LinkedIn URL end up inside an "Organizers" JSON list inside a "People Grid" JSON object inside a "Grid" JSON object inside a "Dynamic Placeholder" JSON list inside a "Layout" JSON object inside **a "Page" JSON object that is what you** ***actually*** **fetch over Sitecore CMS's API**, or something intense like that.)

Which seems like overkill for Eric, and possibly is.

But it's a very useful way of wrapping & enhancing data before it goes out over the CMS's API toward HTML-producing code if you want to let authors move things around on the page with "[dynamic placeholders](https://www.switchit.com/blog/sitecore/sitecore-9-dynamic-placeholders.aspx "https://www.switchit.com/blog/sitecore/sitecore-9-dynamic-placeholders.aspx")."  ([Official docs](https://doc.sitecore.com/xp/en/developers/hd/latest/sitecore-headless-development/sitecore-dynamic-placeholders-and-jss.html "https://doc.sitecore.com/xp/en/developers/hd/latest/sitecore-headless-development/sitecore-dynamic-placeholders-and-jss.html") and their [now-missing photos](https://www.google.com/search?q=site:https://doc.sitecore.com/xp/en/developers/hd/latest/sitecore-headless-development/sitecore-dynamic-placeholders-and-jss.html&sca_esv=1243c2b95c154fbe&udm=2&filter=0&biw=1912&bih=920&dpr=1 "https://www.google.com/search?q=site:https://doc.sitecore.com/xp/en/developers/hd/latest/sitecore-headless-development/sitecore-dynamic-placeholders-and-jss.html&sca_esv=1243c2b95c154fbe&udm=2&filter=0&biw=1912&bih=920&dpr=1").)  This is the magic that lets Sitecore CMS admins configure Sitecore so that *certain* content types can behave like Wix or Squarespace or Wordpress Block Editor / Gutenberg, where you as an author get to be like, "And now I'd like to drag one of these widgets here" -- but making it work even better than Squarespace, by making it easy for Sitecore CMS admins to configure Sitecore so that it's harder to mess up how Eric Ramseur shows up on the page (in his case, all an author gets to do is robotically data-enter his name, LinkedIn, etc.).

As complex as this is, I'm now convinced Sitecore is the best data model I've seen in a CMS.  It really accommodates both "marketing" data structures that're very page-builder-ey, *and* real-world "semantic" data structures (like calendar events, humans, etc.) smoothly once you've gotten it all data-modeled and set up correctly in the CMS admin portal.

---

And the way that both configuration settings ("definition items") and content ("content items") can be easily backed up to version control repositories -- or loaded in from backups -- promises the ability to easily migrate configuration *or* content between environments (dev/stg/prd) via Git-based automations (CI/CD pipelines)!  (Whereas that's kinda hard in, say, Wix or Wordpress -- or even Sanity CMS, where the content items can be a pain to migrate.)

Or, like, you could even spin up a short-lived 4th copy of the Sitecore CMS on your laptop and just noodle around in there for an afternoon dummy-checking a wild idea you just had without bothering anyone else.  But it could be fully spun up from the latest backup and be very production-like.  (Pretty sure Wix & Squarespace don't let you do *that*.  And I don't think it'd be fun to do in Wordpress.)

---

To be continued...

---

---

## Content items

* [Eric Ramseur.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People/Organizer/Eric%20Ramseur.yml) ID `f8f...`
    * _(type:  Person.yml (ID `cf5...`))_
* [Organizational Committee.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People%20Grids/Organizer/Organizational%20Commitee.yml) ID `42c...`
    * _(type:  People Grid.yml the "template" (ID `908...`))_
    * _(parent:  Organizer.yml `16b...`)_
    * _(Headline field value: `Organizational Commitee`)_
    * _(People field value: a list of a bunch of IDs including Eric's `f8f...`)_
    * Sibling similar content item backup files that also have the same `template` type and `parent` values:
        * [Sitecore Coordination Team.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People%20Grids/Organizer/Sitecore%20Coordination%20Team.yml) ID `0de...`
        * [Volunteers.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People%20Grids/Organizer/Volunteers.yml) `ID c95...`
* [Organizer.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People%20Grids/Organizer.yml) ID `16b...`
    * _(type:  People Grid Folder.yml `3e6...`)_
    * _(parent:  People Grids.yml `971...`)_
    * _(Sortorder field value:  `100`)_
        * _(sibling `Speaker.yml` sort order is `300`, FWIW -- no idea if that's important or not -- keeping in mind the live website is from 2023, not 2024)_
* [People Grids.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Data/People%20Grids.yml) ID `971...`
    * _(type:  People Grid Folder.yml `3e6...`)_
* [Organizers.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteNA/NA/Home/Organizers.yml) ID `1c0...`
    * _(type:  Generic Page.yml `f5d...`)_
    * _(Final Renderings field value:  an XML list of 3 "renderings" references, each with an "ID" pointing to the rendering-typed People Grid.yml's ID `533...`, all assigned to be injected into whichever presentational component has the path `/headless-main/sxa-generic-page/container-2`, and including a "Data Source" of:)_
        * first:  Organizational Committee.yml's `ID` of `42c...`
            * _(final path suffix `-1`)_
        * second:  Sitecore Coordination Team.yml's `ID` of `0de...`
            * _(final path suffix `-2`)_
        * third:  Volunteers.yml's `ID` of `c95...`
            * _(final path suffix `-3`)_
    * _(the HTML-generating code turns this into [https://na.sugcon.events/Organizers](https://na.sugcon.events/Organizers))_

## Definition items

* [People Grid Folder.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/List%20Components/People%20Grid%20Folder.yml), ID `3e6...`
    * _(type:  data template)_
    * _(Masters default field value:  a 2-item list pointing to the IDs of itself (`3e6...`) and of People Grid.yml the "template" (ID `908...`))_
* [People Grid.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/List%20Components/People%20Grid.yml) the "template," ID `908...`
    * _(type:  data template with all of the "Standard Template" & "SXA Per-Site Standard Values" base template (a universal Sitecore type) fields included, plus a [Headline.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/List%20Components/People%20Grid/Content/Headline.yml) field and a [People.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/List%20Components/People%20Grid/Content/People.yml) field)_
* [People Grid.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/mail/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/List%20Components/Rendering%20Parameters/People%20Grid.yml) the "rendering parameters," ID `b9e...`
    * _(type:  data template with all of the "SXA JSS Base Rendering Parameters" + "Dynamic Placeholder" + "SXA Per-Site Standard Values" + "Rendering ID" (4 universal Sitecore types) base templates' fields included)_
* [People Grid.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Renderings/Sugcon2024/List%20Components/People%20Grid.yml) the "rendering," ID `533...`
    * _(type:  SXA JSS JSON Rendering (a universal Sitecore type))_
    * _(parent:  List Components.yml `5df...`)_
    * _([Datasource Location](https://doc.sitecore.com/xp/en/developers/sxa/latest/sitecore-experience-accelerator/use-a-query-to-determine-the-data-source-context.html) field value:  a query looking for "Data Item"-typed content items whose type/template is People Grid Folder.yml (ID `3e6...`))_
    * _([Datasource Template](https://doc.sitecore.com/xp/en/developers/sxa/latest/sitecore-experience-accelerator/data-sources-1188183.html) field value:  a reference to the `Path` value of the template-typed People Grid.yml (ID `908...`))_
    * _(Parameters Template field value:  a reference to the "Rendering Parameters"-typed People Grid.yml (ID `b9e...`))_
* [List Components.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Renderings/Sugcon2024/List%20Components.yml) ID `5df...`
    * _(type:  renderings folder (a universal Sitecore type))_
* [Generic Page.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Templates/Sugcon2024/Page%20Templates/Generic%20Page.yml) ID `f5d...`
    * _(type:  data template)_






---

---

* [Generic Page.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteShared/Shared/Presentation/Page%20Designs/GenericPage.yml) the [Page Design](https://doc.sitecore.com/xmc/en/developers/xm-cloud/create-and-assign-a-page-design-in-the-content-editor.html) (ID `ae6`)
    * _(type:  SXA Presentation Page Design)_
    * _(under:  `SiteShared`)_
    * _(PartialDesigns field value:  a 3-item ordered list pointing to Header the partial design, Generic Page the partial design (ID `4a7`), and Footer the partial design)_
* [Generic Page.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteShared/Shared/Presentation/Partial%20Designs/Generic%20Page.yml) the Partial Design (ID `4a7`)
    * _(type:  SXA Presentation Page Design)_
    * _(under:  `SiteShared`)_
    * _(Renderings field value:  an XML list of 2 "renderings" references)_:
        * first: 
            * a "rendering," ID `e8a...`, called [Page Title](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/Renderings/Sugcon2024/Structure/PageTitle.yml) the "rendering" (ID `e8a...`)
                * _(type:  SXA JSS JSON Rendering (a universal Sitecore type))_
                * Component Query field value:  TODO
                * _([Datasource Location](https://doc.sitecore.com/xp/en/developers/sxa/latest/sitecore-experience-accelerator/use-a-query-to-determine-the-data-source-context.html) field value:  TODO)_
                * _([Datasource Template](https://doc.sitecore.com/xp/en/developers/sxa/latest/sitecore-experience-accelerator/data-sources-1188183.html) field value:  TODO)_
                * _(Parameters Template field value:  TODO)_
            * _(no "Data Source")_
            * assigned to be injected into _(or to become??)_ whichever presentational component has the path `/headless-main`, with a suffix of `-1` at the very end of its final path
        * second: 
            * a "rendering," ID `7a1...`, suspected to be SXA's / Sitecore's "Section" or "Component" (ID `7a1...`)
            * _(no "Data Source")_
            * assigned to be injected into _(or to become??)_ whichever presentational component has the path `/headless-main`, with a suffix of `-2` at the very end of its final path
* [Generic Page.yml](https://github.com/Sitecore/XM-Cloud-Introduction/blob/main/authoring/items/Sugcon2024/Sugcon/Sugcon/SiteShared/Shared/Presentation/Page%20Designs/GenericPage.yml) the Placeholder (ID `2f0`)
    * _(type:  SXA Presentation Placeholder Settings Placeholder)_
    * _(under:  `SiteShared`)_
    * _(Placeholder Key field value:  `sxa-generic-page`)_
        * _(Note:  this file seems to only exist to please validation tools that expect non-root+non-leaf/middle/major placeholders that show up by name to have explicit "placeholder settings" files, even if they are otherwise empty of configuration field values, such as perhaps an "Allowed Controls" field listing the allowed "rendering" UUIDs separated by `|`.  Here, it's more just a "yes, we meant to name this `s:ph` value `.../sxa-generic-page/...` elsewhere in the codebase; that's not a typo" definition item for the sake of clarity to humans and to validation tools.)_
