import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Automation;
@doc("Definition of the dsc node configuration.")
@parentResource(AutomationAccount)
model DscNodeConfiguration is ProxyResource<DscNodeConfigurationProperties> {
  @doc("The Dsc node configuration name.")
  @key("nodeConfigurationName")
  @segment("nodeConfigurations")
  name: string;
}

@armResourceOperations
@projectedName("client", "DscNodeConfiguration")
interface DscNodeConfigurations_DscNodeConfiguration {
  @doc("Retrieve the Dsc node configurations by node configuration.")
  get is ArmResourceRead<DscNodeConfiguration>;

  @doc("Create the node configuration identified by node configuration name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DscNodeConfiguration>;

  @doc("Delete the Dsc node configurations by node configuration.")
  delete is ArmResourceDeleteSync<DscNodeConfiguration>;

  @doc("Retrieve a list of dsc node configurations.")
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
