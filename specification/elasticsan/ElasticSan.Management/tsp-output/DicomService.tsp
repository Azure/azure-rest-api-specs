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
@doc("The description of Dicom Service")
@parentResource(Workspace)
model DicomService is TrackedResource<DicomServiceProperties> {
  @doc("The name of DICOM Service resource.")
  @maxLength(24)
  @minLength(3)
  @path
  @key("dicomServiceName")
  @segment("dicomservices")
  name: string;
}

@armResourceOperations
interface DicomServices {
  @doc("Gets the properties of the specified DICOM Service.")
  get is ArmResourceRead<DicomService>;

  @doc("Creates or updates a DICOM Service resource with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DicomService>;

  @doc("Patch DICOM Service details.")
  update is ArmCustomPatchAsync<DicomService, DicomServicePatchResource>;

  @doc("Deletes a DICOM Service.")
  delete is ArmResourceDeleteAsync<DicomService>;

  @doc("Lists all DICOM Services for the given workspace")
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
