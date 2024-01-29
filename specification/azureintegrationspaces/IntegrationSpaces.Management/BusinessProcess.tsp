import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Application.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IntegrationSpaces;
/**
 * A business process under application.
 */
@parentResource(Application)
model BusinessProcess is ProxyResource<BusinessProcessProperties> {
  /**
   * The name of the business process
   */
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  @path
  @key("businessProcessName")
  @segment("businessProcesses")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface BusinessProcesses {
  /**
   * Get a BusinessProcess
   */
  get is ArmResourceRead<BusinessProcess>;

  /**
   * Create a BusinessProcess
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<BusinessProcess>;

  /**
   * Update a BusinessProcess
   */
  @parameterVisibility("read")
  patch is ArmCustomPatchSync<BusinessProcess, BusinessProcessUpdate>;

  /**
   * Delete a BusinessProcess
   */
  delete is ArmResourceDeleteSync<BusinessProcess>;

  /**
   * List BusinessProcess resources by Application
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BusinessProcesses_ListByApplication")
  listByApplication is ArmResourceListByParent<
    BusinessProcess,
    {
      ...BaseParameters<BusinessProcess>;

      ...TopQueryParameter;

      ...SkipQueryParameter;

      ...MaxPageSizeQueryParameter;

      ...FilterQueryParameter;

      ...SelectQueryParameter;

      ...ExpandQueryParameter;

      ...OrderByQueryParameter;
    }
  >;
}
