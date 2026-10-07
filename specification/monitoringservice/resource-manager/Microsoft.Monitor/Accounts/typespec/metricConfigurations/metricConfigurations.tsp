import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../service.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Monitor {
  /**
   * Metric namespace operations.
   */
  @added(Versions.v2026_09_03_preview)
  @armResourceOperations
  interface MetricNamespaces {
    /**
     * Gets a metric namespace.
     */
    get is ArmResourceRead<MetricNamespaceResource>;

    /**
     * Lists metric namespaces for an Azure Monitor Workspace. Resource
     * properties may be omitted in collection responses.
     */
    listByMetricsContainer is ArmResourceListByParent<MetricNamespaceResource>;
  }

  /**
   * Metric configuration operations.
   */
  @added(Versions.v2026_09_03_preview)
  @armResourceOperations
  interface MetricConfigurations {
    /**
     * Gets a metric configuration.
     */
    get is ArmResourceRead<MetricConfigurationResource>;

    /**
     * Creates or updates a metric configuration.
     */
    createOrUpdate is ArmResourceCreateOrReplaceSync<MetricConfigurationResource>;

    /**
     * Deletes a metric configuration.
     */
    delete is ArmResourceDeleteSync<MetricConfigurationResource>;

    /**
     * Lists metrics in a metric namespace. Resource properties may be omitted
     * in collection responses.
     */
    listByMetricNamespace is ArmResourceListByParent<
      Resource = MetricConfigurationResource,
      Parameters = {
        /**
         * An OData filter for source metric resource IDs.
         */
        @query("$filter")
        $filter?: string;
      }
    >;

    /**
     * Lists metrics across all namespaces in a metrics container. Resource
     * properties may be omitted in collection responses.
     */
    @autoRoute
    @get
    @action("metrics")
    @list
    @armResourceList(MetricConfigurationResource)
    listByMetricsContainer(
      ...ResourceInstanceParameters<MetricsContainerResource>,

      /**
       * An OData filter for source metric resource IDs.
       */
      @query("$filter")
      $filter?: string,
    ):
      | ArmResponse<Azure.Core.Page<MetricConfigurationResource>>
      | ErrorResponse;
  }
}
