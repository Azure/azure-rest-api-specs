import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SAPDiscoverySite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the SAP Instance resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
@parentResource(SAPDiscoverySite)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SAPInstanceProperties)
model SAPInstance extends TrackedResourceBase {
  /**
   * The name of SAP Instance resource for SAP Migration.
   */
  @pattern("^[A-Za-z][\\w-]*[A-Za-z0-9]$")
  @path
  @key("sapInstanceName")
  @segment("sapInstances")
  @visibility("read")
  name: string;

  /**
   * The SAP Instance resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: SAPInstanceProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
@armResourceOperations
interface SAPInstances {
  /**
   * Gets the SAP Instance resource.
   */
  get is ArmResourceRead<SAPInstance>;

  /**
   * Creates the SAP Instance resource. <br><br>This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<
    SAPInstance,
    BaseParameters<SAPInstance>,
    ArmLroLocationHeader
  >;

  /**
   * Updates the SAP Instance resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    SAPInstance,
    UpdateSAPInstanceRequest,
    BaseParameters<SAPInstance>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes the SAP Instance resource. <br><br>This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the SAP Migration discovery site resource, using the delete operation on it.
   */
  delete is ArmResourceDeleteAsync<
    SAPInstance,
    BaseParameters<SAPInstance>,
    ArmLroLocationHeader
  >;

  /**
   * Lists the SAP Instance resources for the given SAP Migration discovery site resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @operationId("SAPInstances_List")
  list is ArmResourceListByParent<SAPInstance>;
}

@@projectedName(SAPInstances.create::parameters.resource, "json", "body");
@@extension(SAPInstances.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SAPInstances.create::parameters.resource,
  "The SAP Instance request body."
);
@@projectedName(SAPInstances.update::parameters.properties, "json", "body");
@@extension(SAPInstances.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SAPInstances.update::parameters.properties,
  "The SAP Instance resource request body."
);
