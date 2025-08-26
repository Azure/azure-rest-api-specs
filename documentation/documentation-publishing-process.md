# Azure REST API Specs: Documentation Publishing Process

This document describes how changes checked into the `Azure/azure-rest-api-specs` repository are published to public documentation across various platforms.

## Overview

The `Azure/azure-rest-api-specs` repository serves as the canonical source for REST API specifications for Microsoft Azure. Changes to this repository trigger automated processes that publish documentation to multiple public platforms:

- **GitHub Pages** - API documentation index and reference
- **docs.microsoft.com** - Official Microsoft documentation
- **learn.microsoft.com** - Microsoft Learn platform
- **azure.github.io** - Azure SDK documentation

## Publication Workflow

### 1. Repository Structure and Source

The repository follows a structured approach where:
- **TypeSpec projects** define API specifications using the TypeSpec language
- **OpenAPI specifications** are generated from TypeSpec or written manually (legacy)
- **SDK generation** creates client libraries for multiple programming languages
- **Documentation generation** produces reference documentation and guides

Key directories:
- `specification/` - Contains all API specifications organized by service
- `eng/` - Engineering tools and automation scripts
- `documentation/` - Repository documentation and guidelines

### 2. Automated Documentation Generation

#### DocFX-based Documentation

The primary documentation generation process uses DocFX and is orchestrated by:

**Script**: `eng/common/docgeneration/Generate-DocIndex.ps1`

This PowerShell script:
1. **Downloads DocFX** - Gets the latest DocFX documentation generator
2. **Generates documentation index** - Creates a hierarchical index of all services
3. **Builds static site** - Compiles documentation into a static website
4. **Organizes by service** - Groups APIs by Azure service categories

**Pipeline**: `eng/common/pipelines/templates/jobs/docindex.yml`

The Azure Pipeline job:
1. **Triggers on changes** - Runs when specifications are updated
2. **Uses Windows agents** - Executes on Windows 2022 build agents
3. **Builds documentation** - Runs the DocFX generation process
4. **Publishes artifacts** - Creates deployable documentation packages

### 3. GitHub Pages Publication

#### Automated GitHub Pages Deployment

The documentation is automatically deployed to GitHub Pages through:

```yaml
# Extract from docindex.yml
- pwsh: |
    git checkout -b gh-pages-local --track origin/gh-pages-root -f
  displayName: Git pull GH pages branch

- pwsh: |
    Copy-Item -Path $(Build.ArtifactStagingDirectory)/docfx_project/_site/* -Destination ./ -Recurse -Force
    git add -A
  displayName: Copy the latest changes

- task: PowerShell@2
  displayName: Push the Docs to GH-Pages
  inputs:
    filePath: $(toolPath)/common/scripts/git-branch-push.ps1
    arguments: >
      -PRBranchName "gh-pages"
      -CommitMsg "Auto-generated docs from SHA(s) $(Build.SourceVersion)"
      -GitUrl "https://$(azuresdk-github-pat)@github.com/$(Build.Repository.Name).git"
      -PushArgs "--force"
```

This process:
1. **Checks out gh-pages branch** - Switches to the GitHub Pages branch
2. **Copies generated site** - Moves built documentation to the branch
3. **Commits changes** - Commits the updated documentation
4. **Force pushes** - Deploys to GitHub Pages with the latest changes

#### GitHub Pages URL Structure

Documentation is published to: `https://azure.github.io/azure-rest-api-specs/`

### 4. SDK Automation and Documentation

#### SDK Generation Process

When API specifications change, the SDK automation process:

1. **Identifies changes** - Detects modified TypeSpec projects or OpenAPI files
2. **Validates specifications** - Ensures specs compile and pass validation
3. **Generates SDKs** - Creates client libraries for multiple languages:
   - Python (`azure-sdk-for-python`)
   - JavaScript/TypeScript (`azure-sdk-for-js`)
   - Java (`azure-sdk-for-java`)
   - .NET (`azure-sdk-for-net`)
   - Go (`azure-sdk-for-go`)

#### SDK Documentation Flow

Each generated SDK includes:
- **API reference documentation** - Generated from code comments
- **Samples and examples** - Practical usage examples
- **Package metadata** - Installation and usage instructions

This documentation flows to:
- **Package repositories** (NuGet, npm, PyPI, etc.)
- **Language-specific documentation sites**
- **Azure SDK documentation portal**

### 5. Microsoft Documentation Platforms

#### docs.microsoft.com Integration

API specifications contribute to docs.microsoft.com through:

1. **Reference documentation** - REST API reference pages
2. **Service documentation** - Integration with service-specific docs
3. **SDK package documentation** - Links to generated SDK docs

**Configuration**: Managed through scripts in `eng/common/scripts/`:
- `Update-DocsMsPackages.ps1` - Updates docs.microsoft.com package metadata
- `Update-DocsMsToc.ps1` - Maintains table of contents structure

