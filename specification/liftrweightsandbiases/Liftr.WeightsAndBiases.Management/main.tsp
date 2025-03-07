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

/* Microsoft.WeightsAndBiases Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.WeightsAndBiases management service" })
@versioned(Microsoft.WeightsAndBiases.Versions)
namespace Microsoft.WeightsAndBiases;

/** The available API versions. */
enum Versions {
  /** 2024-09-18 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v2_preview)
  v2024_09_18_preview: "2024-09-18-preview",
}

/** The available regions */
union Region {
  string,

  @doc("Region: East US")
  eastus: "eastus",

  @doc("Region: Central US")
  centralus: "centralus",

  @doc("Region: West US")
  westus: "westus",

  @doc("Region: West Europe")
  westeurope: "westeurope",

  @doc("Region: Japan East")
  japaneast: "japaneast",

  @doc("Region: Korea Central")
  koreacentral: "koreacentral",
}

@doc("Partner's specific Properties")
model PartnerProperties {
  @doc("The region of the instance")
  region: Region;

  @doc("The subdomain of the instance")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]*$")
  @minLength(1)
  @maxLength(30)
  subdomain: string;
}

/** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
 * BaseResourceProperties contains Marketplace, useDetail related properties*/
@doc("Properties specific to Instance")
model InstanceProperties is BaseResourceProperties {
  @doc("partner properties")
  partnerProperties?: PartnerProperties;

  @doc("Single sign-on properties")
  singleSignOnProperties?: SingleSignOnPropertiesV2;
}

model InstanceResource
  is Azure.ResourceManager.TrackedResource<InstanceProperties> {
  @key("instancename")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("instances")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Instance resource")
  @path
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * The type used for update operations of the Instance Resource.
 */
model InstanceResourceUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Instances {
  get is ArmResourceRead<InstanceResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InstanceResource>;
  update is ArmCustomPatchSync<InstanceResource, InstanceResourceUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<InstanceResource>;
  listByResourceGroup is ArmResourceListByParent<InstanceResource>;
  listBySubscription is ArmListBySubscription<InstanceResource>;
}
