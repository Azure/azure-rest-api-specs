# NSX Network Discovery — API Design Document

## 1. What This API Does

This API defines ARM resources for discovering and representing VMware NSX network infrastructure.
An on-premises agent discovers NSX objects (managers, gateways, segments, firewall rules, etc.)
and writes them into Azure as ARM resources under a **NetworkSite** container.

```
┌──────────────────┐      ┌────────────────────┐      ┌──────────────────────┐
│  TypeSpec (.tsp)  │─────▶│  tsp compile .     │─────▶│ Swagger 2.0 (.json) │
│  Hand-authored    │      │  @autorest emitter │      │ Auto-generated       │
│  Source of truth  │      └────────────────────┘      └──────────────────────┘
└──────────────────┘                                             │
                                                                 ▼
                                                   resource-manager/
                                                   Microsoft.ApplicationMigration/
                                                   Network/preview/2026-01-01-preview/
                                                   NetworkDiscovery.json
```

- **Inputs:** 13 TypeSpec files + `tspconfig.yaml` + 59 example JSONs
- **Output:** One Swagger 2.0 JSON file — `NetworkDiscovery.json`
- **API version:** `2026-01-01-preview`
- **ARM namespace:** `Microsoft.ApplicationMigration`

---

## 2. Resource Hierarchy (12 resource types)

```
                         Microsoft.ApplicationMigration
                                     │
                               NetworkSite                     ◄── TrackedResource (location + Azure tags)
                          /networkSites/{siteName}
                                     │
     ┌────────────┬──────────────────┼──────────────────┬──────────────────┐
     │            │                  │                  │                  │
 NetworkAgent  NsxManager    NsxTier0Gateway    NsxTier1Gateway     NsxSegment
 /agents/      /nsxManagers/ /tier0Gateways/    /tier1Gateways/     /segments/
 {agentName}   {managerName} {gatewayName}      {gatewayName}       {segmentName}
                                     │
     ┌───────────────────────────────┼──────────────────┬──────────────────┐
     │                               │                  │                  │
  NsxNsGroup               GatewayFirewallPolicy   NsxLoadBalancer    NsxNatRule
  /nsGroups/                /gatewayFirewall         /loadBalancers/   /natRules/
  {groupName}               Policies/{policyName}   {loadBalancerName} {natRuleName}
                                     │
                           GatewayFirewallRule          ◄── only 3-level nested resource
                           /rules/{ruleName}
```

**Key facts:**
- **1** TrackedResource: `NetworkSite` (has `location` + Azure `tags`)
- **11** ProxyResources: everything below NetworkSite (no location, no Azure tags)
- **1** 3-level nested resource: `GatewayFirewallRule` is a child of `GatewayFirewallPolicy`
- All other children are direct children of `NetworkSite`

---

## 3. Common Properties (AzureResourceProperties)

Every ProxyResource's properties model inherits from `AzureResourceProperties`:

| Property | Type | Notes |
|----------|------|-------|
| `provisioningState` | ProvisioningState | **Read-only**. Set by server ("Succeeded", "Failed", etc.) |
| `displayName` | string | The display name from NSX |
| `nsxOriginalPath` | string | The original path identifier in NSX (e.g., `/infra/tier-0s/T0-GW`) |
| `uniqueId` | string | The NSX unique identifier. **Must be UUID format** (`@pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")`) |
| `nsxTags` | NsxTag[] | NSX tags (scope + tag pairs — NOT Azure resource tags) |
| `errors` | Error[] | List of discovery/health errors |
| `errorCount` | int64 | The number of errors |

> **Note:** `nsxManagerRef` is **not** in the base model. It is added individually to each resource that needs it (all except NsxManager and NetworkAgent).

**Example in a response:**
```json
{
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "Segment-Web-Tier",
    "nsxOriginalPath": "/infra/segments/segment-web",
    "nsxManagerRef": "/subscriptions/.../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "nsxTags": [{ "scope": "env", "tag": "production" }],
    "errors": [],
    "errorCount": 0,
    ...resource-specific properties...
  }
}
```

---

## 4. Resource Details

### 4a. NetworkSite (TrackedResource — the root)

**URL:** `.../networkSites/{siteName}`
**TypeSpec file:** `NetworkSite.tsp`

| Property | Type | Required | Notes |
|----------|------|----------|-------|
| `provisioningState` | ProvisioningState | read-only | Server-set |
| `masterSiteId` | armResourceIdentifier | optional | → `Microsoft.OffAzure/masterSites` |
| `migrateProjectId` | armResourceIdentifier | optional | → `Microsoft.Migrate/migrateProjects` |

**Operations:**
| Operation | HTTP | Sync/Async |
|-----------|------|------------|
| Get | `GET .../networkSites/{siteName}` | Sync |
| CreateOrUpdate | `PUT .../networkSites/{siteName}` | **Async** (LRO) |
| Update | `PATCH .../networkSites/{siteName}` | **Async** (LRO) — tags only |
| Delete | `DELETE .../networkSites/{siteName}` | Sync |
| ListByResourceGroup | `GET .../networkSites` | Sync |
| ListBySubscription | `GET .../providers/.../networkSites` | Sync |

---

### 4b. NetworkAgent (ProxyResource)

**URL:** `.../networkSites/{siteName}/agents/{agentName}`
**TypeSpec file:** `NetworkAgent.tsp`

> **Note:** NetworkAgent does NOT inherit `AzureResourceProperties`. It has its own standalone properties (NSX tags, nsxOriginalPath, uniqueId, and nsxManagerRef do not apply to agents).

| Property | Type | Required | Visibility | Notes |
|----------|------|----------|------------|-------|
| `provisioningState` | ProvisioningState | read-only | Read | Server-set |
| `displayName` | string | no | Read+Write | Agent display name |
| `servicePrincipalIdentityDetails` | AgentSpnProperties | **yes** | Create+Read | SPN for auth |
| `migrateApplianceName` | string | **yes** | Create+Read | Appliance name |
| `fabricSiteName` | string | **yes** | Create+Read | Fabric site name |
| `healthDetails` | AgentHealthProperties | no | Read+Write | version, lastHeartBeatUtc |
| `errors` | Error[] | no | Read+Write | List of health errors |
| `errorCount` | int64 | no | Read+Write | Number of errors |