#### learn.microsoft.com Integration

The Microsoft Learn platform receives:
- **API learning paths** - Structured learning content
- **Tutorial references** - Links to API documentation
- **Certification content** - API knowledge for Azure certifications

### 6. Publication Triggers

#### Automatic Triggers

Documentation publication occurs automatically on:

1. **Pull Request Merge** - When changes merge to main branch
2. **Scheduled Builds** - Regular updates to ensure consistency
3. **Dependency Updates** - When common types or shared resources change

#### Manual Triggers

Manual publication can be triggered through:
- **Azure Pipeline runs** - Direct pipeline execution
- **SDK generation pipeline** - Manual SDK generation with documentation
- **Emergency updates** - Hotfix documentation deployments

### 7. Content Types Published

#### API Reference Documentation

- **OpenAPI specifications** - Complete API definitions
- **Operation documentation** - Individual API operation details
- **Schema documentation** - Data model definitions
- **Authentication guides** - API authentication methods

#### SDK Documentation

- **Installation guides** - How to install and configure SDKs
- **Code samples** - Working code examples
- **API client documentation** - Generated from SDK code
- **Migration guides** - Upgrading between API versions

#### Process Documentation

- **Contribution guidelines** - How to contribute to specifications
- **Validation tools** - API specification validation
- **Breaking change policies** - API versioning guidelines

### 8. Quality Assurance

#### Validation Pipeline

Before publication, all changes undergo:

1. **Specification Validation** - TypeSpec/OpenAPI syntax and semantic checks
2. **Breaking Change Detection** - Identifies API compatibility issues
3. **Example Validation** - Ensures examples match specifications
4. **Linting** - Code style and formatting validation
5. **Security Scanning** - Credential and security policy checks

#### Review Process

Documentation changes are reviewed through:
- **Pull request reviews** - Community and maintainer review
- **Automated checks** - CI/CD pipeline validation
- **Service team approval** - Service owner validation

### 9. Monitoring and Maintenance

#### Health Monitoring

The publication process includes:
- **Build monitoring** - Pipeline success/failure tracking
- **Link validation** - Ensuring documentation links remain valid
- **Content freshness** - Identifying outdated documentation

#### Update Cadence

Documentation updates follow:
- **Immediate** - Critical fixes and security updates
- **Weekly** - Regular specification updates
- **Monthly** - Comprehensive review and cleanup
- **Quarterly** - Major process improvements

## Key Tools and Technologies

### Documentation Generation
- **DocFX** - Microsoft's documentation generation tool
- **TypeSpec** - API specification language
- **PowerShell** - Automation scripts
- **Azure Pipelines** - CI/CD automation

### Publication Platforms
- **GitHub Pages** - Static site hosting
- **Azure Storage** - Artifact hosting
- **docs.microsoft.com** - Official Microsoft documentation
- **learn.microsoft.com** - Microsoft Learn platform

### Integration Tools
- **AutoRest** - Code generation tool
- **OpenAPI Validator** - Specification validation
- **Azure CLI** - Cloud resource management

## Getting Started

### For Contributors

To contribute to API specifications and documentation:

1. **Read contributing guidelines** - [`CONTRIBUTING.md`](../CONTRIBUTING.md)
2. **Follow directory structure** - [Directory Structure Guide](./directory-structure.md)
3. **Use validation tools** - [Validation Tools](./SwaggerValidationTools.md)
4. **Submit pull requests** - Follow the GitHub workflow

### For Service Teams

To onboard your service documentation:

1. **Create TypeSpec project** - [TypeSpec Getting Started](./Getting-started-with-TypeSpec-specifications.md)
2. **Configure SDK generation** - [SDK Automation](./sdkautomation/README.md)
3. **Set up validation** - Configure CI/CD checks
4. **Document your APIs** - Add comprehensive documentation

## Troubleshooting

### Common Issues

1. **Build Failures** - Check [CI Fix Guide](./ci-fix.md)
2. **Validation Errors** - Review [Validation Reference](./Semantic-and-Model-Violations-Reference.md)
3. **Breaking Changes** - Follow [Breaking Changes Guidelines](./Breaking%20changes%20guidelines.md)

### Support Resources

- **Internal Documentation** - [Azure SDK Internal Wiki](https://aka.ms/jointhesdk)
- **Public Documentation** - [Getting Started Guide](./Getting%20started%20with%20OpenAPI%20specifications.md)
- **Community Support** - GitHub issues and discussions

## Related Documentation

- [Repository README](../README.md)
- [Directory Structure](./directory-structure.md)
- [TypeSpec Development Process](./typespec-rest-api-dev-process.md)
- [SDK Automation](./sdkautomation/README.md)
- [FAQ](./FAQ.md)

---

*This documentation is maintained by the Azure SDK team. For questions or updates, please create an issue in this repository.*