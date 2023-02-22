---
ArtifactType: nupkg, executable, azure-web-app, azure-cloud-service, etc. More requirements for artifact type standardization may come later.
Documentation: URL
Language: typescript, csharp, java, js, python, golang, powershell, markdown, etc. More requirements for language names standardization may come later.
Platform: windows, node, linux, ubuntu16, azure-function, etc. More requirements for platform standardization may come later.
Stackoverflow: URL
Tags: comma,separated,list,of,tags
---

# AzureMigrate-Swaggers

This project houses cadl source files for generating swagger files for Azure Migrate discovery and assessment service APIs.

https://microsoft.github.io/cadl/

Why CADL

CADL is designed to be easy to read and write, even for developers who are not experts in API design. It uses a simple and expressive syntax that allows developers to describe the shape of an API and the relationships between its various elements.

CADL is highly extensible, which means that it can be extended with custom types, annotations, and other elements that are specific to a particular domain or application. This allows developers to tailor the language to their specific needs and use it to describe a wide variety of APIs.

https://devblogs.microsoft.com/azure-sdk/the-value-of-cadl-in-designing-apis/

https://github.com/APIPatterns/cadl-demo

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Here are some pre-requisites you'd need to install on your machine to use this project -

https://microsoft.github.io/cadl/introduction/installation.html  


### Installing

A step by step series of examples that tell you how to get a development environment running

1. Install the cadl dependencies

    ```
    cadl install
    ```

2. Compile Cadl code

    ```
    cadl compile discovery
    
    or 
    
    cadl compile assessment
    ```

## Running the tests

Explain how to run the tests for this project that are relevant to users. You can also link to the testing portion of [CONTRIBUTING.md](CONTRIBUTING.md) for tests relevant to contributors.

### End-to-end tests

Explain what these tests test and why

```
Give an example
```

### Unit tests

Explain what these test and why

```
Give examples
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

Documenting some of the main tools used to build this project, manage dependencies, etc will help users get more information if they are trying to understand or having difficulties getting the project up and running.

* Link to some dependency manager
* Link to some framework or build tool
* Link to some compiler, linting tool, bundler, etc

## Contributing

Please read our [CONTRIBUTING.md](CONTRIBUTING.md) which outlines all of our policies, procedures, and requirements for contributing to this project.

## Versioning and changelog

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](link-to-tags-or-other-release-location).

It is a good practice to keep `CHANGELOG.md` file in repository that can be updated as part of a pull request.

## Authors

List main authors of this project with a couple of words about their contribution.

Also insert a link to the `owners.txt` file if it exists as well as any other dashboard or other resources that lists all contributors to the project.

## License

This project is licensed under the < INSERT LICENSE NAME > - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