> `Create+Read` visibility means the field is set at creation and returned in responses, but cannot be changed via PATCH.

---

### 4c. NsxManager (ProxyResource)

**URL:** `.../networkSites/{siteName}/nsxManagers/{managerName}`
**TypeSpec file:** `NsxManager.tsp`

> **Note:** NsxManager does NOT have `nsxManagerRef` (it IS the manager, so a self-reference is meaningless).

| Property | Type | Required | Notes |
|----------|------|----------|-------|
| `fqdn` | string | **yes** | NSX Manager FQDN (e.g., `nsx-mgr01.contoso.com`) |
| `runAsAccount` | string | no | Credential reference |
| `localNsxManagerRefs` | armResourceIdentifier[] | no | ARM resource IDs of local NSX Manager references |
| `vcenterRefs` | armResourceIdentifier[] | no | → `Microsoft.OffAzure/vmwareSites/vcenters` |

---

### 4d. NsxTier0Gateway (ProxyResource)

**URL:** `.../networkSites/{siteName}/tier0Gateways/{gatewayName}`
**TypeSpec file:** `NsxTier0Gateway.tsp`

| Property | Type | Notes |
|----------|------|-------|
| `haMode` | HaMode | ACTIVE_ACTIVE / ACTIVE_STANDBY |
| `firewallEnabled` | boolean | Whether gateway firewall is on |
| `isVrf` | boolean | Whether this is a VRF gateway |
| `associatedTier1Gateways` | armResourceIdentifier[] | References to child T1 gateways |
| `associatedSegments` | armResourceIdentifier[] | References to connected segments |
| `associatedNatRules` | armResourceIdentifier[] | References to NAT rules on this gateway |
| `associatedGfwPolicies` | armResourceIdentifier[] | References to firewall policies |

**Custom action:**
- `POST .../tier0Gateways/{gatewayName}/listNatRules` → returns `NsxNatRuleList`

---

### 4e. NsxTier1Gateway (ProxyResource)

**URL:** `.../networkSites/{siteName}/tier1Gateways/{gatewayName}`
**TypeSpec file:** `NsxTier1Gateway.tsp`

| Property | Type | Notes |
|----------|------|-------|
| `haMode` | HaMode | ACTIVE_ACTIVE / ACTIVE_STANDBY |
| `firewallEnabled` | boolean | |
| `parentTier0Gateway` | armResourceIdentifier | Reference to the parent T0 gateway |
| `associatedSegments` | armResourceIdentifier[] | |
| `associatedNatRules` | armResourceIdentifier[] | |
| `associatedGfwPolicies` | armResourceIdentifier[] | |
| `associatedLoadBalancers` | armResourceIdentifier[] | |

**Custom action:**
- `POST .../tier1Gateways/{gatewayName}/listNatRules` → returns `NsxNatRuleList`

---

### 4f. NsxSegment (ProxyResource)

**URL:** `.../networkSites/{siteName}/segments/{segmentName}`
**TypeSpec file:** `NsxSegment.tsp`

| Property | Type | Notes |
|----------|------|-------|
| `parentGateway` | armResourceIdentifier | Reference to the T0 or T1 gateway this segment is attached to |
| `segmentType` | SegmentType | ROUTED / EXTENDED / ROUTED_AND_EXTENDED / DISCONNECTED |
| `vlanIds` | string[] | VLAN identifiers |
| `subnets` | Subnet[] | { gatewayAddress, network } |
| `systemOwned` | boolean | Whether NSX owns this segment |
| `adminState` | AdminState | UP / DOWN |
| `associatedVirtualMachines` | armResourceIdentifier[] | → `Microsoft.OffAzure/vmwareSites/machines` |

---

### 4g. NsxNsGroup (ProxyResource)

**URL:** `.../networkSites/{siteName}/nsGroups/{groupName}`
**TypeSpec file:** `NsxGroup.tsp`
**Model name:** `NsxNsGroup` (interface: `NsxNsGroups`, segment: `nsGroups`)

| Property | Type | Notes |
|----------|------|-------|
| `expressions` | GroupExpression[] | Membership criteria (conditions + conjunctions) |
| `effectiveVirtualMachineRefs` | EffectiveVmRef[] | Resolved VM references |
| `effectiveIpMembers` | string[] | Resolved IP addresses |

---

### 4h. NsxGatewayFirewallPolicy (ProxyResource)

**URL:** `.../networkSites/{siteName}/gatewayFirewallPolicies/{policyName}`
**TypeSpec file:** `NsxGatewayFirewallPolicy.tsp`

| Property | Type | Notes |
|----------|------|-------|
| `category` | GatewayPolicyCategory | Emergency, Infrastructure, Environment, Application, LocalGatewayRules, Default |
| `sequenceNumber` | int32 | Evaluation order |
| `isDefault` | boolean | Default policy flag |
| `contextType` | PolicyContextType | Generic / GatewaySpecific |
| `federationScope` | FederationScope | Local / Global |
| `appliedScopes` | armResourceIdentifier[] | Scopes this policy applies to |
| `effectiveScopes` | armResourceIdentifier[] | Computed effective scopes |

---

### 4i. NsxGatewayFirewallRule (ProxyResource — 3-level nested)

**URL:** `.../gatewayFirewallPolicies/{policyName}/rules/{ruleName}`
**Parent:** `NsxGatewayFirewallPolicy`
**TypeSpec file:** `NsxGatewayFirewallRule.tsp`

| Property | Type | Notes |
|----------|------|-------|
| `action` | FirewallAction | ALLOW / DROP / REJECT |
| `direction` | FirewallDirection | IN / OUT / IN_OUT |
| `disabled` | boolean | |
| `sequenceNumber` | int32 | Rule evaluation order |
| `globalPriority` | string | Global priority of the rule |
| `sourceIpGroups` | armResourceIdentifier[] | NsxNsGroup references |
| `sourceAddresses` | string[] | Raw IP/CIDR addresses |
| `destinationIpGroups` | armResourceIdentifier[] | NsxNsGroup references |
| `destinationAddresses` | string[] | |
| `services` | FirewallService[] | Inline service definitions (see below) |
| `appliedScopes` | armResourceIdentifier[] | |
| `effectiveScopes` | armResourceIdentifier[] | |

