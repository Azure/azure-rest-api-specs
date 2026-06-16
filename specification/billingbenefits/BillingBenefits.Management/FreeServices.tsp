// FreeServices.tsp content
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * Free Services resource definition
 */
model FreeServices
  is Azure.ResourceManager.TrackedResource<FreeServicesProperties> {
  ...ResourceNameParameter<
    Resource = FreeServices,
    KeyName = "freeServiceName",
    SegmentName = "freeServices",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;

  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedBy?: string;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type. E.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  /**
   * The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * The resource model definition representing SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Plan for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  plan?: Plan;
}

@armResourceOperations
interface FreeServicesOperations {
  /**
   * This operation retrieves properties for free services.
   */
  get is ArmResourceRead<FreeServices>;

  /**
   * This operation creates or updates free services in Azure
   */
  create is ArmResourceCreateOrReplaceAsync<FreeServices>;

  /**
   * This operation updates free services in Azure.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    FreeServices,
    PatchModel = FreeServicesPatchRequest,
    Response = ArmResponse<FreeServices> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = FreeServices> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * This operation deletes free services from the subscription. Only free services that are in an expired or cancelled states can be deleted.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    FreeServices,
    Response = (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> &
      Azure.Core.Foundations.RetryAfterHeader) | (NoContentResponse &
      ArmAsyncOperationHeader)
  >;

  /**
   * This operation lists the free services that are available under the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    FreeServices,
    Response = ArmResponse<FreeServicesList>
  >;

  /**
   * This operation lists free services that are available under the specified subscription.
   */
  listBySubscription is ArmListBySubscription<
    FreeServices,
    Response = ArmResponse<FreeServicesList>
  >;
}

@@doc(FreeServices.name, "Name of the free service");
@@doc(FreeServices.properties, "Free services properties");
@@doc(FreeServicesOperations.create::parameters.resource,
  "Free services create request"
);
@@doc(FreeServicesOperations.update::parameters.properties,
  "Free services patch request"
);
