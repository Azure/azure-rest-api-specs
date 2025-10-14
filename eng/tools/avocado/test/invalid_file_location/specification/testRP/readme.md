# Deployment Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Deployment Admin.

---

## Getting Started

To build the SDK for Deployment Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

```yaml $(tag) == 'package-2019-01-01'
input-file:
  - specs/2020-05-01/a.json
```

---

```yaml $(tag) == 'all-api-versions'
require: $(this-folder)/../../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/specs/2020-05-01/b.json
```
