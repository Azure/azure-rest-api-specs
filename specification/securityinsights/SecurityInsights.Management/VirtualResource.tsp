import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

alias OperationalInsights = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "workspaceName",
  Description = "The name of the monitor workspace."
>;