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
/**
 * Definition of the Dsc Compilation job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(DscCompilationJobProperties)
@includeInapplicableMetadataInPayload(false)
model DscCompilationJob extends ProxyResourceBase {
  /**
   * The DSC configuration Id.
   */
  @path
  @key("compilationJobName")
  @segment("compilationjobs")
  name: string;

  /**
   * Gets or sets the properties of the Dsc Compilation job.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DscCompilationJobProperties;
}

@armResourceOperations
interface DscCompilationJobs {
  /**
   * Retrieve the Dsc configuration compilation job identified by job id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscCompilationJob_Get")
  get is ArmResourceRead<DscCompilationJob>;

  /**
   * Creates the Dsc compilation job of the configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscCompilationJob_Create")
  create is ArmResourceCreateOrReplaceAsync<DscCompilationJob>;

  /**
   * Retrieve a list of dsc compilation jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscCompilationJob_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    DscCompilationJob,
    {
      ...BaseParameters<DscCompilationJob>;

      /**
       * The filter to apply on the operation.
       */
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
