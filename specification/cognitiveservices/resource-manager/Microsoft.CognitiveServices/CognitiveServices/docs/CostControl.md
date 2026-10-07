# Cost Control TypeSpec model usage

This report describes the request and response model usage of the Cost Control
operations on the current branch.

## Operation summary

| Operation | ARM resource type | Request usage | Response usage |
|---|---|---|---|
| `CostControls.get` | `CostControl` supplies the ARM resource and route shape; it is not a request body. | No body. | `CostControlResponse` body and `CostControlEtagHeader` response header. |
| `CostControls.createOrUpdate` | `CostControl` is both the ARM resource type and the PUT request body. | `CostControl` → `CostControlPropertiesRequest` → `CostControlRuleRequest`; `CostControlCreateOrUpdateHeaders` supplies conditional request headers. | `CostControlResponse` for both `200` and `201`; `CostControlEtagHeader` supplies the response header. |
| `CostControls.update` | `CostControl` supplies the ARM resource and route shape; the patch body uses a separate model. | `CostControlPatchRequest` → `CostControlPatchPropertiesRequest` → `CostControlRuleRequest`; `CostControlIfMatchHeader` supplies the request header. | `CostControlResponse` body and `CostControlEtagHeader` response header. |
| `CostControls.delete` | `CostControl` supplies the ARM resource and route shape; it is not a request body. | No body; `CostControlIfMatchHeader` supplies the request header. | No response body for `200` or `204`. |
| `CostControls.list` | `CostControl` supplies the child-resource and parent-route shape; it is not a request body. | No body. | `CostControlListResponse`, whose `value[]` elements are `CostControlResponse`. |

## Request model chain

### PUT

```text
CostControl
└── properties: CostControlPropertiesRequest
    └── rules[]: CostControlRuleRequest
        ├── shared fields: CostControlRuleProperties
        └── thresholds?: CostControlThreshold[] | null
```

### PATCH

```text
CostControlPatchRequest
└── properties?: CostControlPatchPropertiesRequest
    └── rules[]?: CostControlRuleRequest
        ├── shared fields: CostControlRuleProperties
        └── thresholds?: CostControlThreshold[] | null
```

## Response model chain

### GET, PUT, and PATCH

```text
CostControlResponse
└── properties?: CostControlPropertiesResponse
    └── rules[]: CostControlRuleResponse
        ├── shared fields: CostControlRuleProperties
        └── thresholds?: CostControlThreshold[]
```

### List

```text
CostControlListResponse
└── value[]: CostControlResponse
    └── properties?: CostControlPropertiesResponse
        └── rules[]: CostControlRuleResponse
            ├── shared fields: CostControlRuleProperties
            └── thresholds?: CostControlThreshold[]
```

## Important distinction

`CostControlRuleRequest` and `CostControlRuleResponse` share their common fields
through `CostControlRuleProperties`, but their `thresholds` properties differ:

- Request: `CostControlThreshold[] | null`
- Response: `CostControlThreshold[]`

Both properties are optional. The request may therefore omit `thresholds`, send
`null`, or send an array. The response may omit `thresholds` or return an array,
but it may not return `null`.

Additional nested value types such as `CostControlDimension`,
`CostControlPeriod`, `CostControlMatch`, and the Cost Control unions are used
transitively through `CostControlRuleProperties`. They are omitted from the
report to keep the operation-to-envelope relationships readable.
