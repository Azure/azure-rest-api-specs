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
interface DscCompilationJobs {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the Dsc configuration compilation job identified by job id.")
  @operationId("DscCompilationJob_Get")
  get is ArmResourceRead<DscCompilationJob>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the Dsc compilation job of the configuration.")
  @operationId("DscCompilationJob_Create")
  create is ArmResourceCreateOrUpdateAsync<DscCompilationJob>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of dsc compilation jobs.")
  @operationId("DscCompilationJob_ListByAutomationAccount")
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

@@projectedName(DscCompilationJobs.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(DscCompilationJobs.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DscCompilationJobs.create::parameters.resource,
  "The parameters supplied to the create compilation job operation."
);
