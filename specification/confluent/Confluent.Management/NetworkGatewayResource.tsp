import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./SCEnvironmentRecord.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Confluent;
/**
 * Details of network gateway record
 */
@added(Microsoft.Confluent.Versions.v2026_05_01_preview)
@parentResource(SCEnvironmentRecord)
model NetworkGatewayResource is ProxyResource<NetworkGatewayProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkGatewayResource,
    KeyName = "networkGatewayId",
    SegmentName = "networkGateways",
    NamePattern = ""
  >;
}

@added(Microsoft.Confluent.Versions.v2026_05_01_preview)
@armResourceOperations
interface NetworkGatewayResources {
  /**
   * Get confluent network gateway by Id
   */
  get is ArmResourceRead<
    NetworkGatewayResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create or replace a confluent network gateway
   */
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    NetworkGatewayResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Delete confluent network gateway by id
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkGatewayResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Lists all network gateways in an environment
   */
  list is ArmResourceListByParent<
    NetworkGatewayResource,
    Error = ResourceProviderDefaultErrorResponse
  >;
}

@@doc(NetworkGatewayResource.name, "Confluent network gateway id");
@@doc(NetworkGatewayResource.properties, "Network Gateway Properties");
@@doc(NetworkGatewayResources.createOrReplace::parameters.resource,
  "Confluent Network Gateway resource model"
);
