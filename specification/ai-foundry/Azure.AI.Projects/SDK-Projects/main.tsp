import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common/service.tsp";

import "../connections/routes.tsp";
import "../datasets/routes.tsp";
import "../indexes/routes.tsp";
import "../deployments/routes.tsp";
import "../red-teams/routes.tsp";
import "../evaluationrules/routes.tsp";
import "../openai-evaluations/routes.tsp";
import "../evaluation_taxonomies/routes.tsp";
import "../evaluators/routes.tsp";
import "../insights/routes.tsp";
import "../schedules/routes.tsp";
