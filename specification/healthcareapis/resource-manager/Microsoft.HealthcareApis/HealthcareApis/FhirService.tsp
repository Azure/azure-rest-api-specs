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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * The kind of the service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: FhirServiceKind;
}

@armResourceOperations
interface FhirServices {
  /**
   * Gets the properties of the specified FHIR Service.
   */
  get is ArmResourceRead<FhirService, Error = ErrorDetails>;

  /**
   * Creates or updates a FHIR Service resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
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
   * Patch FHIR Service details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    FhirService,
    PatchModel = FhirServicePatchResource,
    Response = ArmResponse<FhirService> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: FhirService;
    }),
    Error = ErrorDetails
  >;

  /**
   * Deletes a FHIR Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    FhirService,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
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

@@maxLength(FhirService.name, 24);
@@minLength(FhirService.name, 3);
@@doc(FhirService.name, "The name of FHIR Service resource.");
@@doc(FhirService.properties, "Fhir Service configuration.");
@@doc(FhirServices.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a Fhir Service resource."
);
@@doc(FhirServices.update::parameters.properties,
  "The parameters for updating a Fhir Service."
);
