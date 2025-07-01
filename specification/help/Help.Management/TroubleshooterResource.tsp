import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Help;
/**
 * Troubleshooter response.
 */
model TroubleshooterResource
  is Azure.ResourceManager.ExtensionResource<TroubleshooterInstanceProperties> {
  ...ResourceNameParameter<
    Resource = TroubleshooterResource,
    KeyName = "troubleshooterName",
    SegmentName = "troubleshooters",
    NamePattern = "([A-Za-z0-9]+(-[A-Za-z0-9]+)+)"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TroubleshooterResourcesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,

        /**
         * The fully qualified Azure Resource manager identifier of the resource.
         */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path(#{ allowReserved: true })
        scope: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * Troubleshooter resource Name.
         */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("troubleshooters")
        @minLength(1)
        @maxLength(100)
        @pattern("([A-Za-z0-9]+(-[A-Za-z0-9]+)+)")
        troubleshooterName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface TroubleshooterResources {
  /**
   * Gets troubleshooter instance result which includes the step status/result of the troubleshooter resource name that is being executed.<br/> Get API is used to retrieve the result of a Troubleshooter instance, which includes the status and result of each step in the Troubleshooter workflow. This API requires the Troubleshooter resource name that was created using the Create API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<TroubleshooterResource>;

  /**
   * Creates the specific troubleshooter action under a resource or subscription using the ‘solutionId’ and  ‘properties.parameters’ as the trigger. <br/> Azure Troubleshooters help with hard to classify issues, reducing the gap between customer observed problems and solutions by guiding the user effortlessly through the troubleshooting process. Each Troubleshooter flow represents a problem area within Azure and has a complex tree-like structure that addresses many root causes. These flows are prepared with the help of Subject Matter experts and customer support engineers by carefully considering previous support requests raised by customers. Troubleshooters terminate at a well curated solution based off of resource backend signals and customer manual selections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is TroubleshooterResourcesOps.CreateOrUpdateSync<
    TroubleshooterResource,
    OptionalRequestBody = true
  >;

  /**
   * Uses ‘stepId’ and ‘responses’ as the trigger to continue the troubleshooting steps for the respective troubleshooter resource name. <br/>Continue API is used to provide inputs that are required for the specific troubleshooter to progress into the next step in the process. This API is used after the Troubleshooter has been created using the Create API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continue is ArmResourceActionSync<
    TroubleshooterResource,
    ContinueRequestBody,
    NoContentResponse,
    OptionalRequestBody = true
  >;

  /**
   * Ends the troubleshooter action
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  end is ArmResourceActionSync<TroubleshooterResource, void, NoContentResponse>;

  /**
   * Restarts the troubleshooter API using applicable troubleshooter resource name as the input.<br/> It returns new resource name which should be used in subsequent request. The old resource name is obsolete after this API is invoked.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restart is ArmResourceActionSync<
    TroubleshooterResource,
    void,
    ArmResponse<RestartTroubleshooterResponse>
  >;
}

@@maxLength(TroubleshooterResource.name, 100);
@@minLength(TroubleshooterResource.name, 1);
@@doc(TroubleshooterResource.name, "Troubleshooter resource Name.");
@@doc(TroubleshooterResource.properties, "Troubleshooter Instance properties.");
@@doc(TroubleshooterResources.create::parameters.resource,
  "The required request body for this Troubleshooter resource creation."
);
@@doc(TroubleshooterResources.continue::parameters.body,
  "The required request body for going to next step in Troubleshooter resource."
);
