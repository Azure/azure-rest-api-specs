import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Client customizations for Java SDK to maintain backward compatibility

// Fix case change in ExternalUserInfo.userName -> username
@@clientName(Microsoft.Elastic.ExternalUserInfo.userName, "username", "java");

// Fix case changes in PlanDetails properties
@@clientName(Microsoft.Elastic.PlanDetails.offerID, "offerId", "java");
@@clientName(Microsoft.Elastic.PlanDetails.planID, "planId", "java");
@@clientName(Microsoft.Elastic.PlanDetails.publisherID, "publisherId", "java");
@@clientName(Microsoft.Elastic.PlanDetails.termID, "termId", "java");

// Fix case changes for createAndAssociate operations (IP -> Ip)
@@clientLocation(Microsoft.Elastic.ElasticMonitorResources.createAndAssociateIPFilterCreate,
  "createAndAssociateIpFilters",
  "java"
);
