import "@typespec/http";
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
@service({
  title: "Microsoft.Relationships Management Service",
})
@doc("Microsoft.Relationships Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.Relationships;

/** Relationships RP API Versions */
enum Versions {
  /** 2023-09-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-09-01-preview`,
}

/*
 * Base relationship types definitions
 */

alias ServiceExplicitlyCreated = "ServiceExplicitlyCreated";

alias UserExplicitlyCreated = "UserExplicitlyCreated";

@doc("Provides information about the origin of a relationship.")
model RelationshipOriginInformation<TOrigin = string> {
  @doc("Identifies the origin type of the relationship.")
  @visibility("read")
  relationshipOriginType: TOrigin;

  @doc("The name of the discovery engine that created the relationship.")
  @visibility("read")
  discoveryEngine?: string;
}

@doc("Provides information about the relationship properties.")
model RelationshipMetadata {
  @doc("The type of the relationship source resource.")
  @visibility("read")
  sourceType: string;

  @doc("The type of the relationship target resource.")
  @visibility("read")
  targetType: string;
}

/**
 * The provisioning state of a resource.
 */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The relationship is being provisioned */
  Provisioning: "Provisioning",
}

@doc("Base relationship properties.")
model BaseRelationshipProperties<TOrigin> {
  @doc("The source of the current relationship.")
  @visibility("read")
  sourceId: string;

  @doc("The target of the current relationship.")
  targetId: string;

  @doc("Metadata about the relationship.")
  @visibility("read")
  metadata: RelationshipMetadata;

  @doc("Information about the origin of the relationship.")
  @visibility("read")
  originInformation: RelationshipOriginInformation<TOrigin>;

  @doc("The provisioning state of the relationship.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/*
 * dependencyOf relationship type definition
 */

@doc("The possible origins of a dependencyOf relationship.")
union DependencyOfOrigins {
  @doc("The relationship was explicitly created by a system.")
  serviceExplicitlyCreated: ServiceExplicitlyCreated,

  @doc("The relationship was explicitly created by a user.")
  userExplicitlyCreated: UserExplicitlyCreated,

  string,
}

@doc("dependencyOf relationship properties.")
model DependencyOfRelationshipProperties
  is BaseRelationshipProperties<DependencyOfOrigins>;

@doc("Defines a dependencyOf relationship resource.")
model DependencyOfRelationship
  is ExtensionResource<DependencyOfRelationshipProperties> {
  @doc("Name of dependencyOf relationship.")
  @pattern("^[a-zA-Z0-9]{3,64}$")
  @visibility("read")
  @key
  @path
  @segment("dependencyOf")
  name: string;
}

/*
 * ServiceGroupMember relationship type definition
 */

@doc("The possible origins of a ServiceGroupMember relationship.")
union ServiceGroupMemberOrigins {
  @doc("The relationship was explicitly created by a system.")
  serviceExplicitlyCreated: ServiceExplicitlyCreated,

  @doc("The relationship was explicitly created by a user.")
  userExplicitlyCreated: UserExplicitlyCreated,

  string,
}

@doc("ServiceGroupMember relationship properties.")
model ServiceGroupMemberRelationshipProperties
  is BaseRelationshipProperties<ServiceGroupMemberOrigins>;

@doc("Defines a ServiceGroupMember relationship resource.")
model ServiceGroupMemberRelationship
  is ExtensionResource<ServiceGroupMemberRelationshipProperties> {
  @doc("Name of ServiceGroupMember relationship.")
  @pattern("^[a-zA-Z0-9]{3,64}$")
  @visibility("read")
  @key
  @path
  @segment("serviceGroupMember")
  name: string;
}

/*
 * Microsoft.Relationships RP interface definitions
 */

interface Operations extends Azure.ResourceManager.Operations {}

interface Relationships<TRelationship extends Azure.ResourceManager.Foundations.Resource> {
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TRelationship>;
  get is ArmResourceRead<TRelationship>;
  delete is ArmResourceDeleteSync<TRelationship>;
  list is ArmResourceListByParent<TRelationship>;
}

@armResourceOperations
interface DependencyOfRelationships
  extends Relationships<DependencyOfRelationship> {}

@armResourceOperations
interface ServiceGroupMemberRelationships
  extends Relationships<ServiceGroupMemberRelationship> {}
