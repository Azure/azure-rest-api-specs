import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;

/**
 * Private endpoint connection resource, parented under Domain.
 * Also used as shared property type across Domain, Topic, PartnerNamespace, Namespace.
 */
@parentResource(Domain)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

// Interface named "PrivateEndpointConnections" to satisfy back-compatible.tsp reference
@armResourceOperations
interface PrivateEndpointConnections {
  get is ArmResourceRead<PrivateEndpointConnection>;

  @put
  update(
    ...ResourceInstanceParameters<PrivateEndpointConnection>,
    @doc("The private endpoint connection object to update.")
    @bodyRoot
    body: PrivateEndpointConnection
  ): ArmResponse<PrivateEndpointConnection> | ArmResourceCreatedResponse<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  listByResource is ArmResourceListByParent<
    PrivateEndpointConnection,
    Parameters = {
      @query("$filter")
      $filter?: string;
      @query("$top")
      $top?: int32;
    }
  >;
}

@parentResource(Topic)
model TopicPrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = TopicPrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TopicPrivateEndpointConnections {
  get is ArmResourceRead<TopicPrivateEndpointConnection>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TopicPrivateEndpointConnection>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    TopicPrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
  listByResource is ArmResourceListByParent<
    TopicPrivateEndpointConnection,
    Parameters = {
      @query("$filter")
      $filter?: string;
      @query("$top")
      $top?: int32;
    }
  >;
}

@parentResource(PartnerNamespace)
model PartnerNamespacePrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PartnerNamespacePrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PartnerNamespacePrivateEndpointConnections {
  get is ArmResourceRead<PartnerNamespacePrivateEndpointConnection>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PartnerNamespacePrivateEndpointConnection>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PartnerNamespacePrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
  listByResource is ArmResourceListByParent<
    PartnerNamespacePrivateEndpointConnection,
    Parameters = {
      @query("$filter")
      $filter?: string;
      @query("$top")
      $top?: int32;
    }
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection connection."
);
@@doc(PrivateEndpointConnection.properties,
  "Properties of the PrivateEndpointConnection."
);
@@doc(PrivateEndpointConnections.update::parameters.body,
  "The private endpoint connection object to update."
);