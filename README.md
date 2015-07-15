# Azure REST API Specifications

This repository is the canonical source for REST API specifications for Microsoft Azure.

## Directory Structure

The structure of the directory should strictly follow these rules:
- The top level folder must be the resource provider name
- The second level must be the API versions for the resource provider
- The third level must be the format of the specification
- The forth level must be the specifications

The structure should appear like so:
```bash
.
├── Microsoft.Compute
│   ├── 2014-01-01
│   │   └── swagger
│   │       ├── service.json
│   │       └── service.yaml
│   ├── 2014-12-31
│   │   └── swagger
│   └── README.md
├── Microsoft.Network
├── Microsoft.Resources
├── Microsoft.Storage
├── Microsoft.Web
└── README.md
```

At this point, the specifications are expected to be in swagger format.

## Generating Code from Specifications

If you are interested in generating code from these specifications, please check out [AutoRest](https://github.com/azure/autorest). There you will find the code generator as well as instructions on how to use it.

## How to Contribute

Please contribute to services you know and love. The curation of these specifications will ensure that we have great documentation and even better client library support for our Azure Services. If you have any questions, please reach out to the autoresteng dl.

### Submitting changes

Please send a [GitHub Pull Request to Azure REST API Specs](https://github.com/azure/azure-rest-api-specs/pull/new/master) with a clear list of what you've done (read more about [pull requests](http://help.github.com/pull-requests/)). When you send a pull request, we will love you forever if you include additions to the documentation for your given service. We can always use more documentation and beautiful markdown. Please follow make sure all of your commits are atomic (one feature per commit).

Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should look like this:

    $ git commit -m "A brief summary of the commit
    >
    > A paragraph describing what changed and its impact."