**FirewallService model (inline, not a separate ARM resource):**
```json
{
  "displayName": "HTTPS",
  "serviceEntries": [
    {
      "serviceEntryType": "L4PortSetServiceEntry",
      "displayName": "HTTPS",
      "l4Protocol": "TCP",
      "destinationPorts": ["443"]
    }
  ]
}
```

---

### 4j. NsxLoadBalancer (ProxyResource)

**URL:** `.../networkSites/{siteName}/loadBalancers/{loadBalancerName}`
**TypeSpec file:** `NsxLoadBalancer.tsp`

| Property | Type | Notes |
|----------|------|-------|
| `lbType` | LbType | L4 / L7 |
| `adminState` | AdminState | UP / DOWN / ENABLED / DISABLED |
| `parentGateway` | armResourceIdentifier | Reference to the T1 gateway this LB is on |
| `frontend` | FrontendConfig | { vip, port, protocol } |
| `backendConfig` | BackendConfig | { backendPool (members with vmRef → OffAzure machines), healthProbe, snat } |

---

### 4k. NsxNatRule (ProxyResource)

**URL:** `.../networkSites/{siteName}/natRules/{natRuleName}`
**TypeSpec file:** `NsxNatRule.tsp`

| Property | Type | Notes |
|----------|------|-------|
| `natType` | NatType | SNAT / DNAT |
| `adminState` | AdminState | |
| `parentGateway` | armResourceIdentifier | Reference to the T0 or T1 gateway |
| `match` | NatMatch | { source, destination, protocol } |
| `translate` | NatTranslate | { ipAddress, port } |

---

## 5. How Relationships Work

Resources reference each other through ARM resource IDs stored as properties.
There is **no ARM parent-child nesting** between (for example) a gateway and its NAT rules.
Instead, relationships are data properties.

### 5a. Relationship Map

```
NsxManager
  ├──▶ localNsxManagerRefs[]     → NsxManager (local managers)
  └──▶ vcenterRefs[]            → Microsoft.OffAzure/vmwareSites/vcenters

NsxTier0Gateway
  ├──▶ associatedTier1Gateways[]  → NsxTier1Gateway (by ARM ID)
  ├──▶ associatedSegments[]       → NsxSegment
  ├──▶ associatedNatRules[]       → NsxNatRule
  └──▶ associatedGfwPolicies[]    → NsxGatewayFirewallPolicy

NsxTier1Gateway
  ├──▶ parentTier0Gateway         → NsxTier0Gateway (single ref)
  ├──▶ associatedSegments[]       → NsxSegment
  ├──▶ associatedNatRules[]       → NsxNatRule
  ├──▶ associatedGfwPolicies[]    → NsxGatewayFirewallPolicy
  └──▶ associatedLoadBalancers[]  → NsxLoadBalancer

NsxSegment
  ├──▶ parentGateway              → NsxTier0Gateway or NsxTier1Gateway (single ref)
  └──▶ associatedVirtualMachines[]→ Microsoft.OffAzure/vmwareSites/machines

NsxLoadBalancer
  └──▶ parentGateway              → NsxTier1Gateway (single ref)

NsxNatRule
  └──▶ parentGateway              → NsxTier0Gateway or NsxTier1Gateway (single ref)

NsxGatewayFirewallRule
  ├──▶ sourceIpGroups[]           → NsxNsGroup
  └──▶ destinationIpGroups[]      → NsxNsGroup

ALL resources except NsxManager and NetworkAgent (via per-resource nsxManagerRef):
  └──▶ nsxManagerRef              → NsxManager (which manager discovered this)
```

### 5b. Example: How T0 → T1 → Segment → NAT → LB Are Connected

```json
// Tier-0 Gateway response
{
  "id": ".../networkSites/site1/tier0Gateways/T0-Main",
  "properties": {
    "displayName": "T0-Main",
    "isVrf": false,
    "associatedTier1Gateways": [
      ".../networkSites/site1/tier1Gateways/T1-Web",
      ".../networkSites/site1/tier1Gateways/T1-App"
    ],
    "associatedSegments": [
      ".../networkSites/site1/segments/transit-segment"
    ],
    "associatedNatRules": [
      ".../networkSites/site1/natRules/snat-outbound"
    ]
  }
}

// Tier-1 Gateway response
{
  "id": ".../networkSites/site1/tier1Gateways/T1-Web",
  "properties": {
    "displayName": "T1-Web-Tier",
    "parentTier0Gateway": ".../networkSites/site1/tier0Gateways/T0-Main",
    "associatedSegments": [
      ".../networkSites/site1/segments/web-segment"
    ],
    "associatedLoadBalancers": [
      ".../networkSites/site1/loadBalancers/web-lb"
    ],
    "associatedNatRules": [
      ".../networkSites/site1/natRules/dnat-web-ingress"
    ]
  }
}

// Segment response
{
  "id": ".../networkSites/site1/segments/web-segment",
  "properties": {
    "displayName": "Web-Segment",
    "parentGateway": ".../networkSites/site1/tier1Gateways/T1-Web",
    "segmentType": "ROUTED",
    "subnets": [{ "gatewayAddress": "10.0.1.1/24", "network": "10.0.1.0/24" }],
    "associatedVirtualMachines": [
      ".../vmwareSites/vsphere1/machines/vm-web-01",
      ".../vmwareSites/vsphere1/machines/vm-web-02"
    ]
  }
}

// NAT Rule response
{
  "id": ".../networkSites/site1/natRules/dnat-web-ingress",
  "properties": {
    "displayName": "DNAT-Web-Ingress",
    "natType": "DNAT",
    "parentGateway": ".../networkSites/site1/tier1Gateways/T1-Web",
    "match": {
      "source": { "ipAddress": ["0.0.0.0/0"], "port": "1024-65535" },
      "destination": { "ipAddress": ["203.0.113.10"], "port": "443" },
      "protocol": "TCP"
    },
    "translate": { "ipAddress": "10.0.1.100", "port": "443" }
  }
}

// Load Balancer response
{
  "id": ".../networkSites/site1/loadBalancers/web-lb",
  "properties": {
    "displayName": "Web-LB",
    "lbType": "L4",
    "parentGateway": ".../networkSites/site1/tier1Gateways/T1-Web",
    "frontend": { "vip": "10.0.1.50", "port": 443, "protocol": "HTTPS" },
    "backendConfig": {
      "backendPool": {
        "algorithm": "ROUND_ROBIN",
        "members": [
          { "ipAddress": "10.0.1.11", "port": 8443, "adminState": "ENABLED", "vmRef": ".../vmwareSites/vs1/machines/vm1" },
          { "ipAddress": "10.0.1.12", "port": 8443, "adminState": "ENABLED", "vmRef": ".../vmwareSites/vs1/machines/vm2" }
        ]
      }
    }
  }
}
```

