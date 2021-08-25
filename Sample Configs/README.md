# Configuring KMART

`kmart` options are controlled by a configuration file, which can be stored in any of the following data formats:

* [JSON](https://www.json.org)
  * Lightweight, easy for humans to read and write
  * `kmart --json /path/to/config.json`
* [Property List](https://www.json.org)
  * Subset of XML, commonly used for macOS user defaults
  * `kmart --plist /path/to/config.plist`
* [YAML](https://yaml.org)
  * Commonly used for configuration files
  * `kmart -yaml /path/to/config.yaml`

**Sample Configuration files** can be found in [this](https://github.com/ninxsoft/Kmart/blob/main/Sample%20Configs/) directory.

## Options

* [General](#general)
  * [name](#name)
  * [url](#url)
  * [credentials](#credentials)
  * [api_requests](#api_requests)
  * [api_timeout](#api_timeout)
* [Reports](#reports)
  * Common
    * [buildings_not_linked](#buildings_not_linked)
    * [categories_not_linked](#categories_not_linked)
    * [departments_not_linked](#departments_not_linked)
    * [ebooks_no_scope](#ebooks_no_scope)
    * [ibeacons_not_linked](#ibeacons_not_linked)
    * [network_segments_not_linked](#network_segments_not_linked)
  * Mac
    * [mac_advanced_searches_no_criteria](#mac_advanced_searches_no_criteria)
    * [mac_advanced_searches_invalid_criteria](#mac_advanced_searches_invalid_criteria)
    * [mac_applications_no_scope](#mac_applications_no_scope)
    * [mac_configuration_profiles_no_scope](#mac_configuration_profiles_no_scope)
    * [mac_devices_duplicate_names](#mac_devices_duplicate_names)
    * [mac_devices_duplicate_serial_numbers](#mac_devices_duplicate_serial_numbers)
    * [mac_devices_last_check_in](#mac_devices_last_check_in)
    * [mac_devices_last_inventory](#mac_devices_last_inventory)
    * [mac_devices_unmanaged](#mac_devices_unmanaged)
    * [mac_directory_bindings_not_linked](#mac_directory_bindings_not_linked)
    * [mac_disk_encryptions_not_linked](#mac_disk_encryptions_not_linked)
    * [mac_dock_items_not_linked](#mac_dock_items_not_linked)
    * [mac_extension_attributes_not_linked](#mac_extension_attributes_not_linked)
    * [mac_extension_attributes_disabled](#mac_extension_attributes_disabled)
    * [mac_extension_attributes_linter_warnings](#mac_extension_attributes_linter_warnings)
    * [mac_extension_attributes_linter_errors](#mac_extension_attributes_linter_errors)
    * [mac_packages_not_linked](#mac_packages_not_linked)
    * [mac_policies_no_scope](#mac_policies_no_scope)
    * [mac_policies_disabled](#mac_policies_disabled)
    * [mac_policies_no_payload](#mac_policies_no_payload)
    * [mac_policies_jamf_remote](#mac_policies_jamf_remote)
    * [mac_policies_last_executed](#mac_policies_last_executed)
    * [mac_policies_failed_threshold](#mac_policies_failed_threshold)
    * [mac_printers_not_linked](#mac_printers_not_linked)
    * [mac_restricted_software_no_scope](#mac_restricted_software_no_scope)
    * [mac_scripts_not_linked](#mac_scripts_not_linked)
    * [mac_scripts_linter_warnings](#mac_scripts_linter_warnings)
    * [mac_scripts_linter_errors](#mac_scripts_linter_errors)
    * [mac_smart_groups_not_linked](#mac_smart_groups_not_linked)
    * [mac_smart_groups_no_criteria](#mac_smart_groups_no_criteria)
    * [mac_static_groups_not_linked](#mac_static_groups_not_linked)
    * [mac_static_groups_empty](#mac_static_groups_empty)
  * Mobile
    * [mobile_advanced_searches_no_criteria](#mobile_advanced_searches_no_criteria)
    * [mobile_advanced_searches_invalid_criteria](#mobile_advanced_searches_invalid_criteria)
    * [mobile_applications_no_scope](#mobile_applications_no_scope)
    * [mobile_configuration_profiles_no_scope](#mobile_configuration_profiles_no_scope)
    * [mobile_devices_last_inventory](#mobile_devices_last_inventory)
    * [mobile_devices_unmanaged](#mobile_devices_unmanaged)
    * [mobile_extension_attributes_not_linked](#mobile_extension_attributes_not_linked)
    * [mobile_smart_groups_not_linked](#mobile_smart_groups_not_linked)
    * [mobile_smart_groups_no_criteria](#mobile_smart_groups_no_criteria)
    * [mobile_static_groups_not_linked](#mobile_static_groups_not_linked)
    * [mobile_static_groups_empty](#mobile_static_groups_empty)
* [Report Options](#report-options)
  * [mac_devices_last_check_in](#mac_devices_last_check_in)
  * [mac_devices_last_inventory](#mac_devices_last_inventory)
  * [mac_policies_last_executed](#mac_policies_last_executed)
  * [mac_policies_failed_threshold](#mac_policies_failed_threshold)
  * [mobile_devices_last_inventory](#mobile_devices_last_inventory)
* [Output](#output)
  * [json](#json)
  * [plist](#plist)
  * [yaml](#yaml)
  * [markdown](#markdown)
  * [html](#html)
* [Email](#email)
  * [enabled](#enabled)
  * [hostname](#hostname)
  * [port](#port)
  * [username](#username)
  * [password](#password)
  * [sender_name](#sender_name)
  * [sender_email](#sender_email)
  * [recipients](#recipients)
  * [cc](#cc)
  * [bcc](#bcc)
  * [subject](#subject)
  * [attachments](#attachments)
* [Slack](#slack)
  * [enabled](#enabled)
  * [token](#token)
  * [channel](#port)
  * [text](#username)
  * [attachments](#attachments)

## General

The following keys are found at the **root** of every configuration file.

### name

* **Description:** Name of the report to be generated
* **Type:** `string`
* **Required:** `false`
* **Default:** `KMART Report`

### url

* **Description:** Jamf Pro URL
* **Type:** `string`
* **Required:** `true`

### credentials

* **Description:** Base 64 encoded credentials for the Jamf Pro API user
* **Type:** `string`
* **Required:** `true`

**Note**: Use `printf 'username:password' | iconv --to-code ISO-8859-1 | base64 --input -` to encode credentials.

### api_requests

* **Description:** Number of Jamf Pro API requests to run simultaneously
* **Type:** `integer`
* **Required:** `false`
* **Default:** `4`

**Note:** Use with caution.

### api_timeout

* **Description:** Time interval (in seconds) allowed for a Jamf Pro API request before timing out
* **Type:** `integer`
* **Required:** `false`
* **Default:** `10`

[Back to Options](#options)

## Reports

The following keys can be found in the **reports** dictionary of a configuration file.

**Note:** If a key is omitted, the report type will be skipped.

### buildings_not_linked

* **Description:** Report all **Buildings** not linked to any:
  * Mac Applications
  * Mac Configuration Profiles
  * Mac Devices
  * Mac Policies
  * Mac Restricted Software
  * Mobile Applications
  * Mobile Configuration Profiles
  * Mobile Devices
  * Network Segments
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### categories_not_linked

* **Description:** Report all **Categories** not linked to any:
  * Mac Applications
  * Mac Configuration Profiles
  * Mac Packages
  * Mac Policies
  * Mac Printers
  * Mac Scripts
  * Mobile Applications
  * Mobile Configuration Profiles
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### departments_not_linked

* **Description:** Report all **Departments** not linked to any:
  * Mac Applications
  * Mac Configuration Profiles
  * Mac Devices
  * Mac Policies
  * Mac Restricted Software
  * Mobile Applications
  * Mobile Configuration Profiles
  * Mobile Devices
  * Network Segments
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### ebooks_no_scope

* **Description:** Report all **eBooks** with no scope defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### ibeacons_not_linked

* **Description:** Report all **iBeacons** not linked to any:
  * Mac Configuration Profiles
  * Mac Policies
  * Mobile Configuration Profiles
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### network_segments_not_linked

* **Description:** Report all **Network Segments** not linked to any:
  * Buildings
  * Departments
  * eBooks
  * Mac Applications
  * Mac ConfigurationProfiles
  * Mac Policies
  * Mobile Applications
  * Mobile Configuration Profiles
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_advanced_searches_no_criteria

* **Description:** Report all **Mac Advanced Searches** with no criteria defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_advanced_searches_invalid_criteria

* **Description:** Report all **Mac Advanced Searches** with invalid criteria (ie. incorrect Mac Device Group names)
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_applications_no_scope

* **Description:** Report all **Mac Applications** with no scope defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_configuration_profiles_no_scope

* **Description:** Report all **Mac Configuration Profiles** with no scope defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_devices_duplicate_names

* **Description:** Report all **Mac Devices** that share a computer name
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_devices_duplicate_serial_numbers

* **Description:** Report all **Mac Devices** that share a serial number
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_devices_last_check_in

* **Description:** Report all managed **Mac Devices** that have not checked-in in `X` days
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_devices_last_inventory

* **Description:** Report all managed **Mac Devices** that have not performed an Inventory Update in `X` days
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_devices_unmanaged

* **Description:** Report all **Mac Devices** that are unmanaged
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_directory_bindings_not_linked

* **Description:** Report all **Mac Directory Bindings** not linked to any Mac Policies.
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_disk_encryptions_not_linked

* **Description:** Report all **Mac Disk Encryptions** not linked to any Mac Policies
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_dock_items_not_linked

* **Description:** Report all **Mac Dock Items** not linked to any Mac Policies
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_extension_attributes_not_linked

* **Description:** Report all **Mac Extension Attributes** not linked to any:
  * Mac Advanced Searches
  * Mac Smart Groups
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_extension_attributes_disabled

* **Description:** Report all **Mac Extension Attributes** that are disabled
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_extension_attributes_linter_errors

* **Description:** Report all **Mac Extension Attributes** with linter errors
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

**Note:** Only shell scripts are currently supported.

**Note:** [shellcheck](https://github.com/koalaman/shellcheck) is required to perform linter checks.

### mac_extension_attributes_linter_warnings

* **Description:** Report all **Mac Extension Attributes** with linter warnings
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

**Note:** Only shell scripts are currently supported.

**Note:** [shellcheck](https://github.com/koalaman/shellcheck) is required to perform linter checks.

### mac_packages_not_linked

* **Description:** Report all **Mac Packages** not linked to any Mac Policies
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_policies_no_scope

* **Description:** Report all **Mac Policies** with no scope defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_policies_disabled

* **Description:** Report all **Mac Policies** that are disabled
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_policies_no_payload

* **Description:** Report all **Mac Policies** that have no payload defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_policies_jamf_remote

* **Description:** Report all **Mac Policies** that were created via Jamf Remote
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_policies_last_executed

* **Description:** Report all **Mac Policies** that have not executed in `X` days
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_policies_failed_threshold

* **Description:** Report all **Mac Policies** that have failed more than `X` percent
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_printers_not_linked

* **Description:** Report all **Mac Printers** not linked to any Mac Policies
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_restricted_software_no_scope

* **Description:** Report all **Mac Restricted Software** with no scope defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_scripts_not_linked

* **Description:** Report all **Mac Scripts** not linked to any Mac Policies
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_scripts_linter_errors

* **Description:** Report all **Mac Scripts** with linter errors
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

**Note:** Only shell scripts are currently supported.

**Note:** [shellcheck](https://github.com/koalaman/shellcheck) is required to perform linter checks.

### mac_scripts_linter_warnings

* **Description:** Report all **Mac Scripts** with linter warnings
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

**Note:** Only shell scripts are currently supported.

**Note:** [shellcheck](https://github.com/koalaman/shellcheck) is required to perform linter checks.

### mac_smart_groups_not_linked

* **Description:** Report all **Mac Smart Groups** not linked to any:
  * Mac Advanced Searches
  * Mac Applications
  * Mac Configuration Profiles
  * Mac Policies
  * Mac Restricted Software
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_smart_groups_no_criteria

* **Description:** Report all **Mac Smart Groups** with no criteria defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_static_groups_not_linked

* **Description:** Report all **Mac Static Groups** not linked to any:
  * Mac Advanced Searches
  * Mac Applications
  * Mac Configuration Profiles
  * Mac Policies
  * Mac Restricted Software
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mac_static_groups_empty

* **Description:** Report all **Mac Static Groups** with no device membership
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_advanced_searches_no_criteria

* **Description:** Report all **Mobile Advanced Searches** with no criteria defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_advanced_searches_invalid_criteria

* **Description:** Report all **Mobile Advanced Searches** with invalid criteria (ie. incorrect Mobile Device Group names)
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_applications_no_scope

* **Description:** Report all **Mobile Applications** with no scope defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_configuration_profiles_no_scope

* **Description:** Report all **Mobile Configuration Profiles** with no scope defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_devices_last_inventory

* **Description:** Report all managed **Mobile Devices** that have not performed an Inventory Update in `X` days
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_devices_unmanaged

* **Description:** Report all **Mobile Devices** that are unmanaged
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_extension_attributes_not_linked

* **Description:** Report all **Mobile Extension Attributes** not linked to any:
  * Mobile Advanced Searches
  * Mobile Smart Groups
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_smart_groups_not_linked

* **Description:** Report all **Mobile Smart Groups** not linked to any:
  * Mobile Advanced Searches
  * Mobile Applications
  * Mobile Configuration Profiles
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_smart_groups_no_criteria

* **Description:** Report all **Mobile Smart Groups** with no criteria defined
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_static_groups_not_linked

* **Description:** Report all **Mobile Static Groups** not linked to any:
  * Mobile Advanced Searches
  * Mobile Applications
  * Mobile Configuration Profiles
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

### mobile_static_groups_empty

* **Description:** Report all **Mobile Static Groups** with no device membership
* **Type:** `boolean`
* **Required:** `false`
* **Default:** `false`

[Back to Options](#options)

## Report Options

The following keys can be found in the **report_options** dictionary of a configuration file.

### mac_devices_last_check_in

* **Description:** Number of days since a **Mac Device** has checked-in
* **Type:** `integer`
* **Required:** `false`
* **Default:** `15`

### mac_devices_last_inventory

* **Description:** Number of days since a **Mac Device** has run an Inventory Update
* **Type:** `integer`
* **Required:** `false`
* **Default:** `15`

### mac_policies_last_executed

* **Description:** Number of days since a **Mac Policy** has been executed
* **Type:** `integer`
* **Required:** `false`
* **Default:** `15`

### mac_policies_failed_threshold

* **Description:** Percentage of Mac Devices that have failed to complete a **Mac Policy**
* **Type:** `integer`
* **Required:** `false`
* **Default:** `15`

### mobile_devices_last_inventory

* **Description:** Number of days since a **Mobile Device** has run an Inventory Update
* **Type:** `integer`
* **Required:** `false`
* **Default:** `15`

[Back to Options](#options)

## Output

The following keys can be found in the **output** dictionary of a configuration file.

**Note:** If a key is omitted, the output type will be skipped.

### json

* **Description:** Path to output a **JSON** report
* **Type:** `string`
* **Required:** `false`

### plist

* **Description:** Path to output a **Property List** report
* **Type:** `string`
* **Required:** `false`

### yaml

* **Description:** Path to output a **YAML** report
* **Type:** `string`
* **Required:** `false`

### markdown

* **Description:** Path to output a **Markdown** report
* **Type:** `string`
* **Required:** `false`

### html

* **Description:** Path to output a **HTML** report
* **Type:** `string`
* **Required:** `false`

[Back to Options](#options)

## Email

The following keys can be found in the **email** dictionary of a configuration file.

### enabled

* **Description:** Set to `false` to disable sending reports via Email
* **Type:** `boolean`
* **Required:** `false`
* **Default:**: `false`

### hostname

* **Description:** SMTP server hostname
* **Type:** `string`
* **Required:** `true`

### port

* **Description:** SMTP server port
* **Type:** `integer`
* **Required:** `false`
* **Default:**: `587`

### username

* **Description:** SMTP account username
* **Type:** `string`
* **Required:** `true`

### password

* **Description:** SMTP account password
* **Type:** `string`
* **Required:** `true`

### sender_name

* **Description:** Display name of sender
* **Type:** `string`
* **Required:** `true`

### sender_email

* **Description:** Display email of sender
* **Type:** `string`
* **Required:** `true`

### recipients

* **Description:** Array of recipient email strings.
* **Type:** `[string]`
* **Required:** `true`

### cc

* **Description:** Array of carbon copy email strings.
* **Type:** `[string]`
* **Required:** `false`

### bcc

* **Description:** Array of blind carbon copy email strings
* **Type:** `[string]`
* **Required:** `false`

### subject

* **Description:** Email Subject line
* **Type:** `string`
* **Required:** `true`

### attachments

* **Description:** Key-pair values to add reports as email attachments. Possible values include:
  * `json`: `filename.json`
  * `plist`: `filename.plist`
  * `yaml`: `filename.yaml`
  * `markdown`: `filename.md`
  * `html`: `filename.html`
* **Type:** `dictionary`
* **Required:** `false`

**Note:** The email will display the report as inline HTML, even if no attachment keys are specified.

[Back to Options](#options)

## Slack

The following keys can be found in the **slack** dictionary of a configuration file.

### enabled

* **Description:** Set to `false` to disable sending reports via Slack
* **Type:** `boolean`
* **Required:** `false`
* **Default:**: `false`

### token

* **Description:** `xoxb-` Bot Token used for authentication to send messages and upload reports via Slack
* **Type:** `string`
* **Required:** `true`

**Note:** Read [Basic app setup](https://api.slack.com/authentication/basics) to create a Slack app with a Bot token.

**Note:** The Bot token will require the `chat:write` and `files:write` [permission scopes](https://api.slack.com/scopes).

### channel

* **Description:** Name or ID of the channel used to upload reports via Slack
* **Type:** `string`
* **Required:** `true`

### text

* **Description:** Markdown and Emoji supported text used to send messages via Slack
* **Type:** `string`
* **Required:** `false`

### attachments

* **Description:** Array of file upload strings. Possible values include:
  * `json`
  * `plist`
  * `yaml`
  * `markdown`
  * `html`
* **Type:** `[string]`
* **Required:** `false`

**Note:** At least one attachment is required.

[Back to Options](#options)
