import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Help;
/**
 * Troubleshooter response.
 */
model TroubleshooterResource
  is ExtensionResource<TroubleshooterInstanceProperties> {
  /**
   * Troubleshooter resource Name.
   */
  @maxLength(100)
  @minLength(1)
  @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+)")
  @path
  @key("troubleshooterName")
  @segment("troubleshooters")
  name: string;
}

@armResourceOperations
interface TroubleshooterResources {
  /**
   * Gets troubleshooter instance result which includes the step status/result of the troubleshooter resource name that is being executed.&lt;br/&gt; Get API is used to retrieve the result of a Troubleshooter instance, which includes the status and result of each step in the Troubleshooter workflow. This API requires the Troubleshooter resource name that was created using the Create API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Troubleshooters_Get")
  get is ArmResourceRead<TroubleshooterResource>;

  /**
   * Creates the specific troubleshooter action under a resource or subscription using the ‘solutionId’ and  ‘properties.parameters’ as the trigger. &lt;br/&gt; Troubleshooters are step-by-step interactive guidance that scope the problem by collecting additional inputs from you in each stage while troubleshooting an Azure issue. You will be guided down decision tree style workflow and the best possible solution will be presented at the end of the workflow. &lt;br/&gt; Create API creates the Troubleshooter API using ‘parameters’ and ‘solutionId’ &lt;br/&gt; After creating the Troubleshooter instance, the following APIs can be used:&lt;br/&gt; CONTINUE API: to move to the next step in the flow &lt;br/&gt;GET API: to identify the next step after executing the CONTINUE API.   &lt;br/&gt;&lt;br/&gt; &lt;b&gt;Note:&lt;/b&gt; ‘requiredParameters’ from solutions response must be passed via ‘properties. parameters’ in the request body of Troubleshooters API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Troubleshooters_Create")
  create is ArmResourceCreateOrReplaceSync<TroubleshooterResource>;

  /**
   * Uses ‘stepId’ and ‘responses’ as the trigger to continue the troubleshooting steps for the respective troubleshooter resource name. &lt;br/&gt;Continue API is used to provide inputs that are required for the specific troubleshooter to progress into the next step in the process. This API is used after the Troubleshooter has been created using the Create API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Troubleshooters_Continue")
  continue is ArmResourceActionNoContentSync<
    TroubleshooterResource,
    ContinueRequestBody
  >;

  /**
   * Ends the troubleshooter action
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Troubleshooters_End")
  end is ArmResourceActionNoContentSync<TroubleshooterResource, void>;

  /**
   * Restarts the troubleshooter API using applicable troubleshooter resource name as the input.&lt;br/&gt; It returns new resource name which should be used in subsequent request. The old resource name is obsolete after this API is invoked.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Troubleshooters_Restart")
  restart is ArmResourceActionSync<
    TroubleshooterResource,
    void,
    RestartTroubleshooterResponse
  >;
}

@@projectedName(TroubleshooterResources.create::parameters.resource,
  "json",
  "createTroubleshooterRequestBody"
);
@@extension(TroubleshooterResources.create::parameters.resource,
  "x-ms-client-name",
  "createTroubleshooterRequestBody"
);
@@doc(TroubleshooterResources.create::parameters.resource,
  "The required request body for this Troubleshooter resource creation."
);
@@projectedName(TroubleshooterResources.continue::parameters.body,
  "json",
  "continueRequestBody"
);
@@extension(TroubleshooterResources.continue::parameters.body,
  "x-ms-client-name",
  "continueRequestBody"
);
@@doc(TroubleshooterResources.continue::parameters.body,
  "The required request body for going to next step in Troubleshooter resource."
);