### 5c. Visual: How to Find Related Resources

```
"Given a Tier-1 gateway, find all its resources"

GET .../tier1Gateways/T1-Web
  └── response.properties.associatedSegments[]     → GET each segment
  └── response.properties.associatedNatRules[]     → GET each NAT rule
  └── response.properties.associatedLoadBalancers[]→ GET each load balancer
  └── response.properties.associatedGfwPolicies[] → GET each firewall policy
         └── GET .../gatewayFirewallPolicies/{name}/rules  → list rules under it

"Given a NAT rule, find which gateway it belongs to"

GET .../natRules/dnat-web-ingress
  └── response.properties.parentGateway            → the T0 or T1 gateway ARM ID

"Given a segment, find VMs connected to it"

GET .../segments/web-segment
  └── response.properties.associatedVirtualMachines[] → OffAzure VM ARM IDs

"Given any resource (except Agent/Manager), find which NSX Manager discovered it"

GET .../segments/web-segment
  └── response.properties.nsxManagerRef              → NsxManager ARM ID
```

---

## 6. CRUD Operations Pattern

### 6a. Standard CRUD (every ProxyResource — 5 operations)

| Operation | HTTP | Response Codes | Body |
|-----------|------|----------------|------|
| Get | `GET .../resource/{name}` | 200 | Full resource |
| CreateOrUpdate | `PUT .../resource/{name}` | 200, 201 | Full resource (sync) |
| Update | `PATCH .../resource/{name}` | 200 | Full resource after merge |
| Delete | `DELETE .../resource/{name}` | 200, 204 | Empty |
| List | `GET .../resource` | 200 | `{ "value": [...], "nextLink": "..." }` |

### 6b. Patch Model Pattern (2-level wrapper)

All ProxyResource patches use a wrapper so ARM knows to merge at the `properties` level:

```
TypeSpec:
  model NsxManagerPatchProperties {              ← outer envelope
    properties?: NsxManagerPatchFields;           ← inner fields
  }
  model NsxManagerPatchFields {
    displayName?: string;
    nsxTags?: NsxTag[];
    errors?: Error[];
    errorCount?: int64;
    fqdn?: string;
    runAsAccount?: string;
    localNsxManagerRefs?: armResourceIdentifier[];
    vcenterRefs?: armResourceIdentifier[];
  }

Request body:
  PATCH .../nsxManagers/mgr1
  {
    "properties": {
      "displayName": "Updated Name",
      "fqdn": "new-nsx-mgr.contoso.com",
      "runAsAccount": "newAccount"
    }
  }
```

### 6c. Patchable Fields per Resource

| Resource | Patchable Fields |
|----------|-----------------|
| NetworkSite | Azure `tags` only (via `SiteTagsPatch`) |
| NetworkAgent | `healthDetails` |
| NsxManager | `runAsAccount` |
| NsxTier0Gateway | `haMode`, `firewallEnabled` |
| NsxTier1Gateway | `haMode`, `firewallEnabled` |
| NsxSegment | `adminState` |
| NsxNsGroup | `expressions` |
| GatewayFirewallPolicy | `sequenceNumber` |
| GatewayFirewallRule | `disabled`, `sequenceNumber` |
| NsxLoadBalancer | `adminState` |
| NsxNatRule | `adminState` |

### 6d. Custom Actions (non-CRUD)

| Action | HTTP | Description |
|--------|------|-------------|
| `NsxTier0Gateways_ListNatRules` | `POST .../tier0Gateways/{name}/listNatRules` | Returns NAT rules for this T0 |
| `NsxTier1Gateways_ListNatRules` | `POST .../tier1Gateways/{name}/listNatRules` | Returns NAT rules for this T1 |

These use `@action("listNatRules")` in TypeSpec, producing a POST endpoint that returns `NsxNatRuleList`.

---

## 7. Request vs Response — What Goes Where

```
┌────────────────────────┬──────────────┬──────────────────────────┐
│       Field            │   Request    │        Response          │
├────────────────────────┼──────────────┼──────────────────────────┤
│ provisioningState      │   ✗ NEVER    │   ✓ Always ("Succeeded") │
│ (read-only)            │              │                          │
├────────────────────────┼──────────────┼──────────────────────────┤
│ location               │ PUT only     │ TrackedResource only     │
│ tags (Azure)           │ PUT only     │ TrackedResource only     │
├────────────────────────┼──────────────┼──────────────────────────┤
│ properties.*           │ ✓ PUT body   │ ✓ Always                 │
│ (user-set fields)      │              │                          │
├────────────────────────┼──────────────┼──────────────────────────┤
│ id, name, type         │ ✗ NEVER      │ ✓ Always (server-set)    │
│ systemData             │ ✗ NEVER      │ ✓ Always (server-set)    │
└────────────────────────┴──────────────┴──────────────────────────┘
```

---

## 8. File Structure

