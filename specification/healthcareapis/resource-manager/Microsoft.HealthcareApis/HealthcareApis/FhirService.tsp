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
 * The description of Fhir Service
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Workspace)
model FhirService
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<FhirServiceProperties> {
  ...ResourceNameParameter<
    Resource = FhirService,
    KeyName = "fhirServiceName",
    SegmentName = "fhirservices",
    NamePattern = ""
  >;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  ...ServiceManagedIdentity;

  /**
   * The kind of the service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: FhirServiceKind;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface FhirServices {
  /**
   * Gets the properties of the specified FHIR Service.
   */
  get is ArmResourceRead<FhirService, Error = ErrorDetails>;

  /**
   * Creates or updates a FHIR Service resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FhirService,
    Response = ArmResourceUpdatedResponse<FhirService> | ArmResourceCreatedResponse<
      FhirService,
      ArmLroLocationHeader<FinalResult = FhirService> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: FhirService;
    }),
    Error = ErrorDetails
  >;

  /**
   * Lists all FHIR Services for the given workspace
   */
  listByWorkspace is ArmResourceListByParent<
    FhirService,
    Response = ArmResponse<FhirServiceCollection>,
    Error = ErrorDetails
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FhirServiceOperationGroup {
  /**
   * Patch FHIR Service details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/fhirservices/{fhirServiceName}")
  @patch(#{ implicitOptionality: false })
  @tag("FhirServices")
  update(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of FHIR Service resource. */
    @path
    @minLength(3)
    @maxLength(24)
    fhirServiceName: string,

    /** The name of workspace resource. */
    @path
    @minLength(3)
    @maxLength(24)
    workspaceName: string,

    /** The parameters for updating a FHIR Service. */
    @body
    fhirservicePatchResource: FhirServicePatchResource,
  ): ArmResponse<FhirService> | (ArmAcceptedLroResponse<
    "Resource update request accepted.",
    LroHeaders = ArmLroLocationHeader<FinalResult = FhirService> &
      Azure.Core.Foundations.RetryAfterHeader
  > & {
    @bodyRoot
    _: FhirService;
  }) | ErrorDetails;

  /**
   * Deletes a FHIR Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/fhirservices/{fhirServiceName}")
  @delete
  @tag("FhirServices")
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of FHIR Service resource. */
    @path
    @minLength(3)
    @maxLength(24)
    fhirServiceName: string,

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

@@maxLength(FhirService.name, 24);
@@minLength(FhirService.name, 3);
@@doc(FhirService.name, "The name of FHIR Service resource.");
@@doc(FhirService.properties, "Fhir Service configuration.");
@@doc(FhirServices.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a Fhir Service resource."
);
