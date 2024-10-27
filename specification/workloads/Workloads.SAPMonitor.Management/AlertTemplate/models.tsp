import "../Monitor/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Workloads.AlertTemplate;

@parentResource(Monitor.Monitor)
@added(Versions.v2024_02_01_preview)
model AlertTemplate is ProxyResource<Properties> {
    /**
     * Name of the Alert Template instance.
     */
    @pattern("^[a-zA-Z0-9-_]+$")
    @path
    @key("alertTemplate")
    @segment("alertTemplates")
    @visibility("read")
    name: string;
}

/**
 * Describes the properties of an Alert Template for SAP monitor.
 */
@added(Versions.v2024_02_01_preview)
model Properties {
    /**
     * Defines the SAP monitor Alert Template errors.
     */
    @visibility("read")
    errors?: Azure.ResourceManager.Foundations.ErrorDetail;

    /**
     * State of provisioning of the Alert Template.
     */
    @visibility("read")
    provisioningState?: ProvisioningState;

    /**
     * Display name of the template.
     */
    templateDisplayName?: string;

    /**
     * Type of the provider.
     */
    providerType?: ProviderType;

    /**
     * Description of the template.
     */
    description?: string;

    /**
     * Severity level of the alert.
     */
    severity?: int32;

    /**
     * Query associated with the alert.
     */
    query?: string;

    /**
     * Operator used for threshold comparison.
     */
    thresholdOperator?: string;

    /**
     * Default threshold value.
     */
    defaultThreshold?: int32;

    /**
     * Lower bound for the threshold.
     */
    lowerBound?: int32;

    /**
     * Upper bound for the threshold.
     */
    upperBound?: int32;

    /**
     * Input option for the default threshold.
     */
    defaultThresholdInputOption?: string;

    /**
     * Unit of the alert.
     */
    alertUnit?: string;

    /**
     * Metric measurement details.
     */
    metricMeasurement?: MetricMeasurement;

    /**
     * Parameters for the query input.
     */
    @maxItems(50)
    @extension("x-ms-identifiers", ["name"])
    queryInputParameters?: QueryInputParameter[];
}

/**
 * Defines the Alert Template MetricMeasurement Properties.
 */
@added(Versions.v2024_02_01_preview)
model MetricMeasurement {
    /**
     * Operator used for threshold comparison.
     */
    thresholdOperator?: string;

    /**
     * Threshold value.
     */
    threshold?: int32;

    /**
     * Type of metric trigger.
     */
    metricTriggerType?: string;

    /**
     * Column associated with the metric.
     */
    metricColumn?: string;

    /**
     * Frequency of measurement in minutes.
     */
    frequencyInMinutes?: int32;

    /**
     * Time window for measurement in minutes.
     */
    timeWindowInMinutes?: int32;
}

/**
 * Defines the properties of a Query Input Parameter.
 */
@added(Versions.v2024_02_01_preview)
model QueryInputParameter {
    /**
     * Name of the parameter.
     */
    name?: string;

    /**
     * Type of the parameter.
     */
    type?: string;

    /**
     * Description of the parameter.
     */
    description?: string;

    /**
     * Default value of the parameter.
     */
    defaultValue?: string;

    /**
     * Log Analytics query associated with the parameter.
     */
    laQuery?: string;

    /**
     * Selection mode for the parameter.
     */
    selectionMode?: string;

    /**
     * Display name of the parameter.
     */
    displayName?: string;
}
