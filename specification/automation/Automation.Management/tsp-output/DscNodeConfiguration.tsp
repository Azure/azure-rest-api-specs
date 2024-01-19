import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
@doc("Definition of the dsc node configuration.")
@parentResource(AutomationAccount)
model DscNodeConfiguration is ProxyResource<DscNodeConfigurationProperties> {
  @doc("The Dsc node configuration name.")
  @path
  @key("nodeConfigurationName")
  @segment("nodeConfigurations")
  name: string;
}

@armResourceOperations
interface DscNodeConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the Dsc node configurations by node configuration.")
  @operationId("DscNodeConfiguration_Get")
  get is ArmResourceRead<DscNodeConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the node configuration identified by node configuration name.")
  @operationId("DscNodeConfiguration_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DscNodeConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the Dsc node configurations by node configuration.")
  @operationId("DscNodeConfiguration_Delete")
  delete is ArmResourceDeleteSync<DscNodeConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of dsc node configurations.")
  @operationId("DscNodeConfiguration_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    DscNodeConfiguration,
    {
      ...BaseParameters<DscNodeConfiguration>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("The number of rows to skip.")
      @query("$skip")
      $skip?: int32;

      @doc("The number of rows to take.")
      @query("$top")
      $top?: int32;

      @doc("Return total rows.")
      @query("$inlinecount")
      $inlinecount?: string;
    }
  >;
}

@@projectedName(DscNodeConfigurations.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DscNodeConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DscNodeConfigurations.createOrUpdate::parameters.resource,
  "The create or update parameters for configuration."
);
