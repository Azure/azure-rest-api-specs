Spec owners are encouraged to remove old preview API versions from the specs repo, once they are retired from the service.

## Policies
* General
  * https://eng.ms/docs/products/azure-developer-experience/retirement/api-retirement
    * _Once a service API version is fully retired, the corresponding API spec should be removed from the specs repo_
  * https://aka.ms/cpexretirementsprocess
* ARM (resource-manager)
  * https://armwiki.azurewebsites.net/api_contracts/APIDeprecationPolicy.html
    * _Preview APIs have a life-span of not more than 12 months, after which they must be retired._

## Process
1. Open a PR deleting one (or more) previews.  All of:
   1. TypeSpec sources (`*.tsp`)
   2. Example sources (examples closest to `*.tsp` files)
   3. Generated swaggers and examples (`preview/YYYY-MM-DD-preview/**`)
   4. readme.md (remove tags)
2. PR should fail check `Swagger BreakingChange`, but pass all other checks.
3. Request approval following the normal process for breaking changes
   - https://aka.ms/brch
   - azbreakchangereview@microsoft.com

## Example
* [[widget] Remove resource-manager preview #39095](https://github.com/Azure/azure-rest-api-specs/pull/39095)
