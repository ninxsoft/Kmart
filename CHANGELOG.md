# Changelog

## [1.3.2](https://github.com/ninxsoft/Kmart/releases/tag/v1.3.2) - 2022-12-25

- Fixed an issue where `mac_policies_no_payload` was not reporting correctly (thanks [monodata](https://github.com/monodata))
- URL slugs have been updated to match recent Jamf Pro changes (thanks [thomasrmartin](https://github.com/thomasrmartin))

## [1.3.1](https://github.com/ninxsoft/Kmart/releases/tag/v1.3.1) - 2022-08-07

- Nested Smart Groups are now also detected when generating reports

## [1.3](https://github.com/ninxsoft/Kmart/releases/tag/v1.3) - 2022-05-29

- Added support for linting **Python** scripts via [flake8](https://flake8.pycqa.org)
- Added support for reporting on **Patch Management Software Titles**:
  - New report types: `mac_patch_policies_no_scope` and `mac_patch_policies_disabled`
  - Existing reports now factor in Patch Management Software Titles and Patch Policies
- Progress output is now dynamic, updating in-place
- Basic Authentication has been replaced with [Bearer Token Authentication](https://developer.jamf.com/jamf-pro/docs/classic-api-authentication-changes)
- Option to send reports via **Email** has been removed
- Fixed the missing **Serial Number** column header for **Unmanaged Mac/Mobile Device** reports in Markdown and HTML
- General cosmetic bugfixes

**Note:** Kmart now uses [Swift concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html) (async await), which significantly reduces the amount and complexity of HTTP code. Concurrency requires macOS Monterey 12, therefore support for macOS Catalina 10.15 and macOS Big Sur 11 has been dropped.

## [1.2](https://github.com/ninxsoft/Kmart/releases/tag/v1.2) - 2021-08-25

- Added support for sending reports via Slack
  - Read [Basic app setup](https://api.slack.com/authentication/basics) to create a Slack app with a Bot token
  - **Note:** The Bot token will require the `chat:write` and `files:write` [permission scopes](https://api.slack.com/scopes)
  - See [Sample Configs](Sample%20Configs#slack) for more information
- Added `mac_devices_unmanaged` and `mobile_devices_unmanaged` report types
  - Mac and Mobile device reports now exclude unmanaged devices
- Added support for custom `api_timeout` value (default: `10`)
- Mac Packages now also display Categories in Markdown / HTML reports
- Improved file handling for Mac Extension Attributes and Mac Scripts over 64KB
- Fixed escaping of `\` in JSON reports
- Fixed escaping of `_` in Markdown / HTML reports
- Reduced verbosity of output messaging (reads much nicer)

## [1.1](https://github.com/ninxsoft/Kmart/releases/tag/v1.1) - 2021-04-12

- Report on one-off Mac Policies that were created via Jamf Remote (`mac_policies_jamf_remote`)
- Less ambiguous descriptions for Markdown / HTML output
- Better escaping of ASCII characters for Markdown / HTML output
- Fixed false-positive linter errors for Mac Extension Attributes with carriage returns (`\r`)
- Fixed Mac Directory Bindings reporting as Mac Disk Encryptions
- Fixed emailing report only if enabled is set to `true`

## [1.0](https://github.com/ninxsoft/Kmart/releases/tag/v1.0) - 2021-04-04

- Initial release
