// SDK entry point for the Fine-Tuning Session client.
//
// Imports the fine-tuning service declaration (auth, server URL, versioning stub)
// and the session fine-tuning REST surface. The matching client.tsp in this folder
// applies SDK-level customizations (client name, renames, subclient grouping).
//
// Note: we import finetuning-service.tsp instead of ../common/service.tsp so that
// Azure.AI.Projects is NOT registered as a @service, which would cause emitters to
// generate an unwanted ProjectsClient.  finetuning-service.tsp provides the same
// Versions enum / @versioned stub that servicepatterns.tsp depends on.

import "./finetuning-session.tsp";
import "../common/custom-types.tsp";

import "../session-finetuning/routes.tsp";
