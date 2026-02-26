import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Legacy desgin"
@tag("Location")
interface LocationOperationGroup {
  /**
   * Gets the Batch service quotas for the specified subscription at the given location.
   */
  @autoRoute
  @get
  @action("quotas")
  getQuotas is ArmProviderActionSync<
    Response = BatchLocationQuota,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The region for which to retrieve Batch service quotas.
       */
      @path
      @segment("locations")
      locationName: string;
    },
    Error = CloudError
  >;
  /**
   * Gets the list of Batch supported Virtual Machine VM sizes available at the given location.
   */
  @autoRoute
  @list
  @get
  @action("virtualMachineSkus")
  listSupportedVirtualMachineSkus is ArmProviderActionSync<
    Response = SupportedSkusResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The region for which to retrieve Batch service supported SKUs.
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;

      /**
       * OData filter expression. Valid properties for filtering are "familyName".
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;
  /**
   * Checks whether the Batch account name is available in the specified region.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameters,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The desired region for the name check.
       */
      @path
      @segment("locations")
      locationName: string;
    },
    Error = CloudError
  >;
}

@@doc(LocationOperationGroup.checkNameAvailability::parameters.body,
  "Properties needed to check the availability of a name."
);
