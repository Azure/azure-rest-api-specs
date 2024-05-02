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
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
@parentResource(SAPDiscoverySite)
model SAPInstance is TrackedResource<SAPInstanceProperties> {
  /**
   * The name of SAP Instance resource for SAP Migration.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]$")
  @path
  @key("sapInstanceName")
  @segment("sapInstances")
  @visibility("read")
  name: string;
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
  create is ArmResourceCreateOrReplaceAsync<SAPInstance>;

  /**
   * Updates the SAP Instance resource.
   */
  @parameterVisibility
  update is ArmTagsPatchSync<SAPInstance>;

  /**
   * Deletes the SAP Instance resource. <br><br>This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the SAP Migration discovery site resource, using the delete operation on it.
   */
  #suppress "deprecated" "Existing API"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API"
  delete is ArmResourceDeleteAsync<SAPInstance>;

  /**
   * Lists the SAP Instance resources for the given SAP Migration discovery site resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
  list is ArmResourceListByParent<SAPInstance>;
}
