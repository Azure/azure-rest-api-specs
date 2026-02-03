import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Revision.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App Function.
 */
@parentResource(Revision)
model ContainerAppsFunction
  is Azure.ResourceManager.ProxyResource<ContainerAppsFunctionProperties> {
  ...ResourceNameParameter<
    Resource = ContainerAppsFunction,
    KeyName = "functionName",
    SegmentName = "functions",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias ContainerAppsFunctionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    containerAppName: string;

    /** Name of the Container App Revision. */
    @path
    @segment("revisions")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    revisionName: string;
  },
  {
    /** Name of the Function. */
    @path
    @segment("functions")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    functionName: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
@tag("AzureFunctionsOnContainerApps")
interface ContainerAppsFunctions {
  /**
   * Get a specific function of a Container App Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisionFunctions_Get")
  @summary("Get a specific function of a Container App Revision.")
  get is ContainerAppsFunctionOps.Read<ContainerAppsFunction>;

  /**
   * List the functions for a given Container App Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisionFunctions_List")
  @summary("List the functions for a given Container App Revision.")
  list is ContainerAppsFunctionOps.List<
    ContainerAppsFunction,
    Response = ArmResponse<ContainerAppsFunctionCollection>
  >;
}

alias ContainerAppsFunctionOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    containerAppName: string;
  },
  {
    /** Name of the Function. */
    @path
    @segment("functions")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    functionName: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
interface AzureFunctionsOnContainerApps {
  /**
   * Get a specific function of a Container App from the latest Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsFunctions_Get")
  @summary("Get a specific function of a Container App from the latest Revision.")
  get is ContainerAppsFunctionOperationGroupOps.Read<ContainerAppsFunction>;

  /**
   * List the functions for a given Container App from the latest Revision.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List the functions for a given Container App from the latest Revision.")
  @operationId("ContainerAppsFunctions_List")
  list is ContainerAppsFunctionOperationGroupOps.List<
    ContainerAppsFunction,
    Response = ArmResponse<ContainerAppsFunctionCollection>
  >;
}

@@doc(ContainerAppsFunction.name, "Name of the Function.");
@@doc(ContainerAppsFunction.properties,
  "Function resource specific properties"
);
