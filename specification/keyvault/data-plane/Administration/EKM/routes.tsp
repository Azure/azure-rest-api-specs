import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../common/common.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace KeyVault;

/**
 * The External Key Manager (EKM) Get operation returns EKM connection. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_01_01_preview)
@summary("Gets the EKM connection.")
@route("/ekm")
@get
op getEkmConnection is KeyVaultOperation<{}, EkmConnection>;

/**
 * The External Key Manager (EKM) Certificate Get operation returns Proxy client certificate. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_01_01_preview)
@summary("Gets the EKM proxy client certificate.")
@route("/ekm/certificate")
@get
op getEkmCertificate is KeyVaultOperation<{}, EkmProxyClientCertificateInfo>;

/**
 * The External Key Manager (EKM) Check operation checks the connectivity and authentication with the EKM proxy. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_01_01_preview)
@summary("Checks the connectivity and authentication with the EKM proxy.")
@route("/ekm/check")
@post
op checkEkmConnection is KeyVaultOperation<{}, EkmProxyInfo>;

/**
 * The External Key Manager (EKM) sets up the EKM connection. If the EKM connection already exists, this operation fails. This operation requires ekm/write permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_01_01_preview)
@summary("Creates the EKM connection.")
@route("/ekm/create")
@post
op createEkmConnection is KeyVaultOperation<
  {
    /**
     * The ekmConnection to create.
     */
    #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @Azure.ClientGenerator.Core.Legacy.flattenProperty
    ekmConnection: EkmConnection;
  },
  EkmConnection
>;

/**
 * The External Key Manager (EKM) updates the existing EKM connection. If the EKM connection does not exist, this operation fails. This operation requires ekm/write permission.
 */
#suppress "@typespec/http/deprecated-implicit-optionality" "Legacy - DO NOT COPY"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_01_01_preview)
@summary("Updates the EKM connection.")
@route("/ekm")
@patch(#{ implicitOptionality: true })
op updateEkmConnection is KeyVaultOperation<
  {
    /**
     * The ekmConnection to update.
     */
    #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @Azure.ClientGenerator.Core.Legacy.flattenProperty
    ekmConnection: EkmConnection;
  },
  EkmConnection
>;

/**
 * The External Key Manager (EKM) deletes the existing EKM connection. If the EKM connection does not already exists, this operation fails. This operation requires ekm/delete permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_01_01_preview)
@summary("Deletes the EKM connection.")
@route("/ekm")
@delete
op deleteEkmConnection is KeyVaultOperation<{}, EkmConnection>;

/**
 * The External Key Manager (EKM) private endpoint operation status. Returns the status of a private endpoint create or delete operation. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_07_01_preview)
@summary("Gets the status of an EKM proxy private endpoint operation.")
@route("/ekm/privateendpoint/operations/{operationId}")
@get
op getEkmPrivateEndpointOperationStatus is KeyVaultOperation<
  {
    /**
     * The identifier of the private endpoint operation.
     */
    @path
    operationId: string;
  },
  EkmPrivateEndpointOperation
>;

/**
 * The External Key Manager (EKM) creates a private endpoint to the EKM proxy Private Link Service. A pool may have up to two private endpoints. This operation requires ekm/write permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_07_01_preview)
@pollingOperation(getEkmPrivateEndpointOperationStatus)
@finalOperation(getEkmPrivateEndpointOperationStatus)
@useFinalStateVia("azure-async-operation")
@summary("Creates an EKM proxy private endpoint.")
@route("/ekm/privateendpoint/{peName}")
@post
op createEkmPrivateEndpoint is KeyVaultOperation<
  {
    /**
     * The name of the private endpoint. Must be 1-24 characters, start and end with an alphanumeric character, and contain only alphanumeric characters and hyphens.
     */
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{0,22}[a-zA-Z0-9]$")
    @minLength(1)
    @maxLength(24)
    peName: string;

    /**
     * The parameters to create the private endpoint.
     */
    @body
    parameters: EkmPrivateEndpointCreateParameters;
  },
  {
    @statusCode _: 202;

    /**
     * The URI to poll for completion status.
     */
    @pollingLocation
    @header("Azure-AsyncOperation")
    azureAsyncOperation?: string;

    /**
     * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
     */
    @header("Retry-After") retryAfter?: int32;

    /**
     * The private endpoint operation.
     */
    @body response: EkmPrivateEndpointOperation;
  }
>;

/**
 * The External Key Manager (EKM) deletes an existing EKM proxy private endpoint. The operation is rejected while an EKM connection still references the private endpoint. This operation requires ekm/write permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_07_01_preview)
@pollingOperation(getEkmPrivateEndpointOperationStatus)
@finalOperation(getEkmPrivateEndpointOperationStatus)
@useFinalStateVia("azure-async-operation")
@summary("Deletes an EKM proxy private endpoint.")
@route("/ekm/privateendpoint/{peName}")
@delete
op deleteEkmPrivateEndpoint is KeyVaultOperation<
  {
    /**
     * The name of the private endpoint to delete.
     */
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{0,22}[a-zA-Z0-9]$")
    @minLength(1)
    @maxLength(24)
    peName: string;
  },
  {
    @statusCode _: 202;

    /**
     * The URI to poll for completion status.
     */
    @pollingLocation
    @header("Azure-AsyncOperation")
    azureAsyncOperation?: string;

    /**
     * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
     */
    @header("Retry-After") retryAfter?: int32;

    /**
     * The private endpoint operation.
     */
    @body response: EkmPrivateEndpointOperation;
  }
>;

/**
 * The External Key Manager (EKM) gets an existing EKM proxy private endpoint. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@added(KeyVault.Versions.v2026_07_01_preview)
@summary("Gets an EKM proxy private endpoint.")
@route("/ekm/privateendpoint/{peName}")
@get
op getEkmPrivateEndpoint is KeyVaultOperation<
  {
    /**
     * The name of the private endpoint to get.
     */
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{0,22}[a-zA-Z0-9]$")
    @minLength(1)
    @maxLength(24)
    peName: string;
  },
  EkmPrivateEndpoint
>;

/**
 * The External Key Manager (EKM) lists all EKM proxy private endpoints on the pool. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "List operation returns a wrapped list result envelope"
@added(KeyVault.Versions.v2026_07_01_preview)
@summary("Lists the EKM proxy private endpoints.")
@route("/ekm/privateendpoint")
@get
op listEkmPrivateEndpoints is KeyVaultOperation<
  {},
  EkmPrivateEndpointListResult
>;
