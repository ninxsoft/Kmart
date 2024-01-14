# KMART - Kick-Ass Mac Admin Reporting Tool

A command-line utility that generates kick-ass Jamf Pro reports:

![Email](Readme%20Resources/Email.png)

Optionally sent via Slack:

![Slack](Readme%20Resources/Slack.png)

<!-- markdownlint-disable no-inline-html -->

<a href="https://www.buymeacoffee.com/ninxsoft"><img width="214" height="60" src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy me a coffee"></a>

<!-- markdownlint-enable no-inline-html -->

## Features

- [x] Reporting on the following Jamf Pro objects:
  - :computer: Mac
    - Advanced Searches
    - Applications
    - Configuration Profiles
    - Devices
    - Directory Bindings
    - Disk Encryptions
    - Dock Items
    - Extension Attributes
    - Packages
    - Patch Management Software Titles
    - Patch Policies
    - Policies
    - Printers
    - Restricted Software
    - Scripts
    - Smart Groups
    - Static Groups
  - :iphone: Mobile
    - Advanced Searches
    - Applications
    - Configuration Profiles
    - Devices
    - Extension Attributes
    - Smart Groups
    - Static Groups
  - :office: Buildings
  - :open_file_folder: Categories
  - :department_store: Departments
  - :books: eBooks
  - :b: iBeacons
  - :signal_strength: Network Segments
- [x] :ledger: Customise reporting options via **JSON**, **Property List** or **YAML** configuration files
- [x] :clipboard: Output reports as **JSON**, **Property List**, **YAML**, **Markdown** or **HTML** files
- [x] :file_cabinet: Send reports via Slack

## Usage

```bash
OVERVIEW: Kick-Ass Mac Admin Reporting Tool

Generate kick-ass Jamf Pro reports.

USAGE: kmart [--json <json>] [--plist <plist>] [--yaml <yaml>]

OPTIONS:
  -j, --json <json>       JSON configuration file.
  -p, --plist <plist>     Property List configuration file.
  -y, --yaml <yaml>       YAML configuration file.
  --version               Show the version.
  -h, --help              Show help information.
```

## Configuration

- See [Sample Configs](Sample%20Configs) for all configuration options.

  **Note**: Use the following command to encode your credentials in the configuration file:

  `printf 'username:password' | iconv --to-code ISO-8859-1 | base64`

- For Slack integration, read [Basic app setup](https://api.slack.com/authentication/basics) to create a Slack app with a Bot token.

  **Note:** The Bot token will require the `chat:write` and `files:write` [permission scopes](https://api.slack.com/scopes).

## Privileges

**Kmart** requires the following **user privileges** in order to report correctly.

**Recommendations:**

- Create a separate Jamf Pro User Account
- Do not just add these permissions to an existing account
- If you are not reporting on everything, only enable the privileges that are required

| **Privilege**                        | **Create** |      **Read**      | **Update** | **Delete** |
| :----------------------------------- | :--------: | :----------------: | :--------: | :--------: |
| Advanced Computer Searches           |     -      | :white_check_mark: |     -      |     -      |
| Advanced Mobile Device               |     -      | :white_check_mark: |     -      |     -      |
| Buildings                            |     -      | :white_check_mark: |     -      |     -      |
| Categories                           |     -      | :white_check_mark: |     -      |     -      |
| Computer Extension Attributes        |     -      | :white_check_mark: |     -      |     -      |
| Computers                            |     -      | :white_check_mark: |     -      |     -      |
| Departments                          |     -      | :white_check_mark: |     -      |     -      |
| Directory Bindings                   |     -      | :white_check_mark: |     -      |     -      |
| Disk Encryption Configurations       |     -      | :white_check_mark: |     -      |     -      |
| Dock Items                           |     -      | :white_check_mark: |     -      |     -      |
| eBooks                               |     -      | :white_check_mark: |     -      |     -      |
| iBeacons                             |     -      | :white_check_mark: |     -      |     -      |
| Mac App Store Apps                   |     -      | :white_check_mark: |     -      |     -      |
| macOS Configuration Profiles         |     -      | :white_check_mark: |     -      |     -      |
| Mobile Device Apps                   |     -      | :white_check_mark: |     -      |     -      |
| Mobile Device Configuration Profiles |     -      | :white_check_mark: |     -      |     -      |
| Mobile Device Extension Attributes   |     -      | :white_check_mark: |     -      |     -      |
| Mobile Devices                       |     -      | :white_check_mark: |     -      |     -      |
| Network Segments                     |     -      | :white_check_mark: |     -      |     -      |
| Packages                             |     -      | :white_check_mark: |     -      |     -      |
| Patch Management Software Titles     |     -      | :white_check_mark: |     -      |     -      |
| Patch Policies                       |     -      | :white_check_mark: |     -      |     -      |
| Policies                             |     -      | :white_check_mark: |     -      |     -      |
| Printers                             |     -      | :white_check_mark: |     -      |     -      |
| Restricted Software Records          |     -      | :white_check_mark: |     -      |     -      |
| Scripts                              |     -      | :white_check_mark: |     -      |     -      |
| Smart Computer Groups                |     -      | :white_check_mark: |     -      |     -      |
| Smart Mobile Device Groups           |     -      | :white_check_mark: |     -      |     -      |
| Static Computer Groups               |     -      | :white_check_mark: |     -      |     -      |
| Static Mobile Device Groups          |     -      | :white_check_mark: |     -      |     -      |

## Build Requirements

- Swift **5.5**.
- Runs on macOS Monterey **12** and later.

## Download

- Grab the latest version of KMART from the [releases page](https://github.com/ninxsoft/KMART/releases).
- **Note:** Versions **1.3** and later require **macOS Monterey** or later.
  - If you need to run **KMART** on an older operating system, you can still use version **1.2**.

## Credits / Thank You

- Project created and maintained by Nindi Gill ([ninxsoft](https://github.com/ninxsoft)).
- Apple ([apple](https://github.com/apple)) for [Swift Argument Parser](https://github.com/apple/swift-argument-parser), used to perform command-line argument and flag operations.
- JP Simard ([jpsim](https://github.com/jpsim)) for [Yams](https://github.com/jpsim/Yams), used to export YAML.
- John Sundell ([JohnSundell](https://github.com/JohnSundell)) for [Ink](https://github.com/JohnSundell/Ink), used to generate HTML from Markdown.
- David Mohundro ([drmohundro](https://github.com/drmohundro)) for [SWXMLHash](https://github.com/drmohundro/SWXMLHash), used to decode XML.
- Sindre Sorhus ([sindresorhus](https://github.com/sindresorhus)) for [github-markdown-css](https://github.com/sindresorhus/github-markdown-css), used to make the HTML output prettier.

## License

> Copyright © 2024 Nindi Gill
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.
