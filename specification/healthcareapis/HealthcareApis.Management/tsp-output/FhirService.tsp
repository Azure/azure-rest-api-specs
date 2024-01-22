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
 * The description of Fhir Service
 */
@parentResource(Workspace)
model FhirService is TrackedResource<FhirServiceProperties> {
  /**
   * The name of FHIR Service resource.
   */
  @maxLength(24)
  @minLength(3)
  @path
  @key("fhirServiceName")
  @segment("fhirservices")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface FhirServices {
  /**
   * Gets the properties of the specified FHIR Service.
   */
  get is ArmResourceRead<FhirService>;

  /**
   * Creates or updates a FHIR Service resource with the specified parameters.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FhirService>;

  /**
   * Patch FHIR Service details.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<FhirService, FhirServicePatchResource>;

  /**
   * Deletes a FHIR Service.
   */
  delete is ArmResourceDeleteAsync<FhirService>;

  /**
   * Lists all FHIR Services for the given workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FhirServices_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<FhirService>;
}

@@projectedName(FhirServices.createOrUpdate::parameters.resource,
  "json",
  "fhirservice"
);
@@extension(FhirServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "fhirservice"
);
@@doc(FhirServices.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a Fhir Service resource."
);
@@projectedName(FhirServices.update::parameters.properties,
  "json",
  "fhirservicePatchResource"
);
@@extension(FhirServices.update::parameters.properties,
  "x-ms-client-name",
  "fhirservicePatchResource"
);
@@doc(FhirServices.update::parameters.properties,
  "The parameters for updating a Fhir Service."
);
