import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
/**
 * Class representing a database script.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Database)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ScriptProperties)
model Script extends ProxyResourceBase {
  /**
   * The name of the Kusto database script.
   */
  @pattern("^.*$")
  @path
  @key("scriptName")
  @segment("scripts")
  @visibility("read")
  name: string;

  /**
   * The database script.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScriptProperties;
}

@armResourceOperations
interface Scripts {
  /**
   * Gets a Kusto cluster database script.
   */
  get is ArmResourceRead<Script>;

  /**
   * Creates a Kusto database script.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Script>;

  /**
   * Updates a database script.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Script, Script>;

  /**
   * Deletes a Kusto database script.
   */
  delete is ArmResourceDeleteAsync<Script>;

  /**
   * Returns the list of database scripts for given database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Scripts_ListByDatabase")
  listByDatabase is ArmResourceListByParent<Script>;
}

@@projectedName(Scripts.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Scripts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Scripts.createOrUpdate::parameters.resource,
  "The Kusto Script parameters contains the KQL to run."
);
@@projectedName(Scripts.update::parameters.properties, "json", "parameters");
@@extension(Scripts.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Scripts.update::parameters.properties,
  "The Kusto Script parameters contains to the KQL to run."
);