```
Network.Management/
├── main.tsp                         ← Entry point (namespace, version, imports)
├── models.tsp                       ← Shared enums, base models, patch models
├── tspconfig.yaml                   ← Compiler config (output path, linter rules)
├── NetworkSite.tsp                  ← Root resource (TrackedResource)
├── NetworkAgent.tsp                 ← Agent (ProxyResource under NetworkSite)
├── NsxManager.tsp                   ← NSX Manager (ProxyResource)
├── NsxTier0Gateway.tsp              ← Tier-0 Gateway (ProxyResource + listNatRules action)
├── NsxTier1Gateway.tsp              ← Tier-1 Gateway (ProxyResource + listNatRules action)
├── NsxSegment.tsp                   ← Segment (ProxyResource)
├── NsxGroup.tsp                     ← NsxNsGroup (ProxyResource, segment=nsGroups)
├── NsxGatewayFirewallPolicy.tsp     ← Firewall Policy (ProxyResource)
├── NsxGatewayFirewallRule.tsp       ← Firewall Rule (3-level, parent=Policy)
├── NsxLoadBalancer.tsp              ← Load Balancer (ProxyResource)
├── NsxNatRule.tsp                   ← NAT Rule (ProxyResource)
├── readme.md                        ← This file
└── examples/
    └── 2026-01-01-preview/          ← 59 example JSON files
        ├── Operations_List_MaximumSet.json
        ├── NetworkSites_{6 ops}.json       (Get, Create, Update, Delete, ListByRG, ListBySub)
        ├── NetworkAgents_{5 ops}.json      (Get, Create, Update, Delete, ListByNetworkSite)
        ├── NsxManagers_{5 ops}.json
        ├── NsxTier0Gateways_{6 ops}.json   (5 CRUD + ListNatRules)
        ├── NsxTier1Gateways_{6 ops}.json   (5 CRUD + ListNatRules)
        ├── NsxSegments_{5 ops}.json
        ├── NsxNsGroups_{5 ops}.json
        ├── GatewayFirewallPolicies_{5 ops}.json
        ├── NsxGatewayFirewallRules_{5 ops}.json
        ├── NsxLoadBalancers_{5 ops}.json
        └── NsxNatRules_{5 ops}.json
                                     Total: 1 + 6 + (10 × 5) + 2 = 59
```

---

## 9. Enums (Extensible Unions)

All enums use `union` with a `string` fallback for forward compatibility:

| Enum | Values |
|------|--------|
| ProvisioningState | Succeeded, Failed, Canceled, Creating, Deleting, Updating, Unknown |
| HaMode | ACTIVE_ACTIVE, ACTIVE_STANDBY |
| AdminState | UP, DOWN, ENABLED, DISABLED |
| SegmentType | ROUTED, EXTENDED, ROUTED_AND_EXTENDED, DISCONNECTED |
| NatType | SNAT, DNAT |
| LbType | L4, L7 |
| LbProtocol | TCP, HTTP, HTTPS |
| LbAlgorithm | ROUND_ROBIN, LEAST_CONNECTION, WEIGHTED_ROUND_ROBIN, WEIGHTED_LEAST_CONNECTION |
| MemberAdminState | ENABLED, DISABLED, GRACEFUL_DISABLED |
| SnatType | DISABLED, AUTOMAP, IPPOOL |
| FirewallAction | ALLOW, DROP, REJECT |
| FirewallDirection | IN, OUT, IN_OUT |
| MatchProtocol | TCP, UDP, ICMP, ANY |
| GroupMemberType | VirtualMachine, SegmentPort |
| GroupExpressionOperator | CONTAINS, EQUALS, STARTSWITH, ENDSWITH |
| ConjunctionOperator | OR, AND |
| GroupExpressionKey | Name, Tag, OSName, ComputerName |
| GatewayPolicyCategory | Emergency, Infrastructure, Environment, Application, LocalGatewayRules, Default |
| FederationScope | Local, Global |
| PolicyContextType | Generic, GatewaySpecific |

---

## 10. Design Decisions

| # | Decision | Rationale |
|---|----------|-----------|
| 1 | **Flat hierarchy** under NetworkSite | All NSX resources are direct children of NetworkSite (not nested under gateways). Matches sibling repo patterns and enables future extension for other network fabrics (HyperV, Physical). |
| 2 | **NetworkSite** (not NsxSite) | Generic name supports future non-NSX network discovery. |
| 3 | **NsxNsGroup** model name | Correct NSX terminology. Segment = `nsGroups`, interface = `NsxNsGroups`. |
| 4 | **Full CRUD on all resources** | Consistent with all sibling services (Oracle, Mongo, Storage, etc.) — no read-only resources. |
| 5 | **Relationships via ARM resource ID properties** | Not through URL nesting. Follows the same pattern as all sibling repos. |
| 6 | **`parentGateway` (direct armResourceIdentifier)** | NatRule and LoadBalancer reference their parent gateway directly, not through a wrapper object. |
| 7 | **FirewallService is inline** (not a separate ARM resource) | Modeled as a property of GatewayFirewallRule, with `serviceEntries[]` array. |
| 8 | **`listNatRules` custom action on gateways** | POST action to get NAT rules for a specific gateway. Under team discussion. |
| 9 | **API version 2026-01-01-preview** | Aligned with team timeline. |

---

## 11. Deferred Items

| Item | Status | Notes |
|------|--------|-------|
| DNS resources (NsxDnsService, NsxDnsForwarderZone) | Phase 2 | Removed from current API version |
| List by NSX Manager (cross-reference query) | Team discussion | No sibling repo has this pattern |

---

## 12. ARM ID → GET Response: Every Resource Type

This section shows the exact GET response for each resource, using realistic data.
All ARM IDs use the base path:

```
/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.ApplicationMigration
```

> **Common envelope fields** (`id`, `name`, `type`, `systemData`) are present on every resource.
> The `systemData` block is the same shape for all and is abbreviated below as `{...}` after the first example.

---

### 12a. NetworkSite (TrackedResource)

```
GET /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.ApplicationMigration/networkSites/site1
```

