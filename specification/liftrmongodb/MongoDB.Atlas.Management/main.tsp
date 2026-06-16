import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-liftr-base";
import "@azure-tools/typespec-autorest";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using LiftrBase;

/* MongoDB.Atlas Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "MongoDB.Atlas" })
@versioned(MongoDB.Atlas.Versions)
namespace MongoDB.Atlas;

/** The available API versions. */
@doc("Supported versions for the MongoDB.Atlas resource model")
enum Versions {
  /** 2024-11-18 preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2024_11_18_preview: "2024-11-18-preview",

  /** 2025-06-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_06_01: "2025-06-01",

  /** 2026-03-01 preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2026_03_01_preview: "2026-03-01-preview",
}

@doc("User details for an organization")
model UserDetails {
  @doc("First name of the user")
  firstName: string;

  @doc("Last name of the user")
  lastName: string;

  @doc("Email address of the user")
  emailAddress: email;

  @doc("User's principal name")
  upn?: string;

  @doc("User's phone number")
  phoneNumber?: string;

  @doc("Company Name")
  companyName?: string;
}

@doc("Base resource properties that can be extended for arm resources.")
model BaseResourceProperties {
  @doc("Marketplace details of the resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  marketplace: MarketplaceDetails;

  @doc("Details of the user.")
  user: UserDetails;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("MongoDB specific Properties")
model PartnerProperties {
  @doc("Organization Id in MongoDB system")
  organizationId?: string;

  @doc("Redirect URL for the MongoDB")
  redirectUrl?: string;

  @doc("Organization name in MongoDB system")
  @pattern("^[a-zA-Z0-9 _\\-().,:@+&',]{1,64}$")
  @minLength(1) // Minimum length constraint
  @maxLength(64) // Maximum length constraint
  organizationName: string;
}

/** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
 * BaseResourceProperties contains Marketplace, useDetail related properties*/
@doc("Properties specific to Organization")
model OrganizationProperties is BaseResourceProperties {
  @doc("MongoDB properties")
  partnerProperties?: PartnerProperties;
}

@doc("The resource model definition for an Azure Organization")
model OrganizationResource
  is Azure.ResourceManager.TrackedResource<OrganizationProperties> {
  @key("organizationName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("organizations")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Organization resource")
  @path
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<OrganizationResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OrganizationResource>;
  #suppress "@typespec/http/deprecated-implicit-optionality" "Legacy implicit optionality - DO NOT COPY"
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    OrganizationResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      OrganizationResource,
      OrganizationProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}

// =====================================================
// Project - child proxy resource under Organization
// =====================================================

@doc("Cluster tier options for MongoDB Atlas.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
union ClusterTier {
  string,

  @doc("Free tier cluster.")
  FREE: "FREE",

  @doc("Flex tier cluster.")
  FLEX: "FLEX",

  @doc("M10 tier cluster.")
  M10: "M10",

  @doc("M30 tier cluster.")
  M30: "M30",
}

@doc("Properties specific to a MongoDB Atlas Project.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
model ProjectProperties {
  @doc("Atlas project id.")
  @visibility(Lifecycle.Read)
  projectId?: string;

  @doc("Atlas project name.")
  @visibility(Lifecycle.Read)
  projectName?: string;

  @doc("Atlas organization id.")
  @visibility(Lifecycle.Read)
  organizationId?: string;

  @doc("Number of clusters in the project.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  clusterCount?: int64;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("The MongoDB Atlas Project resource type. A project is a logical grouping of clusters within an organization.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
@parentResource(OrganizationResource)
model Project is ProxyResource<ProjectProperties> {
  @key("projectName")
  @pattern("^.+$")
  @segment("projects")
  @minLength(1)
  @maxLength(64)
  @doc("Name of the MongoDB Atlas Project resource.")
  @path
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
interface Projects {
  get is ArmResourceRead<Project>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;
  delete is ArmResourceDeleteWithoutOkAsync<Project>;
  list is ArmResourceListByParent<Project>;

  @doc("Check if tier limit is reached for the project.")
  @autoRoute
  @armResourceAction(Project)
  @post
  tierLimitReached(...ResourceInstanceParameters<Project>):
    | ArmResponse<TierLimitReachedResponse>
    | ErrorResponse;

  @doc("List available regions by cluster tier for the project.")
  @autoRoute
  @armResourceAction(Project)
  @post
  @action("clusterTierRegions")
  listClusterTierRegions(...ResourceInstanceParameters<Project>):
    | ArmResponse<RegionsByTierResponse>
    | ErrorResponse;
}

@doc("Response for tier limit check.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
model TierLimitReachedResponse {
  @doc("List of project limit statuses.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["type"])
  limits: ProjectLimitStatus[];
}

@doc("Usage and limit status for a resource quota in a MongoDB Atlas project.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
model ProjectLimitStatus {
  @doc("Type of the limit.")
  type: ClusterTier;

  @doc("Maximum allowed value.")
  maximum: int32;

  @doc("Current value.")
  current: int32;

  @doc("Whether the limit has been reached.")
  isReached: boolean;
}

@doc("Response for regions by cluster tier.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
model RegionsByTierResponse {
  @doc("Atlas organization id.")
  @visibility(Lifecycle.Read)
  organizationId: string;

  @doc("Atlas project id.")
  @visibility(Lifecycle.Read)
  projectId: string;

  @doc("List of cluster tiers and their supported regions.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["tier"])
  regionsByTier: TierRegions[];
}

@doc("Cluster tier and its supported regions.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
model TierRegions {
  @doc("Cluster tier name.")
  tier: ClusterTier;

  @doc("Supported region names.")
  regions: string[];
}

// =====================================================
// Cluster - child proxy resource under Project
// =====================================================

@doc("Properties specific to a MongoDB Atlas Cluster.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
model ClusterProperties {
  @doc("Name of the MongoDB Atlas Cluster.")
  @visibility(Lifecycle.Read)
  clusterName?: string;

  @doc("Cluster tier (FREE, FLEX, M10, M30).")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterTier: ClusterTier;

  @doc("Azure region where the cluster is deployed.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  regionName: string;

  @doc("MongoDB version running on the cluster.")
  @visibility(Lifecycle.Read)
  mongoDbVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Partner API returns explicit null for backups when undetermined, not absent."
  @doc("Whether backups are active for the cluster; null if undetermined.")
  @visibility(Lifecycle.Read)
  backups?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Partner API returns explicit null for state when not available, not absent."
  @doc("Current state of the cluster.")
  @visibility(Lifecycle.Read)
  state?: string | null;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("The MongoDB Atlas Cluster resource type. A cluster is a managed database deployment within a project.")
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
@parentResource(Project)
model Cluster is ProxyResource<ClusterProperties> {
  @key("clusterName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]*$")
  @segment("clusters")
  @minLength(1)
  @maxLength(64)
  @doc("Name of the MongoDB Atlas Cluster resource.")
  @path
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
@added(MongoDB.Atlas.Versions.v2026_03_01_preview)
interface Clusters {
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cluster>;
  delete is ArmResourceDeleteWithoutOkAsync<Cluster>;
  list is ArmResourceListByParent<Cluster>;
  get is ArmResourceRead<Cluster>;
}
