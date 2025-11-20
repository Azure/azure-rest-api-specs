namespace Microsoft.ContainerRegistry;

/**
 * The properties of a scope map.
 */
model ScopeMapProperties {
  /**
   * The user friendly description of the scope map.
   */
  description?: string;

  /**
   * The type of the scope map. E.g. BuildIn scope map.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The creation date of scope map.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The list of scoped permissions for registry artifacts.
   * E.g. repositories/repository-name/content/read,
   * repositories/repository-name/metadata/write
   */
  actions: string[];
}

/**
 * The properties for updating the scope map.
 */
model ScopeMapUpdateParameters {
  /**
   * The update parameters for scope map properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ScopeMapPropertiesUpdateParameters;
}

/**
 * The update parameters for scope map properties.
 */
model ScopeMapPropertiesUpdateParameters {
  /**
   * The user friendly description of the scope map.
   */
  description?: string;

  /**
   * The list of scope permissions for registry artifacts.
   * E.g. repositories/repository-name/pull,
   * repositories/repository-name/delete
   */
  actions?: string[];
}

/**
 * The result of a request to list scope maps for a container registry.
 */
model ScopeMapListResult {
  /**
   * The list of scope maps. Since this list may be incomplete, the nextLink field should be used to request the next list of scope maps.
   */
  @pageItems
  value?: ScopeMap[];

  /**
   * The URI that can be used to request the next list of scope maps.
   */
  @nextLink
  nextLink?: string;
}
