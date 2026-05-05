import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Cognitive Services compute cluster resource.
 */
@added(Versions.v2026_01_15_preview)
@parentResource(Account)
model Compute is Azure.ResourceManager.ProxyResource<ComputeProperties, false> {
  ...ResourceNameParameter<
    Resource = Compute,
    KeyName = "computeName",
    SegmentName = "computes",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9_-]*[a-zA-Z0-9])?$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The location of the compute resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<tags> type used for 'Compute' to support extensible key-value pairs matching service behavior"
  tags?: Record<string>;

  /**
   * The kind (type) of compute resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface Computes {
  /**
   * Gets the specified compute associated with the Cognitive Services account.
   */
  @tag("Computes")
  get is ArmResourceRead<Compute>;

  /**
   * Creates or updates a compute associated with the Cognitive Services account.
   */
  @tag("Computes")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Compute>;

  /**
   * Updates a compute associated with the Cognitive Services account.
   */
  @tag("Computes")
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<Compute, PatchModel = Compute>;

  /**
   * Deletes the specified compute associated with the Cognitive Services account.
   */
  @tag("Computes")
  delete is ArmResourceDeleteWithoutOkAsync<Compute>;

  /**
   * Gets the computes associated with the Cognitive Services account.
   */
  @tag("Computes")
  list is ArmResourceListByParent<Compute, Response = ComputeListResult>;
}

@@maxLength(Compute.name, 63);
@@minLength(Compute.name, 1);
@@doc(Compute.name,
  "The name of the compute associated with the Cognitive Services Account."
);
@@doc(Compute.properties, "Properties of Cognitive Services compute.");
@@doc(Computes.createOrUpdate::parameters.resource, "The compute properties.");
@@doc(Computes.update::parameters.properties,
  "The compute properties to update."
);