```json
{
  "id": ".../networkSites/site1",
  "name": "site1",
  "type": "Microsoft.ApplicationMigration/networkSites",
  "location": "eastus",
  "tags": { "env": "test" },
  "systemData": {
    "createdBy": "user@example.com",
    "createdByType": "User",
    "createdAt": "2024-01-01T00:00:00Z",
    "lastModifiedBy": "user@example.com",
    "lastModifiedByType": "User",
    "lastModifiedAt": "2024-01-01T00:00:00Z"
  },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "MySite",
    "nsxOriginalPath": "/infra/sites/default",
    "uniqueId": "11111111-1111-1111-1111-111111111111",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "masterSiteId": ".../Microsoft.OffAzure/masterSites/ms1",
    "migrateProjectId": ".../Microsoft.Migrate/migrateProjects/mp1"
  }
}
```

> **Note:** Only NetworkSite has `location` and `tags` (Azure tags) — it's a TrackedResource.

---

### 12b. NetworkAgent

```
GET .../networkSites/site1/agents/agent1
```

```json
{
  "id": ".../networkSites/site1/agents/agent1",
  "name": "agent1",
  "type": "Microsoft.ApplicationMigration/networkSites/agents",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "agent1",
    "servicePrincipalIdentityDetails": {
      "tenantId": "00000000-0000-0000-0000-000000000001",
      "applicationId": "00000000-0000-0000-0000-000000000002",
      "objectId": "00000000-0000-0000-0000-000000000003"
    },
    "migrateApplianceName": "appliance1",
    "fabricSiteName": "fabric1",
    "healthDetails": {
      "version": "1.0.0",
      "lastHeartBeatUtc": "2024-06-01T12:00:00Z"
    },
    "errors": [],
    "errorCount": 0
  }
}
```

---

### 12c. NsxManager

```
GET .../networkSites/site1/nsxManagers/mgr1
```

```json
{
  "id": ".../networkSites/site1/nsxManagers/mgr1",
  "name": "mgr1",
  "type": "Microsoft.ApplicationMigration/networkSites/nsxManagers",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "nsx-mgr-01",
    "nsxOriginalPath": "/infra/managers/mgr1",
    "uniqueId": "22222222-2222-2222-2222-222222222222",
    "nsxTags": [{ "scope": "env", "tag": "prod" }],
    "errors": [],
    "errorCount": 0,
    "fqdn": "nsx-manager.contoso.com",
    "runAsAccount": "account1",
    "localNsxManagerRefs": [],
    "vcenterRefs": [
      ".../Microsoft.OffAzure/vmwareSites/vs1/vcenters/vc1"
    ]
  }
}
```

> **Key relationship:** `vcenterRefs` → points to OffAzure vCenter resources.
> **Note:** NsxManager does not have `nsxManagerRef` — it IS the manager.

---

### 12d. NsxTier0Gateway

```
GET .../networkSites/site1/tier0Gateways/t0gw1
```

```json
{
  "id": ".../networkSites/site1/tier0Gateways/t0gw1",
  "name": "t0gw1",
  "type": "Microsoft.ApplicationMigration/networkSites/tier0Gateways",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "T0-Gateway",
    "nsxOriginalPath": "/infra/tier-0s/t0gw",
    "nsxManagerRef": ".../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "33333333-3333-3333-3333-333333333333",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "haMode": "ACTIVE_ACTIVE",
    "firewallEnabled": true,
    "isVrf": false,
    "associatedTier1Gateways": [
      ".../networkSites/site1/tier1Gateways/t1gw1"
    ],
    "associatedSegments": [
      ".../networkSites/site1/segments/seg1"
    ],
    "associatedNatRules": [
      ".../networkSites/site1/natRules/nat1"
    ],
    "associatedGfwPolicies": [
      ".../networkSites/site1/gatewayFirewallPolicies/pol1"
    ]
  }
}
```

> **Key relationships:** T0 links outward to T1 gateways, segments, NAT rules, and firewall policies via `associated*` arrays.

---

### 12e. NsxTier1Gateway

```
GET .../networkSites/site1/tier1Gateways/t1gw1
```

```json
{
  "id": ".../networkSites/site1/tier1Gateways/t1gw1",
  "name": "t1gw1",
  "type": "Microsoft.ApplicationMigration/networkSites/tier1Gateways",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "T1-Gateway",
    "nsxOriginalPath": "/infra/tier-1s/t1gw",
    "nsxManagerRef": ".../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "44444444-4444-4444-4444-444444444444",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "haMode": "ACTIVE_STANDBY",
    "firewallEnabled": true,
    "parentTier0Gateway": ".../networkSites/site1/tier0Gateways/t0gw1",
    "associatedSegments": [
      ".../networkSites/site1/segments/seg1"
    ],
    "associatedNatRules": [
      ".../networkSites/site1/natRules/nat1"
    ],
    "associatedGfwPolicies": [
      ".../networkSites/site1/gatewayFirewallPolicies/pol1"
    ],
    "associatedLoadBalancers": [
      ".../networkSites/site1/loadBalancers/lb1"
    ]
  }
}
```

> **Key relationships:**
> - `parentTier0Gateway` → **single** ref pointing UP to its parent T0
> - `associated*` arrays → point OUT to segments, NAT, policies, LBs

---

### 12f. NsxSegment

```
GET .../networkSites/site1/segments/seg1
```

```json
{
  "id": ".../networkSites/site1/segments/seg1",
  "name": "seg1",
  "type": "Microsoft.ApplicationMigration/networkSites/segments",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "Segment-01",
    "nsxOriginalPath": "/infra/segments/seg1",
    "nsxManagerRef": ".../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "55555555-5555-5555-5555-555555555555",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "parentGateway": ".../networkSites/site1/tier1Gateways/t1gw1",
    "segmentType": "ROUTED",
    "vlanIds": ["100"],
    "subnets": [
      { "gatewayAddress": "10.0.0.1/24", "network": "10.0.0.0/24" }
    ],
    "systemOwned": false,
    "adminState": "UP",
    "associatedVirtualMachines": [
      ".../Microsoft.OffAzure/vmwareSites/vs1/machines/vm1"
    ]
  }
}
```

> **Key relationships:**
> - `parentGateway` → the T0 or T1 gateway this segment is attached to
> - `associatedVirtualMachines` → cross-provider refs to OffAzure VM resources

---

### 12g. NsxNsGroup

```
GET .../networkSites/site1/nsGroups/grp1
```

