import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
/**
 * The description of the service.
 */
model ServicesDescription
  is Azure.ResourceManager.TrackedResource<ServicesProperties> {
  ...ResourceNameParameter<
    Resource = ServicesDescription,
    KeyName = "resourceName",
    SegmentName = "services",
    NamePattern = ""
  >;

  /**
   * The kind of the service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind: Kind;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * Setting indicating whether the service has a managed identity associated with it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ServicesResourceIdentity;
}

@armResourceOperations(#{ omitTags: true })
interface ServicesDescriptions {
  /**
   * Get the metadata of a service instance.
   */
  @tag("Resource")
  get is ArmResourceRead<ServicesDescription, Error = ErrorDetails>;

  /**
   * Create or update the metadata of a service instance.
   */
  @tag("Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServicesDescription,
    LroHeaders = ArmLroLocationHeader<FinalResult = ServicesDescription> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorDetails
  >;

  /**
   * Update the metadata of a service instance.
   */
  @tag("Resource")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ServicesDescription,
    PatchModel = ServicesPatchDescription,
    Response = ArmResponse<ServicesDescription> &
      ArmLroLocationHeader<FinalResult = ServicesDescription> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorDetails
  >;

  /**
   * Delete a service instance.
   */
  @tag("Resource")
  delete is ArmResourceDeleteWithoutOkAsync<
    ServicesDescription,
    Error = ErrorDetails
  >;

  /**
   * Get all the service instances in a resource group.
   */
  @tag("Collection")
  listByResourceGroup is ArmResourceListByParent<
    ServicesDescription,
    Error = ErrorDetails
  >;

  /**
   * Get all the service instances in a subscription.
   */
  @tag("Collection")
  list is ArmListBySubscription<ServicesDescription, Error = ErrorDetails>;
}

@@maxLength(ServicesDescription.name, 24);
@@minLength(ServicesDescription.name, 3);
@@doc(ServicesDescription.name, "The name of the service instance.");
@@doc(ServicesDescription.properties, "The common properties of a service.");
@@doc(ServicesDescriptions.createOrUpdate::parameters.resource,
  "The service instance metadata."
);
@@doc(ServicesDescriptions.update::parameters.properties,
  "The service instance metadata and security metadata."
);
