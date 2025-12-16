# List Monitored Compute Resources API - Design Document

## Overview

The `listMonitoredComputeResources` API provides a way to retrieve compute resources that are being monitored by a Dynatrace monitor. This API allows filtering by resource type and returns monitoring status information for each resource.

## API Details

### Endpoint
```
POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Dynatrace.Observability/monitors/{monitorName}/listMonitoredComputeResources?api-version=2025-11-03-preview
```

### HTTP Method
**POST** - Used for action-style operation with optional request body for filtering

### Request Body (Optional)

The request body is **optional**. If not provided, the API returns all monitored compute resources.

```json
{
  "resourceType": "managedClusters"  // or "All"
}
```

#### Request Model: `MonitoredComputeResourcesRequest`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| resourceType | MonitoredComputeResourceType (union) | No | The type of compute resources to filter by. If not specified, returns all monitored compute resources. |

#### MonitoredComputeResourceType Values

| Value | Description |
|-------|-------------|
| `All` | Returns all monitored compute resource types |
| `managedClusters` | Returns only AKS managed clusters |

*Note: Additional resource types can be added in the future (e.g., `virtualMachines`, `containerInstances`)*

### Response

The API returns a paginated list of monitored compute resources.

#### Response Model: `MonitoredComputeResourceListResponse`

```json
{
  "resourceType": ["managedClusters"],
  "value": [
    {
      "monitoredResourceId": "/subscriptions/.../resourceGroups/.../providers/Microsoft.ContainerService/managedClusters/myCluster",
      "isMonitored": true,
      "reasonForMonitoringStatus": ""
    },
    {
      "monitoredResourceId": "/subscriptions/.../resourceGroups/.../providers/Microsoft.ContainerService/managedClusters/myCluster2",
      "isMonitored": false,
      "reasonForMonitoringStatus": "Resource monitoring is disabled"
    }
  ],
  "nextLink": "https://.../listMonitoredComputeResources?api-version=2025-11-03-preview&$skiptoken=..."
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| resourceType | string[] | No | Array of resource types included in this response |
| value | MonitoredComputeResourceInfo[] | Yes | Array of monitored compute resources |
| nextLink | string | No | URL to retrieve the next page of results (pagination) |

#### MonitoredComputeResourceInfo Model

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| monitoredResourceId | string (ARM resource ID) | No | The full ARM resource ID of the monitored compute resource |
| isMonitored | boolean | No | Flag indicating if the resource is currently being monitored by Dynatrace |
| reasonForMonitoringStatus | string | No | Reason for the monitoring status. Empty string when `isMonitored` is true. Contains explanation when `isMonitored` is false (e.g., "Resource monitoring is disabled", "Insufficient permissions") |

## Design Decisions

### 1. Response-Level vs Resource-Level `resourceType`

**Current Design**: `resourceType` is at the **response level** as an array.

**Rationale**: 
- Provides a summary of types included in the response
- Reduces payload size by not repeating the type for each resource

**Open Question**: Should `resourceType` be moved to the resource item level for better filtering when "All" is used?

**Alternative Design**: Resource-level `resourceType`
```json
{
  "value": [
    {
      "monitoredResourceId": "...",
      "resourceType": "managedClusters",  // Per-resource type
      "isMonitored": true
    }
  ]
}
```

**Consideration**: With response-level array, when filtering by "All", the client cannot distinguish which individual resources are of which type. Moving `resourceType` to the resource level would solve this issue.

### 2. Optional vs Mandatory Request Body

**Current Design**: Request body is **optional** (`OptionalRequestBody = true`)

**Rationale**:
- Follows Azure API Guidelines pattern for list/filter operations
- Most common use case is "get all" - making this the default reduces friction
- Aligns with Azure's RESTful patterns where filters are typically optional

**Alternative Considered**: Making request body mandatory
- Would force explicit intent (e.g., must pass "All" or specific type)
- Rejected because it goes against Azure API conventions

### 3. Single vs Multiple Resource Type Filtering

**Current Design**: Request accepts a **single** `resourceType` value

**Rationale**:
- Simpler API contract
- "All" value provides ability to get all types
- Most use cases involve filtering by one type at a time

**Future Enhancement**: Could support multiple types
```json
{
  "resourceType": ["managedClusters", "virtualMachines"]
}
```

### 4. Field Redundancy Discussion

**Fields Removed from Response**:
- `monitorId` - Redundant (already in URL path)
- `partnerName` - Redundant (resource-level data)
- `tenantId` - Redundant (resource-level data)

**Fields Kept**:
- `monitoredResourceId` - Essential for identifying the resource
- `isMonitored` - Core status information
- `reasonForMonitoringStatus` - Provides context (mirrors `reasonForMetricsStatus` and `reasonForLogsStatus` patterns from existing APIs)

### 5. Consistency with Existing APIs

This API follows patterns established by the existing `listMonitoredResources` API:
- Similar naming convention (listMonitored*)
- Similar response structure with monitoring status
- Similar reason field pattern (`reasonForMonitoringStatus`)
- Pagination support via `nextLink`

## Use Cases

### Use Case 1: Get All Monitored Compute Resources
**Request**: No body or `{ "resourceType": "All" }`
**Response**: All compute resources across all types

### Use Case 2: Get Only AKS Clusters
**Request**: `{ "resourceType": "managedClusters" }`
**Response**: Only managed clusters (AKS)

### Use Case 3: Pagination
**Request**: Follow `nextLink` URL from previous response
**Response**: Next page of results

### Use Case 4: Identify Unmonitored Resources
**Client Action**: Filter response for items where `isMonitored` is false, read `reasonForMonitoringStatus` to understand why

## API Versioning

- **API Version**: `2025-11-03-preview`
- **Status**: Preview
- **Decorator**: `@added(Dynatrace.Observability.Versions.v2025_11_03_preview)`

## Open Questions for Review

1. **Resource-level resourceType**: Should we move `resourceType` from response level to individual resource items to enable better client-side filtering when using "All"?

2. **Multiple type filtering**: Should we support filtering by multiple resource types in the request (e.g., `["managedClusters", "virtualMachines"]`)?

3. **Response-level resourceType as array**: If keeping at response level, is the array format useful, or should it be a single string that matches the request filter?

## Related APIs

- `listMonitoredResources` - Lists all monitored Azure resources (not just compute)
- `getMetricStatus` - Gets metrics monitoring status
- `getLogStatus` - Gets logs monitoring status

## Future Enhancements

1. Support for additional compute resource types (VMs, Container Instances, etc.)
2. Additional filtering options (by monitoring status, by resource group, etc.)
3. Sorting capabilities
4. More detailed monitoring metadata per resource
