# KMART - Kick-Ass Mac Admin Reporting Tool

A command-line utility generating kick-ass Jamf Pro reports:

![KMART](Readme%20Resources/KMART.png)

## Features

*   [x] Reporting on the following Jamf Pro objects:
    *   :computer: Mac
        *   Advanced Searches
        *   Applications
        *   Configuration Profiles
        *   Devices
        *   Directory Bindings
        *   Disk Encryptions
        *   Dock Items
        *   Extension Attributes
        *   Packages
        *   Policies
        *   Printers
        *   Restricted Software
        *   Scripts
        *   Smart Groups
        *   Static Groups
    *   :iphone: Mobile
        *   Advanced Searches
        *   Applications
        *   Configuration Profiles
        *   Devices
        *   Extension Attributes
        *   Smart Groups
        *   Static Groups
    *   :office: Buildings
    *   :open_file_folder: Categories
    *   :department_store: Departments
    *   :books: eBooks
    *   :b: iBeacons
    *   :signal_strength: Network Segments
*   [x] :ledger: Customise reporting options via **JSON**, **Property List** or **YAML** configuration files
*   [x] :clipboard: Output reports as **JSON**, **Property List**, **YAML**, **Markdown** or **HTML** files
*   [x] :outbox_tray: Email reports to a list of recipients

## Usage

```bash
OVERVIEW: Kick-Ass Mac Admin Reporting Tool

Generate kick-ass Jamf Pro reports.

USAGE: kmart [--json <json>] [--plist <plist>] [--yaml <yaml>] [--version]

OPTIONS:
  -j, --json <json>       JSON configuration file.
  -p, --plist <plist>     Property List configuration file.
  -y, --yaml <yaml>       YAML configuration file.
  -v, --version           Display the version of kmart.
  -h, --help              Show help information.
```

## Configuration

See [Sample Configs](Sample%20Configs) for all configuration options.

**Note**: Use the following command to encode your credentials in the configuration file:

`printf 'username:password' | iconv --to-code ISO-8859-1 | base64 --input -`

## Privileges

`kmart` requires the following **user privileges** in order to report correctly.

**Recommendations:**
*   Create a separate Jamf Pro User Account
*   Do not just add these permissions to an existing account
*   If you are not reporting on everything, only enable the privileges that are required

| **Privilege** | **Create** | **Read** | **Update** | **Delete** |
| :------------ | :--------: | :------: | :--------: | :--------: |
| Advanced Computer Searches | - | :white_check_mark: | - | - |
| Advanced Mobile Device | - | :white_check_mark: | - | - |
| Buildings | - | :white_check_mark: | - | - |
| Categories | - | :white_check_mark: | - | - |
| Computer Extension Attributes | - | :white_check_mark: | - | - |
| Computers | - | :white_check_mark: | - | - |
| Departments | - | :white_check_mark: | - | - |
| Directory Bindings | - | :white_check_mark: | - | - |
| Disk Encryption Configurations | - | :white_check_mark: | - | - |
| Dock Items | - | :white_check_mark: | - | - |
| eBooks | - | :white_check_mark: | - | - |
| iBeacons | - | :white_check_mark: | - | - |
| Mac App Store Apps | - | :white_check_mark: | - | - |
| macOS Configuration Profiles | - | :white_check_mark: | - | - |
| Mobile Device Apps | - | :white_check_mark: | - | - |
| Mobile Device Configuration Profiles | - | :white_check_mark: | - | - |
| Mobile Device Extension Attributes | - | :white_check_mark: | - | - |
| Mobile Devices | - | :white_check_mark: | - | - |
| Network Segments | - | :white_check_mark: | - | - |
| Packages | - | :white_check_mark: | - | - |
| Policies | - | :white_check_mark: | - | - |
| Printers | - | :white_check_mark: | - | - |
| Restricted Software Records | - | :white_check_mark: | - | - |
| Scripts | - | :white_check_mark: | - | - |
| Smart Computer Groups | - | :white_check_mark: | - | - |
| Smart Mobile Device Groups | - | :white_check_mark: | - | - |
| Static Computer Groups | - | :white_check_mark: | - | - |
| Static Mobile Device Groups | - | :white_check_mark: | - | - |

## Build Requirements

*   Swift **5.3**.
*   Runs on macOS Catalina **10.15** and later.

## Download

Grab the latest version of KMART from the [releases page](https://github.com/ninxsoft/KMART/releases).

## Credits / Thank You

*   Project created and maintained by Nindi Gill ([ninxsoft](https://github.com/ninxsoft)).
*   Apple ([apple](https://github.com/apple)) for [Swift Argument Parser](https://github.com/apple/swift-argument-parser), used to perform command-line argument and flag operations.
*   JP Simard ([jpsim](https://github.com/jpsim)) for [Yams](https://github.com/jpsim/Yams), used to export YAML.
*   John Sundell ([JohnSundell](https://github.com/JohnSundell)) for [Ink](https://github.com/JohnSundell/Ink), used to generate HTML from Markdown.
*   Kitura ([Kitura](https://github.com/Kitura)) for [Swift-SMTP](https://github.com/Kitura/Swift-SMTP), used to send emails.
*   Sindre Sorhus ([sindresorhus](https://github.com/sindresorhus)) for [github-markdown-css](https://github.com/sindresorhus/github-markdown-css), used to make the HTML output prettier.



## Version History

*   1.1
    *   Report on one-off Mac Policies that were created via Jamf Remote (`mac_policies_jamf_remote`)
    *   Less ambiguous descriptions for Markdown / HTML output
    *   Better escaping of ASCII characters for Markdown / HTML output
    *   Fixed false-positive linter errors for Mac Extension Attributes with carriage returns (`\r`)
    *   Fixed Mac Directory Bindings reporting as Mac Disk Encryptions
    *   Fixed emailing report only if enabled is set to `true`

*   1.0
    *   Initial release

## License

>    Copyright © 2021 Nindi Gill
>
>    Permission is hereby granted, free of charge, to any person obtaining a copy
>    of this software and associated documentation files (the "Software"), to deal
>    in the Software without restriction, including without limitation the rights
>    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>    copies of the Software, and to permit persons to whom the Software is
>    furnished to do so, subject to the following conditions:
>
>    The above copyright notice and this permission notice shall be included in all
>    copies or substantial portions of the Software.
>
>    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>    SOFTWARE.
