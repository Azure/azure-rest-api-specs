// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageActions;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface StorageTasksOperationGroup {
  /**
   * Runs the input conditions against input object metadata properties and designates matched objects in response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  previewActions is ArmProviderActionSync<
    Request = StorageTaskPreviewAction,
    Response = StorageTaskPreviewAction,
    Scope = SubscriptionActionScope,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @segment("locations")
      location: Azure.Core.azureLocation;
    }
  >;
}

@@doc(StorageTasksOperationGroup.previewActions::parameters.body,
  "The parameters to preview action condition."
);
