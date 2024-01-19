import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./User.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
@doc("An environment, which is essentially an ARM template deployment.")
@parentResource(User)
model DtlEnvironment is TrackedResource<EnvironmentProperties> {
  @doc("The name of the environment.")
  @path
  @key("name")
  @segment("environments")
  name: string;
}

@armResourceOperations
interface DtlEnvironments {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get environment.")
  @operationId("Environments_Get")
  get is ArmResourceRead<
    DtlEnvironment,
    {
      ...BaseParameters<DtlEnvironment>;

      @doc("Specify the $expand query. Example: 'properties($select=deploymentProperties)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or replace an existing environment. This operation can take a while to complete.")
  @operationId("Environments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DtlEnvironment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Allows modifying tags of environments. All other properties will be ignored.")
  @operationId("Environments_Update")
  update is ArmCustomPatchSync<DtlEnvironment, DtlEnvironmentFragment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete environment. This operation can take a while to complete.")
  @operationId("Environments_Delete")
  delete is ArmResourceDeleteAsync<DtlEnvironment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List environments in a given user profile.")
  @operationId("Environments_List")
  list is ArmResourceListByParent<
    DtlEnvironment,
    {
      ...BaseParameters<DtlEnvironment>;

      @doc("Specify the $expand query. Example: 'properties($select=deploymentProperties)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}

@@projectedName(DtlEnvironments.createOrUpdate::parameters.resource,
  "json",
  "dtlEnvironment"
);
@@extension(DtlEnvironments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "dtlEnvironment"
);
@@doc(DtlEnvironments.createOrUpdate::parameters.resource,
  "An environment, which is essentially an ARM template deployment."
);
@@projectedName(DtlEnvironments.update::parameters.properties,
  "json",
  "dtlEnvironment"
);
@@extension(DtlEnvironments.update::parameters.properties,
  "x-ms-client-name",
  "dtlEnvironment"
);
@@doc(DtlEnvironments.update::parameters.properties,
  "An environment, which is essentially an ARM template deployment."
);
