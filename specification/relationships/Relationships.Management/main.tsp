import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.Relationships Management Service" })
@doc("Microsoft.Relationships Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.Relationships;

/** Relationships RP API Versions */
enum Versions {
  /** 2023-09-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-09-01-preview`,

  /** 2026-03-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2026-03-01-preview`,
}

/*
 * Base relationship types definitions
 */

@doc("Provides information about the relationship properties.")
model RelationshipMetadata {
  @doc("The type of the relationship source resource.")
  @visibility(Lifecycle.Read)
  sourceType: string;

  @doc("The type of the relationship target resource.")
  @visibility(Lifecycle.Read)
  targetType: string;
}

@doc("The possible origins of a relationship.")
union RelationshipOrigins {
  @doc("The relationship was explicitly created by a system.")
  ServiceExplicitlyCreated: "ServiceExplicitlyCreated",

  @doc("The relationship was discovered by a system-created rule.")
  SystemDiscoveredByRule: "SystemDiscoveredByRule",

  @doc("The relationship was explicitly created by a user.")
  UserExplicitlyCreated: "UserExplicitlyCreated",

  @doc("The relationship was discovered by a user-created rule.")
  UserDiscoveredByRule: "UserDiscoveredByRule",

  string,
}

@doc("Provides information about the origin of a relationship.")
model RelationshipOriginInformation {
  @doc("Identifies the origin type of the relationship.")
  @visibility(Lifecycle.Read)
  relationshipOriginType: RelationshipOrigins;

  @doc("The name of the discovery engine that created the relationship.")
  @visibility(Lifecycle.Read)
  discoveryEngine?: string;
}

@doc("The provisioning state of the resource.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource provisioning request has been accepted. */
  Accepted: "Accepted",

  string,
}

@doc("Base relationship properties.")
model BaseRelationshipProperties<AllowedTargetResourceTypes extends ArmResourceIdentifierAllowedResource[] = never> {
  @doc("The relationship source resource id.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.`2026-03-01-preview`)
  sourceId?: armResourceIdentifier;

  @doc("The relationship target resource id.")
  targetId: armResourceIdentifier<AllowedTargetResourceTypes>;

  @doc("The relationship target tenant id.")
  targetTenant?: string;

  @doc("Information about the origin of the relationship.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.`2026-03-01-preview`)
  originInformation?: RelationshipOriginInformation;

  @doc("Metadata about the relationship.")
  @visibility(Lifecycle.Read)
  @madeOptional(Versions.`2026-03-01-preview`)
  metadata?: RelationshipMetadata;

  @doc("The provisioning state of the relationship.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/*
 * dependencyOf relationship type definition
 */

@doc("dependencyOf relationship properties.")
model DependencyOfRelationshipProperties is BaseRelationshipProperties;

@doc("Defines a dependencyOf relationship resource.")
model DependencyOfRelationship
  is ExtensionResource<DependencyOfRelationshipProperties> {
  @doc("Name of dependencyOf relationship.")
  @pattern("^[a-zA-Z0-9]{3,64}$")
  @visibility(Lifecycle.Read)
  @key
  @path
  @segment("dependencyOf")
  name: string;
}

/*
 * serviceGroupMember relationship type definition
 */

// NOTE: In the 2026-03-01-preview swagger the ServiceGroupMember source/target
// semantics are flipped relative to 2023-09-01-preview: sourceId becomes the
// writable/required service group and targetId becomes the server-derived
// (read-only) scoped resource. In 2026 neither side carries an arm-id
// resource-type constraint; the service-group nature of sourceId is enforced
// RP-side. The 2023 shape is left unchanged: its `targetId` keeps the original
// `Microsoft.Management/serviceGroups` (Tenant scope) constraint so the shipped
// 2023-09-01-preview swagger is not modified.
// The tenant property is also renamed from `targetTenant` to `sourceTenant`,
// since after the flip the relationship's tenant is the source (service group) tenant.
//
// A per-version visibility flip (and rename) on the same property name cannot be
// expressed on a single model, so SGM is decoupled into two version-specific
// property models: the 2023 shape keeps inheriting BaseRelationshipProperties and
// is `@removed` in 2026; the 2026 shape is a standalone `...V2` model `@added` in
// 2026. The resource's `properties` type is swapped per version via an augment
// `@@typeChangedFrom`. DependencyOf and MemberOf are unaffected and keep
// `targetTenant`. This is fully generated by `tsp compile` — no manual override.
@doc("ServiceGroupMember relationship properties.")
@removed(Versions.`2026-03-01-preview`)
model ServiceGroupMemberRelationshipProperties
  is BaseRelationshipProperties<[
    {
      type: "Microsoft.Management/serviceGroups";
      scopes: ["Tenant"];
    }
  ]>;

@doc("ServiceGroupMember relationship properties.")
@added(Versions.`2026-03-01-preview`)
model ServiceGroupMemberRelationshipPropertiesV2 {
  @doc("The relationship source resource id. Must be a service group.")
  sourceId: armResourceIdentifier;

  @doc("The relationship target resource id. Server-derived from the scoped resource.")
  @visibility(Lifecycle.Read)
  targetId?: armResourceIdentifier;

  @doc("The relationship source tenant id.")
  sourceTenant?: string;

  @doc("Information about the origin of the relationship.")
  @visibility(Lifecycle.Read)
  originInformation?: RelationshipOriginInformation;

  @doc("Metadata about the relationship.")
  @visibility(Lifecycle.Read)
  metadata?: RelationshipMetadata;

  @doc("The provisioning state of the relationship.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Defines a ServiceGroupMember relationship resource.")
model ServiceGroupMemberRelationship
  is ExtensionResource<ServiceGroupMemberRelationshipPropertiesV2> {
  @doc("Name of ServiceGroupMember relationship.")
  @pattern("^[a-zA-Z0-9]{3,64}$")
  @visibility(Lifecycle.Read)
  @key
  @path
  @segment("serviceGroupMember")
  name: string;
}

// Swap the SGM properties type per version: 2023 uses the inherited-base shape,
// 2026 uses the decoupled V2 shape.
@@typeChangedFrom(
  ServiceGroupMemberRelationship.properties,
  Versions.`2026-03-01-preview`,
  ServiceGroupMemberRelationshipProperties
);

/*
 * contains relationship type definition
 */

@doc("contains relationship properties.")
@added(Versions.`2026-03-01-preview`)
model ContainsRelationshipProperties {
  @doc("The relationship source resource id. Must be a subscription or resource group.")
  @visibility(Lifecycle.Read)
  sourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Resources/subscriptions";
      scopes: ["Subscription"];
    },
    {
      type: "Microsoft.Resources/resourceGroups";
      scopes: ["ResourceGroup"];
    }
  ]>;

  @doc("The relationship target resource id.")
  targetId: armResourceIdentifier;

  @doc("The relationship target tenant id.")
  targetTenant?: string;

  @doc("Information about the origin of the relationship.")
  @visibility(Lifecycle.Read)
  originInformation?: RelationshipOriginInformation;

  @doc("Metadata about the relationship.")
  @visibility(Lifecycle.Read)
  metadata?: RelationshipMetadata;

  @doc("The provisioning state of the relationship.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Defines a contains relationship resource.")
@added(Versions.`2026-03-01-preview`)
model ContainsRelationship
  is ExtensionResource<ContainsRelationshipProperties> {
  @doc("Name of contains relationship.")
  @pattern("^[a-zA-Z0-9]{3,64}$")
  @visibility(Lifecycle.Read)
  @key
  @path
  @segment("contains")
  name: string;
}

/*
 * Microsoft.Relationships RP interface definitions
 */

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface DependencyOfRelationships {
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DependencyOfRelationship>;
  get is ArmResourceRead<DependencyOfRelationship>;
  delete is ArmResourceDeleteWithoutOkAsync<DependencyOfRelationship>;
  @added(Versions.`2026-03-01-preview`)
  listByParent is ArmResourceListByParent<DependencyOfRelationship>;
}

@armResourceOperations
interface ServiceGroupMemberRelationships {
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceGroupMemberRelationship>;
  get is ArmResourceRead<ServiceGroupMemberRelationship>;
  delete is ArmResourceDeleteWithoutOkAsync<ServiceGroupMemberRelationship>;
  @added(Versions.`2026-03-01-preview`)
  listByParent is ArmResourceListByParent<ServiceGroupMemberRelationship>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "ContainsRelationships only has list operations — @armResourceOperations would apply @autoRoute which corrupts the manually specified route for the resource group scoped endpoint"
@added(Versions.`2026-03-01-preview`)
interface ContainsRelationships {
  @doc("List ContainsRelationship resources by subscription ID")
  listBySubscription is ArmListBySubscription<
    ContainsRelationship,
    {
      @doc("Filters the results by target resource type. Example: properties.metadata.targetType eq 'Microsoft.Compute/virtualMachines'")
      @query("$filter")
      filter?: string;

      @doc("The maximum number of results to return.")
      @query("$top")
      top?: int32;
    }
  >;

  @doc("List ContainsRelationship resources by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relationships/contains")
  @get
  @list
  listByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("Filters the results by target resource type. Example: properties.metadata.targetType eq 'Microsoft.Compute/virtualMachines'")
    @query("$filter")
    filter?: string,

    @doc("The maximum number of results to return.")
    @query("$top")
    top?: int32,
  ): ArmResponse<ResourceListResult<ContainsRelationship>> | ErrorResponse;
}
