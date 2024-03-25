import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BusinessProcess.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IntegrationSpaces;
/**
 * A business process version.
 */
@parentResource(BusinessProcess)
model BusinessProcessVersion is ProxyResource<BusinessProcessProperties> {
  /**
   * The version of the business process
   */
  @path
  @key("businessProcessVersion")
  @segment("versions")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface BusinessProcessVersions {
  /**
   * Get a BusinessProcessVersion
   */
  get is ArmResourceRead<BusinessProcessVersion>;

  /**
   * List BusinessProcessVersion resources by BusinessProcess
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BusinessProcessVersions_ListByBusinessProcess")
  listByBusinessProcess is ArmResourceListByParent<
    BusinessProcessVersion,
    {
      ...BaseParameters<BusinessProcessVersion>;

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
