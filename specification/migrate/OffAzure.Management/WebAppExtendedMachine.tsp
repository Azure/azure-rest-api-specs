import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebAppSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * Web app extended machine REST Resource.
 */
@parentResource(WebAppSite)
model WebAppExtendedMachine
  is Azure.ResourceManager.ProxyResource<WebAppExtendedMachineProperties> {
  ...ResourceNameParameter<
    Resource = WebAppExtendedMachine,
    KeyName = "extendedMachineName",
    SegmentName = "extendedMachines"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface WebAppExtendedMachines {
  /**
   * Method to get a extended machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("WebAppExtendedMachinesController")
  @operationId("WebAppExtendedMachinesController_Get")
  get is ArmResourceRead<WebAppExtendedMachine>;

  /**
   * Method to get all extended machines.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("WebAppExtendedMachinesController")
  @operationId("WebAppExtendedMachinesController_ListByWebAppSite")
  listByWebAppSite is ArmResourceListByParent<
    WebAppExtendedMachine,
    Parameters = {
      /**
       * filter query
       */
      @query("filter")
      filter?: string;

      /**
       * page size  query
       */
      @query("top")
      top?: string;

      /**
       * Optional parameter for continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Total count of machines in the given site.
       */
      @query("totalRecordCount")
      totalRecordCount?: int32;
    }
  >;
}

@@doc(WebAppExtendedMachine.name, "Extended machine name.");
@@doc(WebAppExtendedMachine.properties,
  "The resource-specific properties for this resource."
);
