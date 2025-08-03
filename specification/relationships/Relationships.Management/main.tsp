import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

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
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-09-01-preview`,
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
  sourceId: armResourceIdentifier;

  @doc("The relationship target resource id.")
  targetId: armResourceIdentifier<AllowedTargetResourceTypes>;

  @doc("The relationship target tenant id.")
  targetTenant?: string;

  @doc("Information about the origin of the relationship.")
  @visibility(Lifecycle.Read)
  originInformation: RelationshipOriginInformation;

  @doc("Metadata about the relationship.")
  @visibility(Lifecycle.Read)
  metadata: RelationshipMetadata;

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

@doc("ServiceGroupMember relationship properties.")
model ServiceGroupMemberRelationshipProperties
  is BaseRelationshipProperties<[
    {
      type: "Microsoft.Management/serviceGroups";
      scopes: ["Tenant"];
    }
  ]>;

@doc("Defines a ServiceGroupMember relationship resource.")
model ServiceGroupMemberRelationship
  is ExtensionResource<ServiceGroupMemberRelationshipProperties> {
  @doc("Name of ServiceGroupMember relationship.")
  @pattern("^[a-zA-Z0-9]{3,64}$")
  @visibility(Lifecycle.Read)
  @key
  @path
  @segment("serviceGroupMember")
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
}

@armResourceOperations
interface ServiceGroupMemberRelationships {
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceGroupMemberRelationship>;
  get is ArmResourceRead<ServiceGroupMemberRelationship>;
  delete is ArmResourceDeleteWithoutOkAsync<ServiceGroupMemberRelationship>;
}
