import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Databricks;
/**
 * Peerings in a VirtualNetwork resource
 */
@parentResource(Workspace)
model VirtualNetworkPeering
  is Azure.ResourceManager.ProxyResource<
    VirtualNetworkPeeringPropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = VirtualNetworkPeering,
    KeyName = "peeringName",
    SegmentName = "virtualNetworkPeerings",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface VirtualNetworkPeerings {
  /**
   * Gets the workspace vNet Peering.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("vNetPeering")
  @operationId("vNetPeering_Get")
  get is ArmResourceRead<
    VirtualNetworkPeering,
    Response = ArmResponse<VirtualNetworkPeering> | ArmNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Creates vNet Peering for workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("vNetPeering")
  @operationId("vNetPeering_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkPeering,
    LroHeaders = ArmLroLocationHeader<FinalResult = VirtualNetworkPeering> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Deletes the workspace vNetPeering.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @tag("vNetPeering")
  @operationId("vNetPeering_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkPeering,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists the workspace vNet Peerings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("vNetPeering")
  @operationId("vNetPeering_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<
    VirtualNetworkPeering,
    Response = ArmResponse<VirtualNetworkPeeringList>,
    Error = ErrorResponse
  >;
}

@@doc(VirtualNetworkPeering.name, "The name of the workspace vNet peering.");
@@doc(VirtualNetworkPeering.properties, "List of properties for vNet Peering");
@@doc(VirtualNetworkPeerings.createOrUpdate::parameters.resource,
  "Parameters supplied to the create workspace vNet Peering."
);
