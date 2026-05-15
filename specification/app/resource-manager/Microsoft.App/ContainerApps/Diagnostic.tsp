import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;

/**
 * Diagnostics data for a resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Diagnostics
  is Azure.ResourceManager.ProxyResource<DiagnosticsProperties> {
  ...ResourceNameParameter<
    Resource = Diagnostics,
    KeyName = "detectorName",
    SegmentName = "detectors",
    NamePattern = ""
  >;
}

alias ContainerAppsDiagnosticsRevisionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    containerAppName: string;
  },
  {
    /** Name of the detector. */
    @path
    @segment("detectorProperties/revisionsApi/revisions")
    @key
    revisionName: string;
  },
  ErrorType = DefaultErrorResponse
>;

alias ContainerAppsDetectorOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    containerAppName: string;
  },
  {
    /** Name of the detector. */
    @path
    @segment("detectors")
    @key
    detectorName: string;
  },
  ErrorType = DefaultErrorResponse
>;

alias ContainerAppDetectorPropertyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    containerAppName: string;
  },
  {
    /** Proxy API Name for the Container App diagnostic root. */
    @path
    @segment("detectorProperties")
    @key
    rootApi: "rootApi/";
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
@tag("ContainerApps")
@tag("Diagnostics")
interface ContainerAppsDiagnostics {
  /**
   * Get a revision of a Container App.
   */
  @summary("Get a revision of a Container App.")
  getRevision is ContainerAppsDiagnosticsRevisionOps.Read<Revision>;

  @summary("Get the Revisions for a given Container App.")
  @get
  @list
  @action("detectorProperties/revisionsApi/revisions/")
  listRevisions is ArmResourceActionSync<
    ContainerApp,
    void,
    ArmResponse<RevisionCollection>,
    Parameters = {
      /** The filter to apply on the operation. */
      @query
      $filter?: string;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Get the list of diagnostics for a given Container App.
   */
  @summary("Get the list of diagnostics for a given Container App.")
  listDetectors is ContainerAppsDetectorOps.List<
    Diagnostics,
    Response = ArmResponse<DiagnosticsCollection>
  >;

  /**
   * Get a diagnostics result of a Container App.
   */
  @summary("Get a diagnostics result of a Container App.")
  getDetector is ContainerAppsDetectorOps.Read<
    Diagnostics,
    Response = ArmResponse<Diagnostics>
  >;
}

@armResourceOperations
@tag("ContainerApps")
@tag("Diagnostics")
interface ContainerAppDetectorProperties {
  /**
   * Get the properties of a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserve the existing OpenAPI operation id while modeling getRoot as a resource read for C# generation."
  @summary("Get the properties of a Container App.")
  @operationId("ContainerAppsDiagnostics_GetRoot")
  getRoot is ContainerAppDetectorPropertyOps.Read<
    ContainerApp,
    Response = ArmResponse<ContainerApp> | ContainerAppsNotFoundError
  >;
}

alias JobsDiagnosticsDetectorOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App Job. */
    @path
    @segment("jobs")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    jobName: string;
  },
  {
    /** Proxy API Name for Container App Job. */
    @path
    @segment("detectors")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    detectorName: string;
  },
  ErrorType = DefaultErrorResponse
>;

alias ManagedEnvironmentDetectorOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Managed Environment. */
    @path
    @segment("managedEnvironments")
    @key
    environmentName: string;
  },
  {
    /** Name of the detector. */
    @path
    @segment("detectors")
    @key
    detectorName: string;
  },
  ErrorType = DefaultErrorResponse
>;

alias ContainerAppManagedEnvironmentDetectorResourcePropertyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Environment. */
    @path
    @segment("managedEnvironments")
    @key
    environmentName: string;
  },
  {
    /** Proxy API Name for the managed environment diagnostic root. */
    @path
    @segment("detectorProperties")
    @key
    rootApi: "rootApi/";
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
@tag("ManagedEnvironments")
@tag("Diagnostics")
interface ManagedEnvironmentsDiagnostics {
  /**
   * Get the list of diagnostics for a Managed Environment used to host container apps.
   */
  @summary("Get the list of diagnostics for a given Managed Environment.")
  listDetectors is ManagedEnvironmentDetectorOps.ListSinglePage<
    Diagnostics,
    Response = ArmResponse<DiagnosticsCollection>
  >;

  /**
   * Get the diagnostics data for a Managed Environment used to host container apps.
   */
  @summary("Get the diagnostics data for a given Managed Environment.")
  getDetector is ManagedEnvironmentDetectorOps.Read<
    Diagnostics,
    Response = ArmResponse<Diagnostics>
  >;
}

@armResourceOperations
@tag("ManagedEnvironments")
@tag("Diagnostics")
interface ContainerAppManagedEnvironmentDetectorResourceProperties {
  /**
   * Get the properties of a Managed Environment used to host container apps.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserve the existing OpenAPI operation id while modeling getRoot as a resource read for C# generation."
  @summary("Get the properties of a Managed Environment.")
  @operationId("ManagedEnvironmentsDiagnostics_GetRoot")
  getRoot is ContainerAppManagedEnvironmentDetectorResourcePropertyOps.Read<
    ManagedEnvironment,
    Response = ArmResponse<ManagedEnvironment>
  >;
}
