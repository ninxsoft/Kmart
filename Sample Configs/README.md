# Configuring KMART

`kmart` options are controlled by a configuration file, which can be stored in any of the following data formats:

| **Type** | [JSON](https://www.json.org) | [Property List](https://www.json.org) | [YAML](https://yaml.org) |
| :------: | :--------------------------: | :-----------------------------------: | :----------------------: |
| **Description** | Lightweight, easy for humans to read and write. | Subset of XML, commonly used for macOS user defaults. | Commonly used for configuration files. |
| **File Extension** | **.json** | **.plist** | **.yaml** |
| **Command** | `kmart --json /path/to/config.json` | `kmart --plist /path/to/config.plist` | `kmart --yaml /path/to/config.yaml` |

**Sample Configuration files** can be found in [this](/) directory.

## Options

*   [General](#general)
    *   [name](#name)
    *   [url](#url)
    *   [credentials](#credentials)
    *   [api_requests](#api_requests)
*   [Reports](#reports)
    *   Common
        *   [buildings_not_linked](#buildings_not_linked)
        *   [categories_not_linked](#categories_not_linked)
        *   [departments_not_linked](#departments_not_linked)
        *   [ebooks_no_scope](#ebooks_no_scope)
        *   [ibeacons_not_linked](#ibeacons_not_linked)
        *   [network_segments_not_linked](#network_segments_not_linked)
    *   Mac
        *   [mac_advanced_searches_no_criteria](#mac_advanced_searches_no_criteria)
        *   [mac_advanced_searches_invalid_criteria](#mac_advanced_searches_invalid_criteria)
        *   [mac_applications_no_scope](#mac_applications_no_scope)
        *   [mac_configuration_profiles_no_scope](#mac_configuration_profiles_no_scope)
        *   [mac_devices_duplicate_names](#mac_devices_duplicate_names)
        *   [mac_devices_duplicate_serial_numbers](#mac_devices_duplicate_serial_numbers)
        *   [mac_devices_last_check_in](#mac_devices_last_check_in)
        *   [mac_devices_last_inventory](#mac_devices_last_inventory")
        *   [mac_directory_bindings_not_linked](#mac_directory_bindings_not_linked)
        *   [mac_disk_encryptions_not_linked](#mac_disk_encryptions_not_linked)
        *   [mac_dock_items_not_linked](#mac_dock_items_not_linked)
        *   [mac_extension_attributes_not_linked](#mac_extension_attributes_not_linked)
        *   [mac_extension_attributes_disabled](#mac_extension_attributes_disabled)
        *   [mac_extension_attributes_linter_warnings](#mac_extension_attributes_linter_warnings)
        *   [mac_extension_attributes_linter_errors](#mac_extension_attributes_linter_errors)
        *   [mac_packages_not_linked](#mac_packages_not_linked)
        *   [mac_policies_no_scope](#mac_policies_no_scope)
        *   [mac_policies_disabled](#mac_policies_disabled)
        *   [mac_policies_no_payload](#mac_policies_no_payload)
        *   [mac_policies_jamf_remote](#mac_policies_jamf_remote)
        *   [mac_policies_last_executed](#mac_policies_last_executed)
        *   [mac_policies_failed_threshold](#mac_policies_failed_threshold)
        *   [mac_printers_not_linked](#mac_printers_not_linked)
        *   [mac_restricted_software_no_scope](#mac_restricted_software_no_scope)
        *   [mac_scripts_not_linked](#mac_scripts_not_linked)
        *   [mac_scripts_linter_warnings](#mac_scripts_linter_warnings)
        *   [mac_scripts_linter_errors](#mac_scripts_linter_errors)
        *   [mac_smart_groups_not_linked](#mac_smart_groups_not_linked)
        *   [mac_smart_groups_no_criteria](#mac_smart_groups_no_criteria)
        *   [mac_static_groups_not_linked](#mac_static_groups_not_linked)
        *   [mac_static_groups_empty](#mac_static_groups_empty)
    *   Mobile
        *   [mobile_advanced_searches_no_criteria](#mobile_advanced_searches_no_criteria)
        *   [mobile_advanced_searches_invalid_criteria](#mobile_advanced_searches_invalid_criteria)
        *   [mobile_applications_no_scope](#mobile_applications_no_scope)
        *   [mobile_configuration_profiles_no_scope](#mobile_configuration_profiles_no_scope)
        *   [mobile_devices_last_inventory](#mobile_devices_last_inventory)
        *   [mobile_extension_attributes_not_linked](#mobile_extension_attributes_not_linked)
        *   [mobile_smart_groups_not_linked](#mobile_smart_groups_not_linked)
        *   [mobile_smart_groups_no_criteria](#mobile_smart_groups_no_criteria)
        *   [mobile_static_groups_not_linked](#mobile_static_groups_not_linked)
        *   [mobile_static_groups_empty](#mobile_static_groups_empty)
*   [Report Options](#report-options)
    *   [mac_devices_last_check_in](#mac_devices_last_check_in)
    *   [mac_devices_last_inventory](#mac_devices_last_inventory)
    *   [mac_policies_last_executed](#mac_policies_last_executed)
    *   [mac_policies_failed_threshold](#mac_policies_failed_threshold)
    *   [mobile_devices_last_inventory](#mobile_devices_last_inventory)
*   [Output](#output)
    *   [json](#json)
    *   [plist](#plist)
    *   [yaml](#yaml)
    *   [markdown](#markdown)
    *   [html](#html)
*   [Email](#email)
    *   [enabled](#enabled)
    *   [hostname](#hostname)
    *   [port](#port)
    *   [username](#username)
    *   [password](#password)
    *   [sender_name](#sender_name)
    *   [sender_email](#sender_email)
    *   [recipients](#recipients)
    *   [cc](#cc)
    *   [bcc](#bcc)
    *   [subject](#subject)
    *   [attachments](#attachments)

## General

The following keys are found at the **root** of every configuration file.

#### name

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :no_good: | `KMART Report` |

Name of the report to generate.

#### url

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :white_check_mark: | - |

Jamf Pro URL.

#### credentials

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :white_check_mark: | - |

Base 64 encoded credentials for the Jamf Pro API user.

Use `printf "username:password" | iconv -t ISO-8859-1 | base64 -i -` to encode credentials.

#### api_requests

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `integer` | :no_good: | `4` |

Number of Jamf Pro API requests to run simultaneously.

**Note:** Use with caution.

[Back to Options](#options)

## Reports

The following keys can be found in the **reports** dictionary of a configuration file.

**Note:** If a key is omitted, the report type will be skipped.

#### buildings_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Buildings** not linked to any:
*   Mac Applications
*   Mac Configuration Profiles
*   Mac Devices
*   Mac Policies
*   Mac Restricted Software
*   Mobile Applications
*   Mobile Configuration Profiles
*   Mobile Devices
*   Network Segments

#### categories_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Categories** not linked to any:
*   Mac Applications
*   Mac Configuration Profiles
*   Mac Packages
*   Mac Policies
*   Mac Printers
*   Mac Scripts
*   Mobile Applications
*   Mobile Configuration Profiles

#### departments_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Departments** not linked to any:
*   Mac Applications
*   Mac Configuration Profiles
*   Mac Devices
*   Mac Policies
*   Mac Restricted Software
*   Mobile Applications
*   Mobile Configuration Profiles
*   Mobile Devices
*   Network Segments

#### ebooks_no_scope

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **eBooks** with no scope defined.

#### ibeacons_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **iBeacons** not linked to any:

*   Mac Configuration Profiles
*   Mac Policies
*   Mobile Configuration Profiles

#### network_segments_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Network Segments** not linked to any:

*   Buildings
*   Departments
*   eBooks
*   Mac Applications
*   Mac ConfigurationProfiles
*   Mac Policies
*   Mobile Applications
*   Mobile Configuration Profiles

#### mac_advanced_searches_no_criteria

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Advanced Searches** with no criteria defined.

#### mac_advanced_searches_invalid_criteria

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Advanced Searches** with invalid criteria (ie. incorrect Mac Device Group names).

#### mac_applications_no_scope

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Applications** with no scope defined.

#### mac_configuration_profiles_no_scope

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Configuration Profiles* with no scope defined.

#### mac_devices_duplicate_names

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Devices** that share a computer name.

#### mac_devices_duplicate_serial_numbers

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Devices** that share a serial number.

#### mac_devices_last_check_in

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Devices** that have not checked-in in `X` days.

#### mac_devices_last_inventory

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Devices** that have not performed an Inventory Update in `X` days.

#### mac_directory_bindings_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Directory Bindings** not linked to any Mac Policies.

#### mac_disk_encryptions_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Disk Encryptions** not linked to any Mac Policies.

#### mac_dock_items_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Dock Items** not linked to any Mac Policies.

#### mac_extension_attributes_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Extension Attributes** not linked to any:

*   Mac Advanced Searches
*   Mac Smart Groups

#### mac_extension_attributes_disabled

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Extension Attributes** that are disabled.

#### mac_extension_attributes_linter_errors

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Extension Attributes** with linter errors.

**Note:** Only shell scripts are currently supported.

**Note:** [shellcheck](https://github.com/koalaman/shellcheck) is required to perform linter checks.

#### mac_extension_attributes_linter_warnings

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Extension Attributes** with linter warnings.

**Note:** Only shell scripts are currently supported.

**Note:** [shellcheck](https://github.com/koalaman/shellcheck) is required to perform linter checks.

#### mac_packages_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Packages** not linked to any Mac Policies.

#### mac_policies_no_scope

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Policies** with no scope defined.

#### mac_policies_disabled

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Policies** that are disabled.

#### mac_policies_no_payload

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Policies** that have no payload defined.

#### mac_policies_jamf_remote

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Policies** that were created via Jamf Remote.

#### mac_policies_last_executed

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Policies** that have not executed in `X` days.

#### mac_policies_failed_threshold

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Policies** that have failed more than `X` percent.

#### mac_printers_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Printers** not linked to any Mac Policies.

#### mac_restricted_software_no_scope

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Restricted Software** with no scope defined.

#### mac_scripts_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Scripts** not linked to any Mac Policies.

#### mac_scripts_linter_errors

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Scripts** with linter errors.

**Note:** Only shell scripts are currently supported.

**Note:** [shellcheck](https://github.com/koalaman/shellcheck) is required to perform linter checks.

#### mac_scripts_linter_warnings

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Scripts** with linter warnings.

**Note:** Only shell scripts are currently supported.

**Note:** [shellcheck](https://github.com/koalaman/shellcheck) is required to perform linter checks.

#### mac_smart_groups_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Smart Groups** not linked to any:

*   Mac Advanced Searches
*   Mac Applications
*   Mac Configuration Profiles
*   Mac Policies
*   Mac Restricted Software

#### mac_smart_groups_no_criteria

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Smart Groups** with no criteria defined.

#### mac_static_groups_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Static Groups** not linked to any:

*   Mac Advanced Searches
*   Mac Applications
*   Mac Configuration Profiles
*   Mac Policies
*   Mac Restricted Software

#### mac_static_groups_empty

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mac Static Groups** with no device membership.

#### mobile_advanced_searches_no_criteria

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Advanced Searches** with no criteria defined.

#### mobile_advanced_searches_invalid_criteria

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Advanced Searches** with invalid criteria (ie. incorrect Mobile Device Group names).

#### mobile_applications_no_scope

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Applications** with no scope defined.

#### mobile_configuration_profiles_no_scope

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Configuration Profiles** with no scope defined.

#### mobile_devices_last_inventory

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Devices** that have not performed an Inventory Update in `X` days.

#### mobile_extension_attributes_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Extension Attributes** not linked to any:

*   Mobile Advanced Searches
*   Mobile Smart Groups

#### mobile_smart_groups_not_linked

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Smart Groups** not linked to any:

*   Mobile Advanced Searches
*   Mobile Applications
*   Mobile Configuration Profiles

#### mobile_smart_groups_no_criteria

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Smart Groups** with no criteria defined.

#### mobile_static_groups_not_linked"

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Static Groups** not linked to any:

*   Mobile Advanced Searches
*   Mobile Applications
*   Mobile Configuration Profiles

#### mobile_static_groups_empty

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Report all **Mobile Static Groups** with no device membership.

[Back to Options](#options)

## Report Options

The following keys can be found in the **report_options** dictionary of a configuration file.

#### mac_devices_last_check_in

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `integer` | :no_good: | `15` |

Number of days since a **Mac Device** has checked-in.

#### mac_devices_last_inventory

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `integer` | :no_good: | `15` |

Number of days since a **Mac Device** has run an Inventory Update.

#### mac_policies_last_executed

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `integer` | :no_good: | `15` |

Number of days since a **Mac Policy** has been executed.

#### mac_policies_failed_threshold

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `integer` | :no_good: | `15` |

Percentage of Mac Devices that have failed to complete a **Mac Policy**.

#### mobile_devices_last_inventory

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `integer` | :no_good: | `15` |

Number of days since a **Mobile Device** has run an Inventory Update.

[Back to Options](#options)

## Output

The following keys can be found in the **output** dictionary of a configuration file.

**Note:** If a key is omitted, the output type will be skipped.

#### json

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :no_good: | - |

Path to output a **JSON** report.

#### plist

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :no_good: | - |

Path to output a **Property List** report.

#### yaml

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :no_good: | - |

Path to output a **YAML** report.

#### markdown

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :no_good: | - |

Path to output a **Markdown** report.

#### html

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :no_good: | - |

Path to output a **HTML** report.

[Back to Options](#options)

## Email

The following keys can be found in the **email** dictionary of a configuration file.

#### enabled

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `boolean` | :no_good: | `false` |

Set to `false` to disable sending report via Email.

#### hostname

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :white_check_mark: | - |

SMTP server hostname.

#### port

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `integer` | :no_good: | `587` |

SMTP server port.

#### username

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :white_check_mark: | - |

SMTP account username.

#### password

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :white_check_mark: | - |

SMTP account password.

#### sender_name

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :white_check_mark: | - |

Display name of sender.

#### sender_email

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :white_check_mark: | - |

Display email of sender.

#### recipients

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `[string]` | :white_check_mark: | `[]` |

Array of recipient email strings.

#### cc

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `[string]` | :no_good: | `[]` |

Array of carbon copy email strings.

#### bcc

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `[string]` | :no_good: | `[]` |

Array of blind carbon copy email strings.

#### subject

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `string` | :white_check_mark: | - |

Email Subject line.

#### attachments

| **Type** | **Required** | **Default** |
| :------: | :----------: | :---------: |
| `dictionary` | :no_good: | - |

Key-pair values to add reports as email attachments:

```json
"attachments": {
  "json": "filename.json",
  "plist": "filename.plist",
  "yaml": "filename.yaml",
  "markdown": "filename.md",
  "html": "filename.html"
}
```

**Note:** The email will display the report as inline HTML, even if no attachment keys are specified.

[Back to Options](#options)
