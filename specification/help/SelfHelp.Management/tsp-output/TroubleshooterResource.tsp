import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SelfHelp;
@doc("Troubleshooter response.")
model TroubleshooterResource
  is ExtensionResource<TroubleshooterInstanceProperties> {
  @doc("Troubleshooter resource Name.")
  @maxLength(100)
  @minLength(1)
  @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+)")
  @key("troubleshooterName")
  @segment("troubleshooters")
  name: string;
}

@armResourceOperations
interface Troubleshooters {
  @doc("Gets troubleshooter instance result which includes the step status/result of the troubleshooter resource name that is being executed.&lt;br/&gt; Get API is used to retrieve the result of a Troubleshooter instance, which includes the status and result of each step in the Troubleshooter workflow. This API requires the Troubleshooter resource name that was created using the Create API.")
  get is ArmResourceRead<TroubleshooterResource>;
  @doc("Creates the specific troubleshooter action under a resource or subscription using the ‘solutionId’ and  ‘properties.parameters’ as the trigger. &lt;br/&gt; Troubleshooters are step-by-step interactive guidance that scope the problem by collecting additional inputs from you in each stage while troubleshooting an Azure issue. You will be guided down decision tree style workflow and the best possible solution will be presented at the end of the workflow. &lt;br/&gt; Create API creates the Troubleshooter API using ‘parameters’ and ‘solutionId’ &lt;br/&gt; After creating the Troubleshooter instance, the following APIs can be used:&lt;br/&gt; CONTINUE API: to move to the next step in the flow &lt;br/&gt;GET API: to identify the next step after executing the CONTINUE API.   &lt;br/&gt;&lt;br/&gt; &lt;b&gt;Note:&lt;/b&gt; ‘requiredParameters’ from solutions response must be passed via ‘properties. parameters’ in the request body of Troubleshooters API.")
  create is ArmResourceCreateOrReplaceSync<TroubleshooterResource>;
  @doc("Uses ‘stepId’ and ‘responses’ as the trigger to continue the troubleshooting steps for the respective troubleshooter resource name. &lt;br/&gt;Continue API is used to provide inputs that are required for the specific troubleshooter to progress into the next step in the process. This API is used after the Troubleshooter has been created using the Create API.")
  continue is ArmResourceActionNoContentSync<
    TroubleshooterResource,
    ContinueRequestBody
  >;
  @doc("Ends the troubleshooter action")
  end is ArmResourceActionNoContentSync<TroubleshooterResource, void>;
  @doc("Restarts the troubleshooter API using applicable troubleshooter resource name as the input.&lt;br/&gt; It returns new resource name which should be used in subsequent request. The old resource name is obsolete after this API is invoked.")
  restart is ArmResourceActionSync<
    TroubleshooterResource,
    void,
    RestartTroubleshooterResponse
  >;
}
