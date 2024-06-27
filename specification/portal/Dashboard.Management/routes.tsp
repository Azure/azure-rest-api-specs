// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Portal;

interface ListTenantConfigurationViolationsOperations {
  /**
   * Gets list of items that violate tenant's configuration.
   */
  @route("/providers/Microsoft.Portal/listTenantConfigurationViolations")
  @post
  list(...ApiVersionParameter): ArmResponse<ViolationsList> | ErrorResponse;
}
