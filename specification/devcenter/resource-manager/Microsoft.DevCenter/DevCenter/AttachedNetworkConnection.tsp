import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents an attached NetworkConnection.")
@parentResource(Project)
model AttachedNetworkConnection
  is Azure.ResourceManager.ProxyResource<AttachedNetworkConnectionProperties> {
  ...ResourceNameParameter<
    Resource = AttachedNetworkConnection,
    KeyName = "attachedNetworkConnectionName",
    SegmentName = "attachednetworks",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface AttachedNetworkConnectionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the project.")
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        projectName: string,
      },
      {
        @doc("The name of the attached NetworkConnection.")
        @path
        @segment("attachednetworks")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        attachedNetworkConnectionName: string,
      }
    > {}

@armResourceOperations
interface AttachedNetworkConnections {
  @doc("Gets an attached NetworkConnection.")
  getByProject is AttachedNetworkConnectionOps.Read<AttachedNetworkConnection>;

  @doc("Lists the attached NetworkConnections for a Project.")
  listByProject is AttachedNetworkConnectionOps.List<
    AttachedNetworkConnection,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = AttachedNetworkListResult
  >;
}
@armResourceOperations
interface AttachedNetworkOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the devcenter.")
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,
      },
      {
        @doc("The name of the attached NetworkConnection.")
        @path
        @segment("attachednetworks")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        attachedNetworkConnectionName: string,
      }
    > {}

@armResourceOperations
interface AttachedNetworks {
  @doc("Gets an attached NetworkConnection.")
  getByDevCenter is AttachedNetworkOps.Read<AttachedNetworkConnection>;

  @doc("Creates or updates an attached NetworkConnection.")
  createOrUpdate is AttachedNetworkOps.CreateOrUpdateAsync<AttachedNetworkConnection>;

  @doc("Un-attach a NetworkConnection.")
  delete is AttachedNetworkOps.DeleteWithoutOkAsync<
    AttachedNetworkConnection,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists the attached NetworkConnections for a DevCenter.")
  listByDevCenter is AttachedNetworkOps.List<
    AttachedNetworkConnection,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = AttachedNetworkListResult
  >;
}

@@maxLength(AttachedNetworkConnection.name, 63);
@@minLength(AttachedNetworkConnection.name, 3);
@@doc(AttachedNetworkConnection.name,
  "The name of the attached NetworkConnection."
);
@@doc(AttachedNetworkConnection.properties,
  "Attached NetworkConnection properties."
);
@@doc(AttachedNetworks.createOrUpdate::parameters.resource,
  "Represents an attached NetworkConnection."
);
