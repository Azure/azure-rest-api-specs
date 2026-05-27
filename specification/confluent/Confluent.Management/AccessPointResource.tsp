import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./NetworkGatewayResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Confluent;
/**
 * Details of access point record
 */
@added(Microsoft.Confluent.Versions.v2026_05_01_preview)
@parentResource(NetworkGatewayResource)
model AccessPointResource
  is Azure.ResourceManager.ProxyResource<AccessPointProperties> {
  ...ResourceNameParameter<
    Resource = AccessPointResource,
    KeyName = "accessPointId",
    SegmentName = "accessPoints",
    NamePattern = ""
  >;
}

@added(Microsoft.Confluent.Versions.v2026_05_01_preview)
@armResourceOperations
interface AccessPointResources {
  /**
   * Get confluent access point by Id
   */
  get is ArmResourceRead<AccessPointResource>;

  /**
   * Create or replace a confluent access point
   */
  createOrReplace is ArmResourceCreateOrReplaceAsync<AccessPointResource>;

  /**
   * Delete confluent access point by id
   */
  delete is ArmResourceDeleteWithoutOkAsync<AccessPointResource>;

  /**
   * Lists all access points in a network gateway
   */
  list is ArmResourceListByParent<AccessPointResource>;
}

@@doc(AccessPointResource.name, "Confluent access point id");
@@doc(AccessPointResource.properties, "Access Point Properties");
@@doc(
  AccessPointResources.createOrReplace::parameters.resource,
  "Confluent Access Point resource model"
);
