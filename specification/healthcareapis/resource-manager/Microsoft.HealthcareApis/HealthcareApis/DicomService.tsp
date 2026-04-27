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
 * The description of Dicom Service
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Workspace)
model DicomService
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<DicomServiceProperties> {
  ...ResourceNameParameter<
    Resource = DicomService,
    KeyName = "dicomServiceName",
    SegmentName = "dicomservices",
    NamePattern = ""
  >;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  ...ServiceManagedIdentity;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DicomServices {
  /**
   * Gets the properties of the specified DICOM Service.
   */
  get is ArmResourceRead<DicomService, Error = ErrorDetails>;

  /**
   * Creates or updates a DICOM Service resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DicomService,
    Response = ArmResourceUpdatedResponse<DicomService> | ArmResourceCreatedResponse<
      DicomService,
      ArmLroLocationHeader<FinalResult = DicomService> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DicomService;
    }),
    Error = ErrorDetails
  >;

  /**
   * Lists all DICOM Services for the given workspace
   */
  listByWorkspace is ArmResourceListByParent<
    DicomService,
    Response = ArmResponse<DicomServiceCollection>,
    Error = ErrorDetails
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DicomServiceOperationGroup {
  /**
   * Patch DICOM Service details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/dicomservices/{dicomServiceName}")
  @patch(#{ implicitOptionality: false })
  @tag("DicomServices")
  update(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of DICOM Service resource. */
    @path
    @minLength(3)
    @maxLength(24)
    dicomServiceName: string,

    /** The name of workspace resource. */
    @path
    @minLength(3)
    @maxLength(24)
    workspaceName: string,

    /** The parameters for updating a Dicom Service. */
    @body
    dicomservicePatchResource: DicomServicePatchResource,
  ): ArmResponse<DicomService> | (ArmAcceptedLroResponse<
    "Resource update request accepted.",
    LroHeaders = ArmLroLocationHeader<FinalResult = DicomService> &
      Azure.Core.Foundations.RetryAfterHeader
  > & {
    @bodyRoot
    _: DicomService;
  }) | ErrorDetails;

  /**
   * Deletes a DICOM Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareApis/workspaces/{workspaceName}/dicomservices/{dicomServiceName}")
  @delete
  @tag("DicomServices")
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of DICOM Service resource. */
    @path
    @minLength(3)
    @maxLength(24)
    dicomServiceName: string,

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

@@maxLength(DicomService.name, 24);
@@minLength(DicomService.name, 3);
@@doc(DicomService.name, "The name of DICOM Service resource.");
@@doc(DicomService.properties, "Dicom Service configuration.");
@@doc(DicomServices.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a Dicom Service resource."
);
