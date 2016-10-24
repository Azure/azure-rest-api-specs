This checklist is used to make sure that common issues in a pull request are addressed. This will expedite the process of getting your pull request merged and avoid extra work on your part to fix issues discovered during the review process. 

### PR information
- [ ] The title of the PR is clear and informative.
- [ ] There are a small number of commits, each of which have an informative message. This means that previously merged commits do not appear in the history of the PR. For information on cleaning up the commits in your pull request, [see this page](https://github.com/Azure/azure-powershell/blob/dev/documentation/cleaning-up-commits.md).
- [ ] Except for special cases involving multiple contributors, the PR is started from a fork of the main repository, not a branch.
- [ ] If applicable, the PR references the bug/issue that it fixes.
- [ ] Swagger files are correctly named (e.g. the `api-version` in the path should match the `api-version` in the spec).

### Quality of Swagger
- [ ] I have read the [contribution guidelines](https://github.com/Azure/azure-rest-api-specs/blob/master/.github/CONTRIBUTING.md).
- [ ] My spec meets the review criteria:
  - [ ] The spec conforms to the [Swagger 2.0 specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md).
  - [ ] Validation errors from the [Linter extension for VS Code](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/linter.md) have all been fixed for this spec. (**Note:** for large, previously checked in specs, there will likely be many errors shown. Please contact our team so we can set a timeframe for fixing these errors if your PR is not going to address them).
  - [ ] The spec follows the patterns described in the [Swagger good patterns](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-good-patterns.md) document unless the service API makes this impossible.