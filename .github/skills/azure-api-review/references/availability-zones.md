<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - ARM Wiki: AvailabilityZones.md
       - ARM Wiki: AvailabilityZoneCustomerExperience.md
     The upstream documents always take precedence if there is a conflict. -->

# Availability Zones API Contract

These rules govern how Azure resources expose availability zone support
through the `zones` property in their API specifications.

**Authoritative references:**

- [ARM Wiki — Availability Zones](https://armwiki.azurewebsites.net/api_contracts/AvailabilityZones.html)
- [ARM Wiki — Availability Zones Customer Experience](https://armwiki.azurewebsites.net/api_contracts/AvailabilityZoneCustomerExperience.html)
- [Azure Resource Provider Contract — Resource API Reference](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)

---

## Zones Property Contract

### Request Behavior

The `zones` property is an **optional** top-level array of strings
(logical zone names):

| Request Value           | Meaning                                                              |
| ----------------------- | -------------------------------------------------------------------- |
| `"zones": ["1"]`        | Deploy the resource in logical zone 1                                |
| `"zones": ["1", "3"]`   | Deploy across logical zones 1 and 3                                  |
| `"zones": []` or `null` | RP may pick zones or create a non-zoned resource                     |
| `"zones": ["*"]`        | Resource should be zonal; RP fails if zone placement is not possible |

### Response Behavior

| Resource Type   | Response                               |
| --------------- | -------------------------------------- |
| Zonal resource  | Return logical zone name(s) in `zones` |
| Zone-redundant  | Return `null` or omit `zones`          |
| Old API version | Return `null` or omit `zones`          |

---

## Zone Immutability

- A resource's zone assignment **MUST NOT** be changed after creation.
  ARM rejects zone-change requests on existing resources.
- The RP **MUST** validate zone consistency on update requests (PUT) and
  reject changes with an appropriate error.
- The `zones` property **MUST** be annotated as immutable:
  - **OpenAPI:** `"x-ms-mutability": ["create", "read"]`
  - **TypeSpec:** `@visibility(Lifecycle.Create, Lifecycle.Read)`

---

## Placement in Resource Model

- The `zones` property **MUST** be a top-level property on the resource
  (alongside `id`, `name`, `type`, `location`), **not** inside the
  `properties` bag.
- The property type **MUST** be `array` of `string`.

### OpenAPI JSON

```json
"zones": {
  "type": "array",
  "items": { "type": "string" },
  "description": "The availability zones."
}
```

### TypeSpec

Use the standard ARM `zones` property from common types, or declare:

```tsp
/** The availability zones. */
zones?: string[];
```

---

## Nested Resources

- Nested resource types are **not** required to be in the same zone as
  the parent resource. Zone affinity is resource-type-specific.

---

## Zone Discoverability

Resource providers that support availability zones **MUST** ensure
zone information is discoverable via the
`GET /providers/Microsoft.{Namespace}` API (api-version ≥ 2016-07-01),
which returns `zoneMappings` for each resource type:

```json
"zoneMappings": [
  {
    "location": "Central US",
    "zones": ["1", "2", "3"]
  }
]
```

---

## Resource Move Across Subscriptions

When a zonal resource is moved across subscriptions, the **physical
zone** does not change but the **logical zone** may change if the
target subscription has a different logical-to-physical mapping. The RP
**MUST** update the `zones` property to reflect the correct logical
zone for the target subscription.
