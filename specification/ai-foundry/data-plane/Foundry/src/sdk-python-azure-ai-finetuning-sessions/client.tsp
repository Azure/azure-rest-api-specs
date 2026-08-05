//
// This file is used for emitting the Python client (package azure-ai-finetuning-sessions).
//
// It imports the single relevant routes file for the fine-tuning sessions service
// and applies all SDK-level customizations (client name, sub-client grouping, model
// renames). The service declaration, models, and versioning stub are brought in
// transitively through routes.tsp.
//

import "../session-finetuning/routes.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.FineTuning.Sessions;

// ─── Namespace remapping ───────────────────────────────────────────────────────

// Map OpenAI types into the same Python namespace to avoid duplicate 'Error'
// name conflict between OpenAI.Error and Azure.Core.Foundations.Error.
@@clientNamespace(OpenAI, "azure.ai.finetuning_sessions", "python");

// Rename OpenAI.Error to ApiError so it doesn't clash with Azure.Core.Foundations.Error,
// which TCGC also generates as "Error" in the same Python module via LRO response paths.
@@clientName(OpenAI.Error, "ApiError", "python");

// ─── Top-level client name ────────────────────────────────────────────────────

// The generated client is named `FineTuningSessionClient` to match the
// `azure.ai.finetuning.sessions.FineTuningSessionClient` class used in the hero
// code samples in SPEC_FOUNDRY_AICLIENT.md.
@@clientName(Azure.AI.FineTuning.Sessions, "FineTuningSessionClient");

// ─── Operation group renames ──────────────────────────────────────────────────

// Keep interface names as operation groups in the SDK.
// These become sub-operations or methods on the client depending on the emitter.
@@clientName(Azure.AI.FineTuning.Sessions.FineTuningSessions, "Sessions");
@@clientName(Azure.AI.FineTuning.Sessions.Training, "Training");
@@clientName(Azure.AI.FineTuning.Sessions.Checkpoints, "Checkpoints");
@@clientName(Azure.AI.FineTuning.Sessions.Sampling, "Sampling");
@@clientName(Azure.AI.FineTuning.Sessions.Operations, "Operations");

// ─── Model renames (SDK-friendly) ─────────────────────────────────────────────

// Drop the FineTuning prefix for types where it adds no clarity in SDK context.
@@clientName(FineTuningSessionStatus, "SessionStatus");
@@clientName(FineTuningSessionType, "SessionType");
@@clientName(FineTuningOperationType, "OperationType");
@@clientName(FineTuningOperationStatus, "OperationStatus");
@@clientName(FineTuningCheckpointType, "CheckpointType");
@@clientName(FineTuningSession, "Session");
@@clientName(FineTuningSessionSummary, "SessionSummary");
@@clientName(FineTuningCheckpoint, "Checkpoint");
@@clientName(FineTuningCheckpointInfo, "CheckpointInfo");
@@clientName(FineTuningCheckpointList, "CheckpointList");
@@clientName(FineTuningSessionList, "SessionList");
@@clientName(FineTuningPendingOperation, "PendingOperation");
@@clientName(FineTuningOperationResult, "OperationResult");
@@clientName(FineTuningSampleRequest, "SampleRequest");
@@clientName(FineTuningSamplingParams, "SamplingParams");
@@clientName(FineTuningSampledSequence, "SampledSequence");
@@clientName(FineTuningSampleResult, "SampleResult");
@@clientName(FineTuningSampleOperationResult, "SampleOperationResult");
@@clientName(FineTuningStopCriteria, "StopCriteria");
@@clientName(FineTuningDatum, "Datum");
@@clientName(FineTuningModelInput, "ModelInput");
@@clientName(FineTuningModelInputChunk, "ModelInputChunk");
@@clientName(FineTuningLossFn, "LossFn");
@@clientName(FineTuningCompleteResponse, "CompleteResponse");
@@clientName(FineTuningHeartbeatResponse, "HeartbeatResponse");
@@clientName(FineTuningCursor, "Cursor");
@@clientName(FineTuningSessionModelData, "SessionModelData");
@@clientName(CreateFineTuningSessionRequest, "CreateSessionRequest");
@@clientName(CreateFineTuningSessionResponse, "CreateSessionResponse");

// ─── Forward-only payload types ───────────────────────────────────────────────

// ForwardInput / ForwardRequest are not yet wired to an operation (the forward
// endpoint is served by a custom client method in _patch.py). Force them to be
// generated as public input models so the SDK exposes the named types ahead of
// the operation being added to the REST contract.
@@usage(ForwardInput, Usage.input);
@@access(ForwardInput, Access.public);
@@usage(ForwardRequest, Usage.input);
@@access(ForwardRequest, Access.public);
