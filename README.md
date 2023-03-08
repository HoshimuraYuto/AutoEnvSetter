# AutoEnvSetter

- [English](README.md)
- [日本語](docs/README_ja.md)

AutoEnvSetter is a tool that allows you to easily build a Javascript/Typescript (+react, etc.) development environment.

## Usage

To use AutoEnvSetter, you can run the script locally by following these steps:

1. Download zip file [here](https://github.com/HoshimuraYuto/AutoEnvSetter/archive/refs/heads/main.zip).
2. Unzip the file.
3. Run `bin/install.sh` from the unzipped directory.

```sh
sh bin/install.sh
```

### Arguments

You can pass in the following arguments:

- `--package_manager=[package manager]`: Specify the package manager you want to use (e.g. --package_manager=yarn). The default value is `pnpm`.
- `--language=[language]`: Specify the language you want to use (e.g. --language=javascript). The default value is `typescript`.
- `--framework=[framework]`: Specify the framework you want to use (e.g. --framework=react). The default value is `none`.
- `--formatter=[formatter]`: Specify the code formatter you want to use (e.g. --formatter=prettier). The default value is `prettier`.
- `--linter=[linter]`: Specify the linter you want to use (e.g. --linter=eslint). The default value is `eslint`.
- `--bundler=[bundler]`: Specify the module bundler you want to use (e.g. --bundler=webpack). The default value is `webpack`.

The linter variable can accept multiple values separated by a comma, such as `--linter=eslint,stylelint`. If multiple linters are specified, the script will configure each linter accordingly.

### Supported options

AutoEnvSetter currently supports the following options:

- Package manager: `npm`, `yarn`, `pnpm`
- Programming Lnguage: `javascript`, `typescript`
- Framework: `none`, `react`
- Linter: `none`, `eslint`, `stylelint`
- Formatter: `none`, `prettier`
- Bundler: `none`, `webpack`

### Example Usage

#### pnpm+typescript+eslint+prettier+webpack

```sh
sh bin/install.sh
```

#### pnpm+typescript+react+eslint+prettier+webpack

```sh
sh bin/install.sh --framework=react
```

#### pnpm+typescript+react+eslint+stylelint+prettier+webpack

```sh
sh bin/install.sh --framework=react --linter=eslint,stylelint
```

## Compatibility

AutoEnvSetter is compatible with macOS and Linux operating systems. Compatibility with Windows has not been confirmed at this time.

## Requirements and Dependencies

AutoEnvSetter requires the following:

- Bash
- Curl

## Future Development

We plan to continue developing AutoEnvSetter to add new features and support for more languages, frameworks, and tools. Some features we plan to add include:

- [ ] Support for additional languages and frameworks
- [ ] Integration with testing frameworks
- [ ] Automatic deployment scripts
- [ ] Works like a brew installer (without downloading)

Stay tuned for updates!

## Contributing

We welcome contributions to AutoEnvSetter! To contribute, please follow these steps:

1. Fork the project on GitHub.
2. Make your changes and commit them with clear commit messages.
3. Push your changes to your forked repository.
4. Submit a pull request.
5. We will review your changes and merge them if they are a good fit for the project.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

- [Github](https://github.com/HoshimuraYuto)
- [Twitter](https://twitter.com/HoshimuraYuto)
- [Blog](https://sukiburo.jp/)