```json
{
  "id": ".../networkSites/site1/nsGroups/grp1",
  "name": "grp1",
  "type": "Microsoft.ApplicationMigration/networkSites/nsGroups",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "Group-01",
    "nsxOriginalPath": "/infra/domains/default/groups/grp1",
    "nsxManagerRef": ".../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "66666666-6666-6666-6666-666666666666",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "expressions": [
      {
        "resourceType": "Condition",
        "memberType": "VirtualMachine",
        "key": "Tag",
        "operator": "EQUALS",
        "value": "web-tier"
      },
      {
        "resourceType": "ConjunctionOperator",
        "conjunctionOperator": "OR"
      },
      {
        "resourceType": "Condition",
        "memberType": "VirtualMachine",
        "key": "Tag",
        "operator": "EQUALS",
        "value": "app-tier"
      }
    ],
    "effectiveVirtualMachineRefs": [
      {
        "vmRef": ".../Microsoft.OffAzure/vmwareSites/vs1/machines/vm1",
        "displayName": "vm-01"
      }
    ],
    "effectiveIpMembers": ["10.0.0.5"]
  }
}
```

> **Key relationships:**
> - `expressions` → group membership criteria (input)
> - `effectiveVirtualMachineRefs` → resolved VMs that match (output, cross-provider to OffAzure)
> - `effectiveIpMembers` → resolved IPs
> - Referenced **by** firewall rules via `sourceIpGroups` / `destinationIpGroups`

---

### 12h. NsxGatewayFirewallPolicy

```
GET .../networkSites/site1/gatewayFirewallPolicies/pol1
```

```json
{
  "id": ".../networkSites/site1/gatewayFirewallPolicies/pol1",
  "name": "pol1",
  "type": "Microsoft.ApplicationMigration/networkSites/gatewayFirewallPolicies",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "Default-Policy",
    "nsxOriginalPath": "/infra/domains/default/gateway-policies/pol1",
    "nsxManagerRef": ".../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "77777777-7777-7777-7777-777777777777",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "category": "LocalGatewayRules",
    "sequenceNumber": 100,
    "isDefault": true,
    "contextType": "GatewaySpecific",
    "federationScope": "Local",
    "appliedScopes": [
      ".../networkSites/site1/tier0Gateways/t0gw1"
    ],
    "effectiveScopes": [
      ".../networkSites/site1/tier0Gateways/t0gw1"
    ]
  }
}
```

> **Key relationships:**
> - `appliedScopes` / `effectiveScopes` → point to gateways this policy protects
> - Referenced **by** T0/T1 via `associatedGfwPolicies`
> - **Contains** firewall rules as 3-level children (see 12i)

---

### 12i. NsxGatewayFirewallRule (3-level nested under Policy)

```
GET .../networkSites/site1/gatewayFirewallPolicies/pol1/rules/rule1
```

```json
{
  "id": ".../networkSites/site1/gatewayFirewallPolicies/pol1/rules/rule1",
  "name": "rule1",
  "type": "Microsoft.ApplicationMigration/networkSites/gatewayFirewallPolicies/rules",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "Allow-SSH",
    "nsxOriginalPath": "/infra/domains/default/gateway-policies/pol1/rules/rule1",
    "nsxManagerRef": ".../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "88888888-8888-8888-8888-888888888888",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "action": "ALLOW",
    "direction": "IN_OUT",
    "disabled": false,
    "sequenceNumber": 10,
    "globalPriority": "05-0000000010-0000000001",
    "sourceIpGroups": [
      ".../networkSites/site1/nsGroups/grp1"
    ],
    "sourceAddresses": ["10.0.0.0/24"],
    "destinationIpGroups": [],
    "destinationAddresses": ["192.168.1.0/24"],
    "services": [
      {
        "displayName": "SSH",
        "serviceEntries": [
          {
            "serviceEntryType": "L4PortSetServiceEntry",
            "displayName": "SSH",
            "l4Protocol": "TCP",
            "protocol": "TCP",
            "sourcePorts": ["1024-65535"],
            "destinationPorts": ["22"]
          }
        ]
      },
      {
        "displayName": "ICMP-and-GRE",
        "serviceEntries": [
          { "serviceEntryType": "ICMPTypeServiceEntry", "displayName": "ICMP-Echo", "protocol": "ICMPv4", "icmpType": "8" },
          { "serviceEntryType": "ALGTypeServiceEntry", "displayName": "FTP-ALG", "alg": "FTP" },
          { "serviceEntryType": "IPProtocolServiceEntry", "displayName": "GRE", "protocolNumber": 47 }
        ]
      }
    ],
    "appliedScopes": [
      ".../networkSites/site1/tier0Gateways/t0gw1"
    ],
    "effectiveScopes": [
      ".../networkSites/site1/tier0Gateways/t0gw1"
    ]
  }
}
```

> **Key relationships:**
> - `sourceIpGroups` / `destinationIpGroups` → point to NsxNsGroup resources
> - `appliedScopes` / `effectiveScopes` → point to gateways
> - `services` → **inline** (not ARM references) — each has `serviceEntries[]`
> - Parent in URL path → `gatewayFirewallPolicies/pol1`

---

### 12j. NsxLoadBalancer

```
GET .../networkSites/site1/loadBalancers/lb1
```

```json
{
  "id": ".../networkSites/site1/loadBalancers/lb1",
  "name": "lb1",
  "type": "Microsoft.ApplicationMigration/networkSites/loadBalancers",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "LB-01",
    "nsxOriginalPath": "/infra/lb-services/lb1",
    "nsxManagerRef": ".../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "99999999-9999-9999-9999-999999999999",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "lbType": "L4",
    "adminState": "ENABLED",
    "parentGateway": ".../networkSites/site1/tier1Gateways/t1gw1",
    "frontend": {
      "vip": "10.0.1.100",
      "port": 443,
      "protocol": "HTTPS"
    },
    "backendConfig": {
      "backendPool": {
        "algorithm": "ROUND_ROBIN",
        "members": [
          {
            "ipAddress": "10.0.2.10",
            "port": 8443,
            "adminState": "ENABLED",
            "weight": 1,
            "vmRef": ".../vmwareSites/vs1/machines/vm1"
          }
        ]
      },
      "healthProbe": {
        "protocol": "HTTPS",
        "port": 8443
      },
      "snat": {
        "type": "IPPOOL",
        "ipPoolAddresses": ["10.0.3.100", "10.0.3.101"]
      }
    }
  }
}
```

