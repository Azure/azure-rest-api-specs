import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace CloudInventoryApi;

/**
 * The Cloud Inventory extension resource published to Azure Resource Graph (RP Lite, read-only).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "The cloudInventory resource is an extension resource addressable across multiple scopes via a resourceId path parameter."
@extensionResource
model CloudInventory
  is Azure.ResourceManager.ExtensionResource<CloudInventoryProperties> {
  ...ResourceNameParameter<
    Resource = CloudInventory,
    KeyName = "cloudInventoryName",
    SegmentName = "cloudInventory",
    NamePattern = "^default$"
  >;
}

alias CloudInventoryOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource Manager identifier of the extended resource. */
    @path(#{ allowReserved: true })
    @key
    @minLength(1)
    resourceId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** The Cloud Inventory resource name (singleton 'default'). */
    @path
    @segment("cloudInventory")
    @key
    @pattern("^default$")
    cloudInventoryName: CloudInventoryName;
  }
>;

@armResourceOperations
interface CloudInventories {
  /**
   * Get the Cloud Inventory record for a given resource.
   */
  get is CloudInventoryOps.Read<CloudInventory, ErrorType = CloudError>;

  /**
   * List Cloud Inventory records under a target scope (subscription, resource group, securityConnector, or resource).
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    CloudInventory,
    Response = ArmResponse<CloudInventoryList>,
    Error = CloudError
  >;
}

@@minLength(Azure.ResourceManager.Extension.ScopeParameter.scope, 1);
@@doc(
  CloudInventory.name,
  "The Cloud Inventory singleton resource name ('default')."
);
@@doc(
  CloudInventory.properties,
  "Cloud Inventory properties describing the discovered multi-cloud or workload entity."
);
