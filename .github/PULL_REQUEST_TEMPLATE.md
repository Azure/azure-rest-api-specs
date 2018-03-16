This checklist is used to make sure that common issues in a pull request are addressed. This will expedite the process of getting your pull request merged and avoid extra work on your part to fix issues discovered during the review process.

### PR information
- [ ] The title of the PR is clear and informative.
- [ ] There are a small number of commits, each of which have an informative message. This means that previously merged commits do not appear in the history of the PR. For information on cleaning up the commits in your pull request, [see this page](https://github.com/Azure/azure-powershell/blob/master/documentation/development-docs/cleaning-up-commits.md).
- [ ] Except for special cases involving multiple contributors, the PR is started from a fork of the main repository, not a branch.
- [ ] If applicable, the PR references the bug/issue that it fixes.
- [ ] Swagger files are correctly named (e.g. the `api-version` in the path should match the `api-version` in the spec).

### Quality of Swagger
- [ ] I have read the [contribution guidelines](https://github.com/Azure/azure-rest-api-specs/blob/master/.github/CONTRIBUTING.md).
- [ ] My spec meets the review criteria:
  - [ ] The spec conforms to the [Swagger 2.0 specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md).
  - [ ] The spec follows the guidelines described in the [Swagger checklist](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-checklist.md) document.
  - [ ] [Validation tools](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-checklist.md#validation-tools-for-swagger-checklist) were run on swagger spec(s) and have all been fixed in this PR.
