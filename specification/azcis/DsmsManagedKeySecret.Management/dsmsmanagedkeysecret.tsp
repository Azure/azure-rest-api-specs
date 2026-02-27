import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("dsmsManagedKeySecret properties")
model DsmsManagedKeySecretResourceProperties {
  @doc("ARM resource id.")
  armResourceId: string; // Camel case for the parameter names.

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  @doc("Managed Key subtype. Used to determine which way to store the secret in dSMS. Acceptable values (case sensitive): 'Password', 'ConnectionString'. Optional, 'Password' by default.")
  managedKeySubType: "Password" | "ConnectionString" | string;

  @doc("Defines in which region of dSMS to provision the Managed Key Secret, (ex. uswest-dsms.dsms.%(HostNameSuffix)). Used only when provisioning Managed Key Secret in non-home-dsms endpoint.")
  dsmsDns?: string;

  @doc("dSMS root path. Required if full Managed Key Name not provided.")
  rootFolder?: string;

  @doc("Managed Key Name in dSMS. This is the full path to the resource in dSMS.")
  managedKeyName?: string;

  @doc("Set to True to disable automatic secret rotation by dSMS. Optional, False by default.")
  blockAutoRollover?: boolean;

  @doc("Defines how often the secret will be rolled over by dSMS. Optional, 90 by default.")
  customRolloverPeriodDays?: int32;

  @doc("Defines the ARM region where the resource exists for global managed keys.")
  armResourceLocation?: string;

  @doc("Scope of replication for the global managed key. Optional, 'Local' by default. Acceptable values: 'Local', 'AllDsmsRegions', 'SpecifiedDsmsRegions', 'ExcludedDsmsRegions'.")
  replicationScope?: ReplicationScope;

  @doc("dSMS region to sync the global managed key to.")
  replicateTo?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  @doc("Properties can be used to save customer key-value pairs associated with the dSMS secrets. Optional.")
  @Azure.ResourceManager.identifiers(#[])
  properties?: Array<PropertyElement>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: DsmsManagedKeySecretProvisioningState;
}

@doc("Replication Scope of dSMS secret.")
union ReplicationScope {
  @doc("This secret is not replicated to other dSMS instances.")
  Local: "Local",

  @doc("This secret can be replicated to all dSMS instances.")
  AllDsmsRegions: "AllDsmsRegions",

  @doc("This secret can only be replicated to the specified dSMS instances.")
  SpecifiedDsmsRegions: "SpecifiedDsmsRegions",

  @doc("This secret can only be replicated to non-specified dSMS instances.")
  ExcludedDsmsRegions: "ExcludedDsmsRegions",

  string,
}

@doc("Property element model.")
model PropertyElement {
  @doc("The name of the property.")
  name: string;

  @doc("The value of the property.")
  value: string;
}

@doc("dsmsManagedKeySecret Resource")
model DsmsManagedKeySecretResource
  is ProxyResource<DsmsManagedKeySecretResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]*$")
  @minLength(3)
  @maxLength(80)
  @key("resourceName")
  @segment("dsmsManagedKeySecrets") // Start with lower case. Should be plural.
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@armResourceOperations
interface DsmsManagedKeySecret {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DsmsManagedKeySecretResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  listBySubscription is ArmListBySubscription<DsmsManagedKeySecretResource>;
  listByResourceGroup is ArmResourceListByParent<DsmsManagedKeySecretResource>;
  get is ArmResourceRead<DsmsManagedKeySecretResource>;
}

@@visibility(DsmsManagedKeySecretResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
