import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-liftr-base";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using LiftrBase;

/** Elastic Azure Integration Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Elastic Azure Integration management service" })
@versioned(Elastic.Versions)
namespace Elastic;

interface Operations extends Azure.ResourceManager.Operations {}

/** The available API versions. */
enum Versions {
  /** 2025-06-30-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v2_preview)
  v2025_06_30_preview: "2025-06-30-preview",
}

/** Elastic monitoring properties */
@doc("Properties specific to Elastic monitoring configuration")
model ElasticProperties {
  @pattern("^[a-zA-Z0-9_\\-.:\\/ ]*$")
  @maxLength(200)
  @doc("Description of the Elastic monitoring purpose")
  description?: string;

  @doc("Elastic stack version")
  elasticVersion?: string;

  @doc("Elastic cluster endpoint URL")
  elasticEndpoint?: string;

  @doc("Elastic deployment settings")
  deploymentSettings?: ElasticDeploymentSettings;
}

/** Elastic deployment configuration */
@doc("Elastic deployment settings")
model ElasticDeploymentSettings {
  @doc("Deployment size tier")
  deploymentSize?: ElasticDeploymentSize;

  @doc("Data retention period in days")
  dataRetentionDays?: int32;

  @doc("Enable log shipping")
  enableLogShipping?: boolean;

  @doc("Enable metrics collection")
  enableMetrics?: boolean;
}

/** Elastic deployment size options */
@doc("Elastic deployment size tiers")
union ElasticDeploymentSize {
  string,

  /** Small deployment size */
  Small: "Small",

  /** Medium deployment size */
  Medium: "Medium",

  /** Large deployment size */
  Large: "Large",

  /** Extra large deployment size */
  ExtraLarge: "ExtraLarge",
}

/** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
 * BaseResourceProperties contains Marketplace, useDetail related properties*/
@doc("Properties specific to Elastic monitoring organization")
model OrganizationProperties is BaseResourceProperties {
  @doc("Elastic monitoring properties")
  elasticProperties?: ElasticProperties;

  @doc("Single sign-on properties")
  singleSignOnProperties?: SingleSignOnPropertiesV2;
}

/** Elastic monitoring organization resource */
model OrganizationResource
  is Azure.ResourceManager.TrackedResource<OrganizationProperties> {
  @key("organizationname")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("organizations")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Elastic organization resource")
  @path
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * The type used for update operations of the Organization Resource.
 */
model OrganizationResourceUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /** Properties to update for the organization */
  properties?: OrganizationProperties;
}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<OrganizationResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OrganizationResource>;
  update is ArmCustomPatchSync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}
