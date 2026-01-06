import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Genome;

/**
 * Retrieves all configuration entries with optional filtering by category or key.
 * Returns comprehensive configuration metadata including values, descriptions,
 * and modification history.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom configuration retrieval operation with filtering"
@summary("Get all configurations")
@route("/v1/configurations")
@get
op getConfigurations is Azure.Core.Foundations.Operation<
  {
    /**
     * Filter configurations by category/group
     */
    @query("category")
    category?: string;

    /**
     * Filter configurations by key (partial match)
     */
    @query("key")
    key?: string;
  },
  ConfigurationListResponse
>;

/**
 * Creates a new configuration entry with a unique key. The key must not already
 * exist. Use PUT to update existing configurations.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom configuration creation operation"
@summary("Create a new configuration")
@route("/v1/configurations")
@put
op createOrReplaceConfiguration is Azure.Core.Foundations.Operation<
  ConfigurationRequest,
  ConfigurationResponse
>;

/**
 * Retrieves a specific configuration entry using its unique key. Returns complete
 * configuration metadata including value, description, category, and modification
 * history.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom configuration retrieval by key operation"
@summary("Get configuration by key")
@route("/v1/configurations/{key}")
@get
op getConfigurationByKey is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique configuration key
     */
    @path
    key: string;
  },
  ConfigurationResponse
>;

/**
 * Updates an existing configuration entry. All fields in the request body will be
 * updated. The configuration key in the URL must match an existing configuration.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom configuration update operation"
@summary("Update configuration")
@route("/v1/configurations/{key}")
@put
op replaceConfiguration is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique configuration key to update
     */
    @path
    key: string;

    /** Configuration data to update */
    @body
    body: ConfigurationRequest;
  },
  ConfigurationResponse
>;

/**
 * Deletes a configuration entry permanently. This action cannot be undone. Use
 * with caution as dependent services may be affected.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom configuration deletion operation"
@summary("Delete configuration")
@route("/v1/configurations/{key}")
@delete
op deleteConfiguration is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique configuration key to delete
     */
    @path
    key: string;
  },
  void
>;

/**
 * Simplified endpoint for quickly retrieving just the configuration value without
 * full metadata. Ideal for services that need to read configuration values
 * programmatically.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom configuration value retrieval operation"
@summary("Get configuration value by key")
@route("/v1/configurations/{key}/value")
@get
op getConfigurationValue is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique configuration key
     */
    @path
    key: string;
  },
  PathsB13Wt0V1ConfigurationsKeyValueGetResponses200ContentApplicationJsonSchema
>;
