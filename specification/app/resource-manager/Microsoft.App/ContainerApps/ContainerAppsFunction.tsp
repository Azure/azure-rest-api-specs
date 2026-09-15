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
using TypeSpec.Versioning;

namespace Microsoft.App;
/**
 * Container App Function.
 */
@removed(Versions.v2026_01_01)
@added(Versions.v2026_03_02_preview)
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

@removed(Versions.v2026_01_01)
@added(Versions.v2026_03_02_preview)
@armResourceOperations
@tag("AzureFunctionsOnContainerApps")
interface ContainerAppsFunctions {
  /**
   * Gets the details of a specific function in a Container App revision.
   */
  @summary("Get a specific function of a Container App Revision.")
  get is ContainerAppsFunctionOps.Read<ContainerAppsFunction>;

  /**
   * Lists the functions available in a specific Container App revision.
   */
  @summary("List the functions for a given Container App Revision.")
  list is ContainerAppsFunctionOps.List<
    ContainerAppsFunction,
    Response = ArmResponse<ContainerAppsFunctionCollection>
  >;

  /**
   * Gets the details of a specific function from the latest Container App revision.
   */
  @summary("Get a specific function of a Container App from the latest Revision.")
  getAzureFunctionsOnContainerApps is ContainerAppsFunctionOperationGroupOps.Read<ContainerAppsFunction>;

  /**
   * Lists the functions available in the latest revision of a Container App.
   */
  @summary("List the functions for a given Container App from the latest Revision.")
  listAzureFunctionsOnContainerApps is ContainerAppsFunctionOperationGroupOps.List<
    ContainerAppsFunction,
    Response = ArmResponse<ContainerAppsFunctionCollection>
  >;
}

@@doc(ContainerAppsFunction.name, "Name of the Function.");
@@doc(
  ContainerAppsFunction.properties,
  "Function resource specific properties"
);
