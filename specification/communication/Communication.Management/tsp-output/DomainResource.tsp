import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EmailServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Communication;
@doc("A class representing a Domains resource.")
@parentResource(EmailServiceResource)
model DomainResource is TrackedResource<DomainProperties> {
  @doc("The name of the Domains resource.")
  @maxLength(253)
  @minLength(1)
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface Domains {
  @doc("Get the Domains resource and its properties.")
  get is ArmResourceRead<DomainResource>;
  @doc("Add a new Domains resource under the parent EmailService resource or update an existing Domains resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DomainResource>;
  @doc("Operation to update an existing Domains resource.")
  update is ArmCustomPatchAsync<DomainResource, UpdateDomainRequestParameters>;
  @doc("Operation to delete a Domains resource.")
  delete is ArmResourceDeleteAsync<DomainResource>;
  @doc("Handles requests to list all Domains resources under the parent EmailServices resource.")
  listByEmailServiceResource is ArmResourceListByParent<DomainResource>;
  @doc("Initiate verification of DNS record.")
  initiateVerification is ArmResourceActionNoResponseContentAsync<
    DomainResource,
    VerificationParameter
  >;
  @doc("Cancel verification of DNS record.")
  cancelVerification is ArmResourceActionNoResponseContentAsync<
    DomainResource,
    VerificationParameter
  >;
}
