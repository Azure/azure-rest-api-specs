import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./discoveryHub.tsp";
import "./models.tsp";
import "./application.tsp";
import "./member.tsp";
import "./main.tsp";

using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@armResourceOperations
interface DiscoveryHubs {
  @summary("Retrieves the specified DiscoveryHub resource.")
  get is ArmResourceRead<DiscoveryHub>;

  @summary("Creates or updates a DiscoveryHub resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DiscoveryHub>;

  @summary("Updates the specified properties of a DiscoveryHub resource.")
  update is ArmResourcePatchSync<DiscoveryHub, DiscoveryHubProperties>;

  @summary("Deletes the specified DiscoveryHub resource.")
  delete is ArmResourceDeleteSync<DiscoveryHub>;

  @summary("Lists all DiscoveryHub resources in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<DiscoveryHub>;

  @summary("Lists all DiscoveryHub resources in the specified subscription.")
  listBySubscription is ArmListBySubscription<DiscoveryHub>;
}

@armResourceOperations
interface Applications {
  @summary("Retrieves an Application resource.")
  get is ArmResourceRead<Application>;

  @summary("Creates or updates an Application resource synchronously.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Application>;

  @summary("Updates an Application resource synchronously.")
  update is ArmResourcePatchSync<Application, ApplicationProperties>;

  @summary("Deletes an Application resource synchronously.")
  delete is ArmResourceDeleteSync<Application>;

  @summary("Lists Application resources by resource group.")
  listByResourceGroup is ArmResourceListByParent<Application>;

  @summary("Lists Application resources by subscription.")
  listBySubscription is ArmListBySubscription<Application>;
}

@armResourceOperations
interface Members {
  @summary("Get a member resource.")
  get is ArmResourceRead<Member>;

  @summary("Create or update a member resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Member>;

  @summary("Update a member resource.")
  update is ArmResourcePatchSync<Member, MemberProperties>;

  @summary("Delete a member resource.")
  delete is ArmResourceDeleteSync<Member>;

  @summary("List members in an Application.")
  listByApplication is ArmResourceListByParent<Member>;
}
