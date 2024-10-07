import "./models.tsp";
import "../models.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Workloads.Provider.Providers;

/**
 * Gets or sets the Sap Hana Db provider properties.
 */
model HanaDbProperties extends ProviderSpecificProperties {
    /**
     * Gets or sets the target virtual machine size.
     */
    hostname?: string;

    /**
     * Gets or sets the hana database name.
     */
    dbName?: string;

    /**
     * Gets or sets the database sql port.
     */
    sqlPort?: string;

    /**
     * Gets or sets the database instance number.
     */
    instanceNumber?: string;

    /**
     * Gets or sets the database user name.
     */
    dbUsername?: string;

    /**
     * Gets or sets the database password.
     */
    @secret
    dbPassword?: string;

    /**
     * Gets or sets the key vault URI to secret with the database password.
     */
    dbPasswordUri?: string;

    /**
     * Gets or sets the blob URI to SSL certificate for the DB.
     */
    sslCertificateUri?: string;

    /**
     * Gets or sets the hostname(s) in the SSL certificate.
     */
    sslHostNameInCertificate?: string;

    /**
     * Gets or sets certificate preference if secure communication is enabled.
     */
    sslPreference?: SslPreference;

    /**
     * Gets or sets the SAP System Identifier.
     */
    sapSid?: string;

    /**
     * The provider type. For example, the value can be SapHana.
     */
    providerType: ProviderType.SapHana;
}

/**
 * Gets or sets the Sap Net Weaver provider properties.
 */
model SapNetWeaverProperties extends ProviderSpecificProperties {
    /**
     * Gets or sets the SAP System Identifier
     */
    sapSid?: string;

    /**
     * Gets or sets the target virtual machine IP Address/FQDN.
     */
    sapHostname?: string;

    /**
     * Gets or sets the instance number of SAP NetWeaver.
     */
    sapInstanceNr?: string;

    /**
     * Gets or sets the list of HostFile Entries
     */
    sapHostFileEntries?: string[];

    /**
     * Gets or sets the SAP user name.
     */
    sapUsername?: string;

    /**
     * Sets the SAP password.
     */
    @secret
    sapPassword?: string;

    /**
     * Gets or sets the key vault URI to secret with the SAP password.
     */
    sapPasswordUri?: string;

    /**
     * Gets or sets the SAP Client ID.
     */
    sapClientId?: string;

    /**
     * Gets or sets the SAP HTTP port number.
     */
    sapPortNumber?: string;

    /**
     * Gets or sets the blob URI to SSL certificate for the SAP system.
     */
    sslCertificateUri?: string;

    /**
     * Gets or sets certificate preference if secure communication is enabled.
     */
    sslPreference?: SslPreference;

    /**
     * The provider type. For example, the value can be SapHana.
     */
    providerType: ProviderType.SapNetWeaver;
}

/**
 * Gets or sets the PrometheusOS provider properties.
 */
model PrometheusOsProperties extends ProviderSpecificProperties {
    /**
     * URL of the Node Exporter endpoint
     */
    prometheusUrl?: string;

    /**
     * Gets or sets certificate preference if secure communication is enabled.
     */
    sslPreference?: SslPreference;

    /**
     * Gets or sets the blob URI to SSL certificate for the prometheus node exporter.
     */
    sslCertificateUri?: string;

    /**
     * Gets or sets the SAP System Identifier
     */
    sapSid?: string;

    /**
     * The provider type. For example, the value can be SapHana.
     */
    providerType: ProviderType.PrometheusOS;
}

/**
 * Gets or sets the DB2 provider properties.
 */
model Db2Properties extends ProviderSpecificProperties {
    /**
     * Gets or sets the target virtual machine name.
     */
    hostname?: string;

    /**
     * Gets or sets the db2 database name.
     */
    dbName?: string;

    /**
     * Gets or sets the db2 database sql port.
     */
    dbPort?: string;

    /**
     * Gets or sets the db2 database user name.
     */
    dbUsername?: string;

    /**
     * Gets or sets the db2 database password.
     */
    @secret
    dbPassword?: string;

    /**
     * Gets or sets the key vault URI to secret with the database password.
     */
    dbPasswordUri?: string;

    /**
     * Gets or sets the SAP System Identifier
     */
    sapSid?: string;

    /**
     * Gets or sets certificate preference if secure communication is enabled.
     */
    sslPreference?: SslPreference;

    /**
     * Gets or sets the blob URI to SSL certificate for the DB2 Database.
     */
    sslCertificateUri?: string;

    /**
     * The provider type. For example, the value can be SapHana.
     */
    providerType: ProviderType.Db2;
}

/**
 * Gets or sets the PrometheusHaCluster provider properties.
 */
model PrometheusHaClusterProperties extends ProviderSpecificProperties {
    /**
     * URL of the Node Exporter endpoint.
     */
    prometheusUrl?: string;

    /**
     * Gets or sets the target machine name.
     */
    hostname?: string;

    /**
     * Gets or sets the cluster sid.
     */
    sid?: string;

    /**
     * Gets or sets the clusterName.
     */
    clusterName?: string;

    /**
     * Gets or sets certificate preference if secure communication is enabled.
     */
    sslPreference?: SslPreference;

    /**
     * Gets or sets the blob URI to SSL certificate for the HA cluster exporter.
     */
    sslCertificateUri?: string;

    /**
     * The provider type. For example, the value can be SapHana.
     */
    providerType: ProviderType.PrometheusHaCluster;
}

/**
 * Gets or sets the SQL server provider properties.
 */
model MsSqlServerProperties extends ProviderSpecificProperties {
    /**
     * Gets or sets the SQL server host name.
     */
    hostname?: string;

    /**
     * Gets or sets the database sql port.
     */
    dbPort?: string;

    /**
     * Gets or sets the database user name.
     */
    dbUsername?: string;

    /**
     * Gets or sets the database password.
     */
    @secret
    dbPassword?: string;

    /**
     * Gets or sets the key vault URI to secret with the database password.
     */
    dbPasswordUri?: string;

    /**
     * Gets or sets the SAP System Identifier
     */
    sapSid?: string;

    /**
     * Gets or sets certificate preference if secure communication is enabled.
     */
    sslPreference?: SslPreference;

    /**
     * Gets or sets the blob URI to SSL certificate for the SQL Database.
     */
    sslCertificateUri?: string;

    /**
     * The provider type. For example, the value can be SapHana.
     */
    providerType: ProviderType.MsSqlServer;
}

/**
 * Gets or sets the Oracle provider properties.
 */
@added(Versions.v2024_02_01_preview)
model OracleProperties extends ProviderSpecificProperties {
    /**
     * Gets or sets the SQL server host name.
     */
    hostname?: string;

    /**
     * Gets or sets the database sql port.
     */
    dbPort?: string;

    /**
     * Gets or sets the database user name.
     */
    dbUsername?: string;

    /**
     * Gets or sets the database password.
     */
    @secret
    dbPassword?: string;

    /**
     * Gets or sets the key vault URI to secret with the database password.
     */
    dbPasswordUri?: string;

    /**
     * Gets or sets the SAP System Identifier
     */
    sapSid?: string;

    /**
     * Gets or sets certificate preference if secure communication is enabled.
     */
    sslPreference?: SslPreference;

    /**
     * Gets or sets the blob URI to SSL certificate for the SQL Database.
     */
    sslCertificateUri?: string;

    /**
     * The provider type. For example, the value can be SapHana.
     */
    providerType: ProviderType.Oracle;
}
