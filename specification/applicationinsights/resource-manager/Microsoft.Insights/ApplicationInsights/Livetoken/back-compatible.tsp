import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using LiveTokenApi;

@@clientLocation(LiveTokenOperationGroup.get, "LiveToken");
