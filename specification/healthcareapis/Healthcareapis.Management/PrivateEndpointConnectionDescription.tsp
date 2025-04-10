import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServicesDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
// FIXME: PrivateEndpointConnectionDescription has no properties property
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(ServicesDescription)
model PrivateEndpointConnectionDescription
  is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionDescription,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionDescriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ServicesDescription,
          KeyName = "resourceName",
          SegmentName = "services",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PrivateEndpointConnectionDescription,
        KeyName = "privateEndpointConnectionName",
        SegmentName = "privateEndpointConnections",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PrivateEndpointConnectionDescriptions {
  /**
   * Gets the specified private endpoint connection associated with the service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnections_Get")
  get is PrivateEndpointConnectionDescriptionOps.Read<PrivateEndpointConnectionDescription>;

  /**
   * Update the state of the specified private endpoint connection associated with the service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PrivateEndpointConnections_CreateOrUpdate")
  createOrUpdate is PrivateEndpointConnectionDescriptionOps.CreateOrUpdateAsync<
    PrivateEndpointConnectionDescription,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnectionDescription>,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("PrivateEndpointConnections_Delete")
  delete is PrivateEndpointConnectionDescriptionOps.DeleteWithoutOkAsync<
    PrivateEndpointConnectionDescription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all private endpoint connections for a service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateEndpointConnections_ListByService")
  listByService is PrivateEndpointConnectionDescriptionOps.List<
    PrivateEndpointConnectionDescription,
    Response = ArmResponse<PrivateEndpointConnectionListResultDescription>
  >;
}
@armResourceOperations
interface WorkspacePrivateEndpointConnectionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workspace,
          KeyName = "workspaceName",
          SegmentName = "workspaces",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PrivateEndpointConnectionDescription,
        KeyName = "privateEndpointConnectionName",
        SegmentName = "privateEndpointConnections",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface WorkspacePrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the workspace.
   */
  get is WorkspacePrivateEndpointConnectionOps.Read<PrivateEndpointConnectionDescription>;

  /**
   * Update the state of the specified private endpoint connection associated with the workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is WorkspacePrivateEndpointConnectionOps.CreateOrUpdateAsync<
    PrivateEndpointConnectionDescription,
    Response = ArmResourceUpdatedResponse<PrivateEndpointConnectionDescription>,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is WorkspacePrivateEndpointConnectionOps.DeleteWithoutOkAsync<
    PrivateEndpointConnectionDescription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all private endpoint connections for a workspace.
   */
  listByWorkspace is WorkspacePrivateEndpointConnectionOps.List<
    PrivateEndpointConnectionDescription,
    Response = ArmResponse<PrivateEndpointConnectionListResultDescription>
  >;
}

@@doc(PrivateEndpointConnectionDescription.name,
  "The name of the private endpoint connection associated with the Azure resource"
);
@@doc(PrivateEndpointConnectionDescriptions.createOrUpdate::parameters.resource,
  "The private endpoint connection properties."
);
@@doc(WorkspacePrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection properties."
);
