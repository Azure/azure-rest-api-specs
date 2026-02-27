# identitygovernance

> see https://aka.ms/autorest

This is the AutoRest configuration file for identitygovernance.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Resource Provider (RP) index

> This readme is used by RPSaaS / ARM schema validation. It should enumerate every swagger file
> that makes up this Resource Provider. 
> IMPORTANT: Do NOT use this readme as the AutoRest "default" SDK readme for a single package.
> SDK generation is done from the per-service readme.md files under each <ServiceName>/ folder.

### Input

List all swagger files across the RP.

```yaml
input-file:
- Microsoft.EntraidGovernance/preview/2025-06-13-preview/openapi.json
- Microsoft.EntraidGovernance/preview/2025-02-01-preview/openapi.json
- Microsoft.EntraidGovernance/ScimApiConsumption/preview/2025-10-17-preview/scimopenapi.json
```