import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * ExpressRoutePort resource definition.
 */
@summary("ExpressRoute Port")
model ExpressRoutePort
  is Azure.ResourceManager.ProxyResource<ExpressRoutePortPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ExpressRoutePort,
    KeyName = "expressRoutePortName",
    SegmentName = "ExpressRoutePorts",
    NamePattern = ""
  >;

  /** Resource tags. */
  tags: TagsObject;

  /**
   * Resource location.
   */
  location: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The identity of ExpressRoutePort, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

alias ExpressRouteLinkOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the express route port. */
    @path
    @segment("ExpressRoutePorts")
    @key
    expressRoutePortName: string;
  },
  {
    /** The name of the express route link. */
    @path
    @segment("links")
    @key
    linkName: string;
  }
>;

@armResourceOperations
interface ExpressRoutePorts {
  /**
   * Retrieves the requested ExpressRoutePort resource.
   */
  get is ArmResourceRead<ExpressRoutePort, Error = CloudError>;

  /**
   * Creates or updates the specified ExpressRoutePort resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRoutePort,
    Error = CloudError
  >;

  /**
   * Update ExpressRoutePort tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ExpressRoutePort,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified ExpressRoutePort resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRoutePort,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * List all the ExpressRoutePort resources in the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ExpressRoutePort,
    Response = ExpressRoutePortListResult,
    Error = CloudError
  >;

  /**
   * List all the ExpressRoutePort resources in the specified subscription.
   */
  list is ArmListBySubscription<
    ExpressRoutePort,
    Response = ExpressRoutePortListResult,
    Error = CloudError
  >;

  /**
   * Generate a letter of authorization for the requested ExpressRoutePort resource.
   */
  @action("generateLoa")
  generateLOA is ArmResourceActionSync<
    ExpressRoutePort,
    GenerateExpressRoutePortsLOARequest,
    ArmResponse<GenerateExpressRoutePortsLOAResult>,
    Error = CloudError
  >;

  /**
   * Retrieves the specified ExpressRouteLink resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteLinks_Get")
  @get
  expressRouteLinksGet is ExpressRouteLinkOps.Read<
    ExpressRoutePort,
    Response = ArmResponse<ExpressRouteLink>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieve the ExpressRouteLink sub-resources of the specified ExpressRoutePort resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteLinks_List")
  @list
  @get
  expressRouteLinksList is ExpressRouteLinkOps.List<
    ExpressRoutePort,
    Response = ArmResponse<ExpressRouteLinkListResult>,
    OverrideErrorType = CloudError
  >;
}

@@doc(ExpressRoutePort.name, "The name of ExpressRoutePort.");
@@doc(ExpressRoutePort.properties, "ExpressRoutePort properties.");
@@doc(ExpressRoutePorts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create ExpressRoutePort operation."
);
@@doc(ExpressRoutePorts.updateTags::parameters.properties,
  "Parameters supplied to update ExpressRoutePort resource tags."
);
@@doc(ExpressRoutePorts.generateLOA::parameters.body,
  "Request parameters supplied to generate a letter of authorization."
);
