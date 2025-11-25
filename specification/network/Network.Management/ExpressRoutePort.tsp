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
model ExpressRoutePort
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ExpressRoutePortPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ExpressRoutePort,
    KeyName = "expressRoutePortName",
    SegmentName = "ExpressRoutePorts",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;

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
  get is ArmResourceRead<ExpressRoutePort>;

  /**
   * Creates or updates the specified ExpressRoutePort resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExpressRoutePort>;

  /**
   * Update ExpressRoutePort tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<ExpressRoutePort, PatchModel = TagsObject>;

  /**
   * Deletes the specified ExpressRoutePort resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRoutePort,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all the ExpressRoutePort resources in the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ExpressRoutePort>;

  /**
   * List all the ExpressRoutePort resources in the specified subscription.
   */
  list is ArmListBySubscription<ExpressRoutePort>;

  /**
   * Generate a letter of authorization for the requested ExpressRoutePort resource.
   */
  @action("generateLoa")
  generateLOA is ArmResourceActionSync<
    ExpressRoutePort,
    GenerateExpressRoutePortsLOARequest,
    ArmResponse<GenerateExpressRoutePortsLOAResult>
  >;

  /**
   * Retrieves the specified ExpressRouteLink resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteLinks_Get")
  @get
  expressRouteLinksGet is ExpressRouteLinkOps.Read<
    ExpressRoutePort,
    Response = ArmResponse<ExpressRouteLink>
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
    Response = ArmResponse<ExpressRouteLinkListResult>
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
