import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of the Dsc Compilation job.")
@parentResource(AutomationAccount)
model DscCompilationJob is ProxyResource<DscCompilationJobProperties> {
  @doc("The DSC configuration Id.")
  @path
  @key("compilationJobName")
  @segment("compilationjobs")
  name: string;
}

@armResourceOperations
interface DscCompilationJob {
  @doc("Retrieve the Dsc configuration compilation job identified by job id.")
  get is ArmResourceRead<DscCompilationJob>;
  @doc("Creates the Dsc compilation job of the configuration.")
  create is ArmResourceCreateOrUpdateAsync<DscCompilationJob>;
  @doc("Retrieve a list of dsc compilation jobs.")
  listByAutomationAccount is ArmResourceListByParent<
    DscCompilationJob,
    {
      ...BaseParameters<DscCompilationJob>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
