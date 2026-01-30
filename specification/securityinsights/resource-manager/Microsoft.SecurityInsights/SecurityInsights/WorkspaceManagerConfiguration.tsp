import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * The workspace manager configuration
 */
model WorkspaceManagerConfiguration
  is Azure.ResourceManager.ProxyResource<WorkspaceManagerConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceManagerConfiguration,
    KeyName = "workspaceManagerConfigurationName",
    SegmentName = "workspaceManagerConfigurations",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;
}

@armResourceOperations
interface WorkspaceManagerConfigurations {
  /**
   * Gets a workspace manager configuration
   */
  get is Extension.Read<
    workspaceExternalResource,
    WorkspaceManagerConfiguration
  >;

  /**
   * Creates or updates a workspace manager configuration.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    workspaceExternalResource,
    WorkspaceManagerConfiguration
  >;

  /**
   * Deletes a workspace manager configuration
   */
  delete is Extension.DeleteSync<
    workspaceExternalResource,
    WorkspaceManagerConfiguration
  >;

  /**
   * Gets all workspace manager configurations for a Sentinel workspace.
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    WorkspaceManagerConfiguration,
    Parameters = {
      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<WorkspaceManagerConfigurationList>
  >;
}

@@doc(WorkspaceManagerConfiguration.name,
  "The name of the workspace manager configuration"
);
@@doc(WorkspaceManagerConfiguration.properties,
  "The workspace manager configuration object"
);
@@doc(WorkspaceManagerConfigurations.createOrUpdate::parameters.resource,
  "The workspace manager configuration"
);
