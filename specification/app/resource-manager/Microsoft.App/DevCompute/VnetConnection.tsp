import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./SandboxGroup.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;

/** A virtual network connection associated with a SandboxGroup. */
@parentResource(SandboxGroup)
model VnetConnection is ProxyResource<VnetConnectionProperties> {
  ...ResourceNameParameter<
    Resource = VnetConnection,
    KeyName = "vnetConnectionName",
    SegmentName = "vnetConnections",
    NamePattern = "^(?![.-])[A-Za-z0-9-]{1,32}$"
  >;
}

/** VnetConnection resource specific properties. */
model VnetConnectionProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Description is on the referenced type to avoid emitting a sibling of $ref."
  @visibility(Lifecycle.Read)
  provisioningState?: VnetConnectionProvisioningState;

  /** Resource ID of the subnet that sandboxes in the parent SandboxGroup will be connected to. */
  subnetId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

/** Provisioning state of the VnetConnection. */
@lroStatus
union VnetConnectionProvisioningState {
  string,
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  InProgress: "InProgress",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}

@armResourceOperations
interface VnetConnections {
  /** Get the properties of a VnetConnection. */
  get is ArmResourceRead<VnetConnection>;

  /** Create or update a VnetConnection. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VnetConnection>;

  /** Delete a VnetConnection. */
  delete is ArmResourceDeleteWithoutOkAsync<
    VnetConnection,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /** List all VnetConnections in the specified SandboxGroup. */
  listBySandboxGroup is ArmResourceListByParent<VnetConnection>;
}
