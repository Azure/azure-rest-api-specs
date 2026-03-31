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

namespace Microsoft.HealthcareApis;
/**
 * IoT Connector definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Workspace)
model IotConnector
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<IotConnectorProperties> {
  ...ResourceNameParameter<
    Resource = IotConnector,
    KeyName = "iotConnectorName",
    SegmentName = "iotconnectors",
    NamePattern = ""
  >;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  ...ServiceManagedIdentity;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface IotConnectors {
  /**
   * Gets the properties of the specified IoT Connector.
   */
  get is ArmResourceRead<IotConnector, Error = ErrorDetails>;

  /**
   * Creates or updates an IoT Connector resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IotConnector,
    Response = ArmResourceUpdatedResponse<IotConnector> | ArmResourceCreatedResponse<
      IotConnector,
      ArmLroLocationHeader<FinalResult = IotConnector> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: IotConnector;
    }),
    Error = ErrorDetails
  >;

  /**
   * Lists all IoT Connectors for the given workspace
   */
  listByWorkspace is ArmResourceListByParent<
    IotConnector,
    Response = ArmResponse<IotConnectorCollection>,
    Error = ErrorDetails
  >;
}

@@maxLength(IotConnector.name, 24);
@@minLength(IotConnector.name, 3);
@@doc(IotConnector.name, "The name of IoT Connector resource.");
@@doc(IotConnector.properties, "IoT Connector configuration.");
@@doc(IotConnectors.createOrUpdate::parameters.resource,
  "The parameters for creating or updating an IoT Connectors resource."
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface IotConnectorOperationGroup {
  /**
   * Patch an IoT Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}")
  @patch(#{ implicitOptionality: false })
  @tag("IotConnectors")
  update(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of IoT Connector resource. */
    @path
    @minLength(3)
    @maxLength(24)
    iotConnectorName: string,

    /** The name of workspace resource. */
    @path
    @minLength(3)
    @maxLength(24)
    workspaceName: string,

    /** The parameters for updating an IoT Connector. */
    @body
    iotConnectorPatchResource: IotConnectorPatchResource,
  ): ArmResponse<IotConnector> | (ArmAcceptedLroResponse<
    "Resource update request accepted.",
    LroHeaders = ArmLroLocationHeader<FinalResult = IotConnector> &
      Azure.Core.Foundations.RetryAfterHeader
  > & {
    @bodyRoot
    _: IotConnector;
  }) | ErrorDetails;

  /**
   * Deletes an IoT Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/iotconnectors/{iotConnectorName}")
  @delete
  @tag("IotConnectors")
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of IoT Connector resource. */
    @path
    @minLength(3)
    @maxLength(24)
    iotConnectorName: string,

    /** The name of workspace resource. */
    @path
    @minLength(3)
    @maxLength(24)
    workspaceName: string,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | Error;
}
