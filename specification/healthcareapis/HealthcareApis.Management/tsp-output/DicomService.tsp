import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
/**
 * The description of Dicom Service
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workspace)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(DicomServiceProperties)
model DicomService extends TrackedResourceBase {
  /**
   * The name of DICOM Service resource.
   */
  @maxLength(24)
  @minLength(3)
  @path
  @key("dicomServiceName")
  @segment("dicomservices")
  @visibility("read")
  name: string;

  /**
   * Dicom Service configuration.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DicomServiceProperties;
}

@armResourceOperations
interface DicomServices {
  /**
   * Gets the properties of the specified DICOM Service.
   */
  get is ArmResourceRead<DicomService>;

  /**
   * Creates or updates a DICOM Service resource with the specified parameters.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DicomService>;

  /**
   * Patch DICOM Service details.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<DicomService, DicomServicePatchResource>;

  /**
   * Deletes a DICOM Service.
   */
  delete is ArmResourceDeleteAsync<DicomService>;

  /**
   * Lists all DICOM Services for the given workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DicomServices_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<DicomService>;
}

@@projectedName(DicomServices.createOrUpdate::parameters.resource,
  "json",
  "dicomservice"
);
@@extension(DicomServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "dicomservice"
);
@@doc(DicomServices.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a Dicom Service resource."
);
@@projectedName(DicomServices.update::parameters.properties,
  "json",
  "dicomservicePatchResource"
);
@@extension(DicomServices.update::parameters.properties,
  "x-ms-client-name",
  "dicomservicePatchResource"
);
@@doc(DicomServices.update::parameters.properties,
  "The parameters for updating a Dicom Service."
);
