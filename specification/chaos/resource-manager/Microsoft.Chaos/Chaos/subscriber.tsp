import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./subscriber.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_11_01)
@armResourceOperations
interface Subscribers {
  /**
   * Get a subscriber.
   */
  get is ArmResourceRead<Subscriber>;

  /**
   * Get a list of subscribers for a workspace.
   */
  listByWorkspace is ArmResourceListByParent<
    Subscriber,
    Response = SubscriberListResult
  >;
}

@@minLength(Subscriber.name, 1);
@@doc(Subscriber.name, "Name of the subscriber.");
@@doc(Subscriber.properties, "The properties of the subscriber.");
