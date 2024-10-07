import "../Monitor/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Workloads.Provider;

/**
 * A provider instance associated with SAP monitor.
 */
@parentResource(Monitor.Monitor)
model ProviderInstance is ProxyResource<Properties> {
    /**
     * Name of the provider instance.
     */
    @pattern("^[a-zA-Z0-9-_]+$")
    @path
    @key("providerInstanceName")
    @segment("providerInstances")
    @visibility("read")
    name: string;
}

/**
 * Describes the properties of a provider instance.
 */
model Properties {
    /**
     * State of provisioning of the provider instance
     */
    @visibility("read")
    provisioningState?: ProvisioningState;

    /**
     * Resource health details
     */
    @visibility("read")
    health?: Health;

    /**
     * Defines the provider instance errors.
     */
    @visibility("read")
    errors?: Azure.ResourceManager.Foundations.ErrorDetail;

    /**
     * Defines the provider specific properties.
     */
    providerSettings?: ProviderSpecificProperties;
}

/**
 * Resource health details
 */
model Health {
    /**
     * Health state of the resource
     */
    @visibility("read")
    healthState?: WorkloadProviderInstanceHealthState;

    /**
     * Reasons impacting health state
     */
    @visibility("read")
    impactingReasons?: string;
}

/**
 * State of health of the provider instance
 */
union WorkloadProviderInstanceHealthState {
    string,

    /** The resource health status is Healthy */
    Healthy: "Healthy",

    /** The resource health status is Degraded */
    Degraded: "Degraded",

    /** The resource health status is Unavailable */
    Unavailable: "Unavailable",

    /** The resource health status is Unknown */
    Unknown: "Unknown",
}

/**
 * Gets or sets certificate preference if secure communication is enabled.
 */
union SslPreference {
    string,

    /** Secure communication is disabled. */
    Disabled: "Disabled",

    /** Secure communication is enabled with root certificate. */
    RootCertificate: "RootCertificate",

    /** Secure communication is enabled with server certificate. */
    ServerCertificate: "ServerCertificate",
}

/**
 * Gets or sets the provider specific properties.
 */
@discriminator("providerType")
model ProviderSpecificProperties {
    /**
     * The provider type. For example, the value can be SapHana.
     */
    // #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
    @visibility("read", "create")
    providerType: ProviderType;
}
