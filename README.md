I have not actually yet written this codebase.

It's gonna take me forever to reverse-engineer other people's codebases configuring XM Cloud and guess how to write it as tiny as possible, since Sitecore for some inexplicable reason refuses to do a developer instance program like Sanity CMS, Salesforce, AWS, etc. do.

(Do they not _want_ people to have any confidence in XM Cloud before migrating to it?  Dudes.  Let developers Hello World properly.)

## Misc

`./.config/dotnet-tools.json` is how your computer knows to install the Sitecore CLI for you on whatever computer you end up downloading this repo onto.

`./sitecore.json` is how your computer knows which Sitecore CLI plugins to install and tells the Sitecore CLI a little bit about your project file structure choices.

`./.sitecore/schemas/` has 3 `*.schema.json` files in it that ... honestly, I haven't had a chance to look into what they do, but they came with `sitecore init` and I also see them in [an XM Cloud example](https://github.com/Sitecore/Sitecore.Demo.XmCloud.PlaySummit/tree/main/.sitecore/schemas).

It looks like `C:\license\license.xml` is a [standard place on a host system](https://github.com/Sitecore/Sitecore.Demo.XmCloud.PlaySummit/blob/main/docs/prerequisites.md) to keep a copy of a Sitecore 10 license file.