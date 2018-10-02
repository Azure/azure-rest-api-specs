# Tooling Service SDK

> see https://aka.ms/autorest

Configuration for generating Tooling Service SDK.

The current release is `release_1_0`.

``` yaml

tag: release_1_0
openapi-type: data-plane
```
# Releases

### Release 1.0
These settings apply only when `--tag=release_1_0` is specified on the command line.

``` yaml $(tag) == 'release_1_0'
input-file: preview/v1.0/toolingservice.json
directive:
- where: $.paths["/tools/validation/lint"].post
  suppress: D5001
  reason: It's an internal API
- where: $.paths["/tools/validation/lint/result"].get
  suppress: D5001
  reason: It's an internal API
- where: $.paths["/tools/validation/semantic"].post
  suppress: D5001
  reason: It's an internal API
- where: $.paths["/tools/validation/semantic/result"].get
  suppress: D5001
  reason: It's an internal API
- where: $.paths["/tools/validation/model"].post
  suppress: D5001
  reason: It's an internal API
- where: $.paths["/tools/validation/model/result"].get
  suppress: D5001
  reason: It's an internal API
- where: $.paths["/tools/validation/trace"].post
  suppress: D5001
  reason: It's an internal API
- where: $.paths["/tools/validation/trace/result"].get
  suppress: D5001
  reason: It's an internal API
- where: $.paths["/tools/validation/trace/details"].get
  suppress: D5001
  reason: It's an internal API
```