> **Key relationships:**
> - `parentGateway` → the T1 gateway this LB is attached to
> - Referenced **by** T1 via `associatedLoadBalancers`

---

### 12k. NsxNatRule

```
GET .../networkSites/site1/natRules/nat1
```

```json
{
  "id": ".../networkSites/site1/natRules/nat1",
  "name": "nat1",
  "type": "Microsoft.ApplicationMigration/networkSites/natRules",
  "systemData": { "..." },
  "properties": {
    "provisioningState": "Succeeded",
    "displayName": "NAT-SNAT-01",
    "nsxOriginalPath": "/infra/tier-1s/t1gw/nat/USER/nat-rules/nat1",
    "nsxManagerRef": ".../networkSites/site1/nsxManagers/mgr1",
    "uniqueId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
    "nsxTags": [],
    "errors": [],
    "errorCount": 0,
    "natType": "SNAT",
    "adminState": "ENABLED",
    "parentGateway": ".../networkSites/site1/tier1Gateways/t1gw1",
    "match": {
      "source": { "ipAddress": ["10.0.0.0/24"], "port": "1024-65535" },
      "destination": { "ipAddress": ["0.0.0.0/0"], "port": "443" },
      "protocol": "ANY"
    },
    "translate": {
      "ipAddress": "203.0.113.10",
      "port": "8443"
    }
  }
}
```

> **Key relationships:**
> - `parentGateway` → the T0 or T1 gateway this rule is on
> - Referenced **by** T0/T1 via `associatedNatRules`

---

### 12l. Quick Reference: ARM Type → ARM ID Pattern

| ARM Type | ARM ID Pattern |
|----------|---------------|
| `networkSites` | `.../networkSites/{siteName}` |
| `networkSites/agents` | `.../networkSites/{siteName}/agents/{agentName}` |
| `networkSites/nsxManagers` | `.../networkSites/{siteName}/nsxManagers/{managerName}` |
| `networkSites/tier0Gateways` | `.../networkSites/{siteName}/tier0Gateways/{gatewayName}` |
| `networkSites/tier1Gateways` | `.../networkSites/{siteName}/tier1Gateways/{gatewayName}` |
| `networkSites/segments` | `.../networkSites/{siteName}/segments/{segmentName}` |
| `networkSites/nsGroups` | `.../networkSites/{siteName}/nsGroups/{groupName}` |
| `networkSites/gatewayFirewallPolicies` | `.../networkSites/{siteName}/gatewayFirewallPolicies/{policyName}` |
| `networkSites/gatewayFirewallPolicies/rules` | `.../gatewayFirewallPolicies/{policyName}/rules/{ruleName}` |
| `networkSites/loadBalancers` | `.../networkSites/{siteName}/loadBalancers/{loadBalancerName}` |
| `networkSites/natRules` | `.../networkSites/{siteName}/natRules/{natRuleName}` |

### 12m. Cross-Reference Summary: Who Points Where

```
┌──────────────────────────┬────────────────────────────┬────────────────────────────────────┐
│ Source Resource           │ Property                   │ Target Resource                    │
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ Most resources           │ nsxManagerRef               │ → NsxManager (not on Agent/Manager)│
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NetworkSite              │ masterSiteId                │ → Microsoft.OffAzure/masterSites   │
│ NetworkSite              │ migrateProjectId            │ → Microsoft.Migrate/migrateProjects│
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NsxManager               │ localNsxManagerRefs[]       │ → NsxManager (local managers)      │
│ NsxManager               │ vcenterRefs[]               │ → OffAzure/vmwareSites/vcenters    │
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NsxTier0Gateway          │ associatedTier1Gateways[]   │ → NsxTier1Gateway                  │
│ NsxTier0Gateway          │ associatedSegments[]        │ → NsxSegment                       │
│ NsxTier0Gateway          │ associatedNatRules[]        │ → NsxNatRule                       │
│ NsxTier0Gateway          │ associatedGfwPolicies[]     │ → NsxGatewayFirewallPolicy         │
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NsxTier1Gateway          │ parentTier0Gateway          │ → NsxTier0Gateway                  │
│ NsxTier1Gateway          │ associatedSegments[]        │ → NsxSegment                       │
│ NsxTier1Gateway          │ associatedNatRules[]        │ → NsxNatRule                       │
│ NsxTier1Gateway          │ associatedGfwPolicies[]     │ → NsxGatewayFirewallPolicy         │
│ NsxTier1Gateway          │ associatedLoadBalancers[]   │ → NsxLoadBalancer                  │
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NsxSegment               │ parentGateway               │ → NsxTier0Gateway/NsxTier1Gateway  │
│ NsxSegment               │ associatedVirtualMachines[] │ → OffAzure/vmwareSites/machines     │
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NsxGatewayFirewallPolicy │ appliedScopes[]             │ → NsxTier0/T1 Gateway              │
│ NsxGatewayFirewallPolicy │ effectiveScopes[]           │ → NsxTier0/T1 Gateway              │
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NsxGatewayFirewallRule   │ sourceIpGroups[]            │ → NsxNsGroup                       │
│ NsxGatewayFirewallRule   │ destinationIpGroups[]       │ → NsxNsGroup                       │
│ NsxGatewayFirewallRule   │ appliedScopes[]             │ → NsxTier0/T1 Gateway              │
│ NsxGatewayFirewallRule   │ effectiveScopes[]           │ → NsxTier0/T1 Gateway              │
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NsxLoadBalancer          │ parentGateway               │ → NsxTier1Gateway                  │
│ NsxLoadBalancer          │ backendPool.members[].vmRef  │ → OffAzure/vmwareSites/machines     │
├──────────────────────────┼────────────────────────────┼────────────────────────────────────┤
│ NsxNatRule               │ parentGateway               │ → NsxTier0/NsxTier1Gateway         │
└──────────────────────────┴────────────────────────────┴────────────────────────────────────┘
```
