import "../Monitor/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.Workloads.SapLandscapeMonitor;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "This is a singleton resource and the name is fixed."
@singleton("default")
@parentResource(Monitor.Monitor)
model SapLandscapeMonitorResource is ProxyResource<Properties> {
    /**
     * The name of the resource.
     */
    @key
    @path
    @segment("sapLandscapeMonitor")
    @visibility("read")
    name: string;
}

/**
 * Gets or sets the properties for Sap Landscape Monitor Dashboard.
 */
model Properties {
    /**
     * State of provisioning of the SAP monitor.
     */
    @visibility("read")
    provisioningState?: SapLandscapeMonitorProvisioningState;

    /**
     * Gets or sets the SID groupings by landscape and Environment.
     */
    grouping?: PropertyGrouping;

    /**
     * Gets or sets the list Top Metric Thresholds for SAP Landscape Monitor Dashboard
     */
    @maxItems(50)
    @extension("x-ms-identifiers", ["name"])
    topMetricsThresholds?: MetricThresholds[];
}

/**
 * Gets or sets the SID groupings by landscape and Environment.
 */
model PropertyGrouping {
    /**
     * Gets or sets the list of landscape to SID mappings.
     */
    @maxItems(50)
    @extension("x-ms-identifiers", ["name"])
    landscape?: SidMapping[];

    /**
     * Gets or sets the list of Sap Applications to SID mappings.
     */
    @maxItems(50)
    @extension("x-ms-identifiers", ["name"])
    sapApplication?: SidMapping[];
}

/**
 * State of provisioning of the SAP monitor.
 */
union SapLandscapeMonitorProvisioningState {
    string,

    /** The resource request has been accepted. */
    Accepted: "Accepted",

    /** The resource has been created. */
    Created: "Created",

    /** The resource operation has failed. */
    Failed: "Failed",

    /** The resource operation has succeeded. */
    Succeeded: "Succeeded",

    /** The resource operation was canceled. */
    Canceled: "Canceled",
}

/**
 * Gets or sets the mapping for SID to Environment/Applications.
 */
model SidMapping {
    /**
     * Gets or sets the name of the grouping.
     */
    name?: string;

    /**
     * Gets or sets the list of SID's.
     */
    @maxItems(50)
    topSid?: string[];
}

/**
 * Gets or sets the Threshold Values for Top Metrics Health.
 */
model MetricThresholds {
    /**
     * Gets or sets the name of the threshold.
     */
    name?: string;

    /**
     * Gets or sets the threshold value for Green.
     */
    green?: float32;

    /**
     * Gets or sets the threshold value for Yellow.
     */
    yellow?: float32;

    /**
     * Gets or sets the threshold value for Red.
     */
    red?: float32;
}
