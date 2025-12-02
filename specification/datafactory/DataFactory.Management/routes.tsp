// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FactoriesOperationGroup {
  /**
   * Updates a factory's repo information.
   */
  @autoRoute
  configureFactoryRepo is ArmProviderActionSync<
    Request = FactoryRepoUpdate,
    Response = Factory,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location identifier.
       */
      @path
      @segment("locations")
      locationId: string;
    },
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ExposureControlOperationGroup {
  /**
   * Get exposure control feature for specific location.
   */
  @autoRoute
  getFeatureValue is ArmProviderActionSync<
    Request = ExposureControlRequest,
    Response = ExposureControlResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The location identifier.
       */
      @path
      @segment("locations")
      locationId: string;
    },
    Error = CloudError
  >;
}
