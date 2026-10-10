import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "../metricsContainers/models.tsp";
import "../service.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Monitor {
  /**
   * The type of metric stored in the Azure Monitor Workspace.
   */
  @added(Versions.v2026_09_03_preview)
  union MetricConfigurationType {
    /**
     * A raw metric.
     */
    Raw: "Raw",

    /**
     * A metric aggregated from another metric.
     */
    Aggregated: "Aggregated",

    string,
  }

  alias metricResourceNamePattern = "^(?:[A-Za-z0-9._-]|~[0-9A-Fa-f]{2})+$";

  /**
   * A tilde-encoded metric namespace or metric name used in resource paths.
   * ASCII letters, digits, period, underscore, and hyphen remain unchanged.
   * Each byte of any other UTF-8 character is represented as `~HH`
   * hexadecimal; for example, `/` is `~2F` and a space is `~20`.
   */
  @added(Versions.v2026_09_03_preview)
  @pattern(metricResourceNamePattern)
  @maxLength(260)
  scalar MetricResourceName extends string;

  /**
   * Aggregation functions enabled for an aggregated metric.
   */
  @added(Versions.v2026_09_03_preview)
  model MetricAggregationFunctions {
    /**
     * Whether minimum and maximum aggregations are enabled.
     */
    enableMinMax: boolean;

    /**
     * Whether percentile aggregations are enabled.
     */
    enablePercentiles: boolean;
  }

  /**
   * An aggregation configuration for an aggregated metric.
   */
  @added(Versions.v2026_09_03_preview)
  model MetricAggregationConfiguration {
    /**
     * Whether aggregated metric data is stored.
     */
    storeAggregatedData?: boolean;

    /**
     * Dimensions included in this aggregation.
     */
    @Azure.Core.uniqueItems
    dimensions?: string[];

    /**
     * Aggregation functions enabled for this aggregation.
     */
    aggregationFunctions?: MetricAggregationFunctions;
  }

  /**
   * Properties of a metric configuration.
   */
  @added(Versions.v2026_09_03_preview)
  model MetricConfigurationProperties {
    /**
     * The provisioning state of the metric configuration.
     */
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

    /**
     * The actual metric namespace before route encoding.
     */
    `namespace`?: string;

    /**
     * The actual ingested metric name before route encoding.
     */
    metricName?: string;

    /**
     * The metric type.
     */
    metricType?: MetricConfigurationType;

    /**
     * Dimensions emitted by the metric.
     */
    @Azure.Core.uniqueItems
    @visibility(Lifecycle.Read)
    dimensions?: string[];

    /**
     * Whether raw metric data is stored.
     */
    storeRawData?: boolean;

    /**
     * Aggregation configurations for an aggregated metric.
     */
    @identifiers(#[])
    aggregationConfigurations?: MetricAggregationConfiguration[];

    /**
     * The resource ID of the source metric for an aggregated metric.
     */
    sourceMetricResourceId?: Azure.Core.armResourceIdentifier<[
      {
        type: "Microsoft.Monitor/accounts/metricsContainers/namespaces/metrics";
      }
    ]>;
  }

  /**
   * Properties of a metric namespace.
   */
  @added(Versions.v2026_09_03_preview)
  model MetricNamespaceProperties {
    /**
     * The provisioning state of the metric namespace.
     */
    @visibility(Lifecycle.Read)
    provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
  }

  /**
   * A metric namespace in an Azure Monitor Workspace metrics container.
   */
  @added(Versions.v2026_09_03_preview)
  @parentResource(MetricsContainerResource)
  model MetricNamespaceResource is ProxyResource<MetricNamespaceProperties> {
    ...ResourceNameParameter<
      Resource = MetricNamespaceResource,
      KeyName = "encodedMetricNamespace",
      SegmentName = "namespaces",
      NamePattern = metricResourceNamePattern,
      Type = MetricResourceName
    >;
  }
  @@doc(
    MetricNamespaceResource.name,
    "Tilde encoding is used for the metric namespace in the URL path. It is similar to percent encoding but uses `~` instead of `%`. For example, `/` is encoded as `~2F`. Metric configurations provide the original namespace in `properties.namespace`."
  );

  /**
   * A metric configuration in an Azure Monitor Workspace metric namespace.
   */
  @added(Versions.v2026_09_03_preview)
  @parentResource(MetricNamespaceResource)
  model MetricConfigurationResource
    is ProxyResource<MetricConfigurationProperties> {
    ...ResourceNameParameter<
      Resource = MetricConfigurationResource,
      KeyName = "encodedMetricName",
      SegmentName = "metrics",
      NamePattern = metricResourceNamePattern,
      Type = MetricResourceName
    >;
  }
  @@doc(
    MetricConfigurationResource.name,
    "Tilde encoding is used for the metric name in the URL path. It is similar to percent encoding but uses `~` instead of `%`. For example, `/` is encoded as `~2F`. The original metric name is provided in `properties.metricName`."
  );
}
