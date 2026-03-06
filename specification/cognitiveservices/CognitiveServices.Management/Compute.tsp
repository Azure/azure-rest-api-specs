import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;

/**
 * Cognitive Services compute cluster resource.
 */
@parentResource(Account)
model Compute is Azure.ResourceManager.ProxyResource<ComputeProperties, false> {
  ...ResourceNameParameter<
    Resource = Compute,
    KeyName = "computeName",
    SegmentName = "computes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface Computes {
  /**
   * Gets the specified compute associated with the Cognitive Services account.
   */
  @tag("CognitiveServicesComputes")
  get is ArmResourceRead<Compute>;

  /**
   * Creates or updates a compute associated with the Cognitive Services account.
   */
  @tag("CognitiveServicesComputes")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Compute>;

  /**
   * Updates a compute associated with the Cognitive Services account.
   */
  @tag("CognitiveServicesComputes")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Compute, PatchModel = ComputePatch>;

  /**
   * Deletes the specified compute associated with the Cognitive Services account.
   */
  @tag("CognitiveServicesComputes")
  delete is ArmResourceDeleteWithoutOkAsync<Compute>;

  /**
   * Gets the computes associated with the Cognitive Services account.
   */
  @tag("CognitiveServicesComputes")
  list is ArmResourceListByParent<Compute, Response = ComputeListResult>;
}

@@maxLength(Compute.name, 64);
@@minLength(Compute.name, 2);
@@doc(Compute.name, "The name of the compute associated with the Cognitive Services Account.");
@@doc(Compute.properties, "Properties of Cognitive Services compute.");
@@doc(Computes.createOrUpdate::parameters.resource, "The compute properties.");
@@doc(Computes.update::parameters.properties, "The compute properties.");
