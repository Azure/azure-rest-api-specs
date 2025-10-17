import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.StorageMover;
/**
 * The Endpoint resource, which contains information about file sources and targets.
 */
@parentResource(StorageMover)
model Endpoint
  is Azure.ResourceManager.ProxyResource<EndpointBaseProperties, false> {
  ...ResourceNameParameter<
    Resource = Endpoint,
    KeyName = "endpointName",
    SegmentName = "endpoints",
    NamePattern = ""
  >;

  /**
   * The managed service identity of the resource. This property is only available on the latest version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @added(Versions.v2025_07_01)
  identity?: Foundations.ManagedServiceIdentity;
}

@armResourceOperations
interface Endpoints {
  /**
   * Gets an Endpoint resource.
   */
  get is ArmResourceRead<Endpoint>;

  /**
   * Creates or updates an Endpoint resource, which represents a data transfer source or destination.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Endpoint,
    Response = ArmResourceUpdatedResponse<Endpoint>
  >;

  /**
   * Updates properties for an Endpoint resource. Properties not specified in the request body will be unchanged.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Endpoint,
    PatchModel = EndpointBaseUpdateParameters
  >;

  /**
   * Deletes an Endpoint resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Endpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Endpoints in a Storage Mover.
   */
  list is ArmResourceListByParent<
    Endpoint,
    Response = ArmResponse<EndpointList>
  >;
}

@@doc(Endpoint.name, "The name of the Endpoint resource.");
@@doc(Endpoint.properties,
  "The resource specific properties for the Storage Mover resource."
);
@@doc(Endpoints.createOrUpdate::parameters.resource, "");
@@doc(Endpoints.update::parameters.properties, "");
