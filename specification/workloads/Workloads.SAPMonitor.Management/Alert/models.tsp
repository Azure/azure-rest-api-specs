import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Monitor/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using TypeSpec.Versioning;

namespace Microsoft.Workloads.Alert;

/**
 * A provider instance associated with SAP monitor.
 */
@parentResource(Monitor.Monitor)
@added(Versions.v2024_02_01_preview)
model Alert is ProxyResource<Properties> {
    /**
     * Name of the provider instance.
     */
    @pattern("^[a-zA-Z0-9-_]+$")
    @path
    @key("alert")
    @segment("alert")
    @visibility("read")
    name: string;
}

/**
 * Describes the properties of an Alert for SAP monitor.
 */
@added(Versions.v2024_02_01_preview)
model Properties {
    /**
     * Defines the SAP monitor Alert errors.
     */
    @visibility("read")
    errors?: Azure.ResourceManager.Foundations.ErrorDetail;

    /**
     * Defines the SAP monitor Alert Template Name.
     */
    templateName?: string;

    /**
     * Defines the provider type.
     */
    providerType?: ProviderType;

    /**
     * Defines the provider names.
     */
    providerNames?: string[];

    /**
     * Defines the alert rule properties.
     */
    alertRuleProperties?: RuleProperties;

    /**
     * State of provisioning of the provider instance
     */
    @visibility("read")
    provisioningState?: ProvisioningState;
}

/**
 * Defines the Alert Rule Properties.
 */
@added(Versions.v2024_02_01_preview)
model RuleProperties {
    /**
     * Indicates whether the alert is in an enabled state.
     */
    status?: string;

    /**
     * Indicates the severity of the alert.
     */
    severity?: string;

    /**
     * The action group names.
     */
    actionGroups?: string[];

    /**
     * The threshold of the alert.
     */
    threshold?: int32;

    /**
     * The threshold operator of the alert.
     */
    thresholdOperator?: string;

    /**
     * The window size of the alert.
     */
    windowSize?: int32;

    /**
     * The evaluation frequency of the alert.
     */
    evaluationFrequency?: int32;

    /**
     * The number of failing periods to alert.
     */
    failingPeriodsToAlert?: int32;

    /**
     * The operator for failing periods.
     */
    failingPeriodsOperator?: string;

    /**
     * The duration to mute actions.
     */
    muteActionsDuration?: int32;

    /**
     * Indicates whether the alert is in an auto-mitigate state.
     */
    autoMitigate?: "string";

    /**
     * The alert dimension.
     */
    dimension?: "string";

    /**
     * The alert query parameters.
     */
    @maxItems(50)
    @extension("x-ms-identifiers", ["name"])
    alertQueryParameters?: RuleQueryParameter[];
}

/**
 * Defines the Alert Query Parameter.
 */
@added(Versions.v2024_02_01_preview)
model RuleQueryParameter {
    /**
     * The name of the alert query parameter.
     */
    name?: string;

    /**
     * The value of the alert query parameter.
     */
    value?: string;
}
