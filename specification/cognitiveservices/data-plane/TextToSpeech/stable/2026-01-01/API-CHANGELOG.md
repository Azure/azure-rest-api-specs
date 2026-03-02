# Custom Voice API Changes: 2026-01-01 vs 2024-02-01-preview

## Overview

This document summarizes the API changes between the stable version `2026-01-01` and the preview version `2024-02-01-preview` for the Azure AI Speech Services Custom Voice API.

**API Title:** Custom voice API  
**Service:** Azure AI - Speech Services  
**Base Path:** `{endpoint}/customvoice`

---

## Summary of Changes

| Category | Change Type | Description |
|----------|-------------|-------------|
| Enum | Added | `DatasetProcessAs` - Dataset processing method (`Segmented`, `Contextual`) |
| Schema: Dataset | Added | `processAs` property - Specify processing mode for training data |
| Schema: Project | Added | `locale` property - Project locale setting |
| Schema: Recipe | Added | `minDurationInSeconds` property - Minimum audio duration requirement |
| Schema: ModelProperties | Added | `failedTrainingsets` property - Failed training set IDs |
| Schema: ModelProperties | Added | `secondaryLocales` property - Secondary locales the model can speak |
| Schema: TrainingSetProperties | Added | `durationInSeconds` property - Total audio duration |
| Schema: TrainingSetProperties | Added | `isContextual` property - Whether data is contextual |
| Enum: ModelFailureReason | Updated | Added `DataNotReady` and `DataNotEnough` failure reasons |
| Operation: PersonalVoices_Post | Updated | `audioData` parameter - Added 30MB file size limit |
| API Version | Changed | Promoted from `2024-02-01-preview` to `2026-01-01` (stable) |

---

## Detailed Changes

### 1. New Enum: `DatasetProcessAs`

**Location:** `definitions/DatasetProcessAs`

A new optional property `processAs` has been added to the `Dataset` definition to specify the processing method for uploaded data.

```json
"DatasetProcessAs": {
  "description": "Dataset processing method. If not specified, the default processing method will be used.",
  "enum": [
    "Segmented",
    "Contextual"
  ],
  "type": "string",
  "x-ms-enum": {
    "name": "DatasetProcessAs",
    "modelAsString": true,
    "values": [
      {
        "value": "Segmented",
        "description": "The default processing mode that works with all supported languages."
      },
      {
        "value": "Contextual",
        "description": "An enhanced mode that retains the audio as a whole to keep the contextual information for more natural intonations."
      }
    ]
  }
}
```

**Impact:** Non-breaking change. Customers can optionally specify processing method for better training results.

---

### 2. Dataset Definition - Added `processAs` Property

**Location:** `definitions/Dataset`

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `processAs` | `DatasetProcessAs` | No | Dataset processing method |

**Impact:** Non-breaking change. Optional property added for enhanced dataset processing.

---

### 3. Project Definition - Added `locale` Property

**Location:** `definitions/Project`

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `locale` | `string` | No | The locale of this project. Locale code follows BCP-47. |

**Example:** `"en-US"`

**Impact:** Non-breaking change. Optional property to specify project locale.

---

### 4. Recipe Definition - Added `minDurationInSeconds` Property

**Location:** `definitions/Recipe`

| Property | Type | Required | ReadOnly | Description |
|----------|------|----------|----------|-------------|
| `minDurationInSeconds` | `number (double)` | No | Yes | Minimum audio duration in seconds required to train a voice model with this recipe |

**Impact:** Non-breaking change. Provides additional metadata for recipe requirements.

---

### 5. ModelFailureReason Enum - Added New Values

**Location:** `definitions/ModelFailureReason`

**Previous values (2024-02-01-preview):**
- `InaccessibleCustomerStorage`
- `SpeakerVerificationFailed`
- `TerminateByUser`
- `Internal`

**New values (2026-01-01):**
- `InaccessibleCustomerStorage`
- `SpeakerVerificationFailed`
- `TerminateByUser`
- `Internal`
- **`DataNotReady`** *(NEW)*
- **`DataNotEnough`** *(NEW)*

| New Value | Description |
|-----------|-------------|
| `DataNotReady` | Training data is not ready for model training. |
| `DataNotEnough` | Training data is not enough for model training. |

**Impact:** Non-breaking change. Additional failure reasons for better error diagnostics.

---

### 6. ModelProperties Definition - Added New Properties

**Location:** `definitions/ModelProperties`

| Property | Type | Required | ReadOnly | Description |
|----------|------|----------|----------|-------------|
| `failedTrainingsets` | `array[string]` | No | Yes | IDs of failed training sets |
| `secondaryLocales` | `array[string]` | No | Yes | Secondary locales that this model can speak. Locale code follows BCP-47. |

**Impact:** Non-breaking change. Additional read-only metadata for model properties.

---

### 7. TrainingSetProperties Definition - Added New Properties

**Location:** `definitions/TrainingSetProperties`

**Previous properties (2024-02-01-preview):**
- `utteranceCount`

**New properties (2026-01-01):**

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `utteranceCount` | `integer (int32)` | No | Utterance count in this training set |
| `durationInSeconds` | `number (double)` | No | Total duration of audio in seconds in this training set |
| `isContextual` | `boolean` | No | Indicates whether the training set is composed of contextual data |

**Impact:** Non-breaking change. Additional metadata properties for training set.

---

### 8. PersonalVoices_Post - Updated `audioData` Property

**Location:** `/personalvoices/{id}` POST operation - `audioData` form parameter

**Change:** Added file size limit annotation.

| Property | Change | Value |
|----------|--------|-------|
| `description` | Updated | "Audio files. Maximum file size is 30MB." |
| `x-ms-max-length` | Added | `31457280` (30MB) |

**Impact:** Documentation improvement. Clarifies the maximum file size for audio uploads.

---

## Breaking Changes

**None.** All changes in this version are additive and backward-compatible.

---

## Migration Guide

### For Existing Customers (2024-02-01-preview → 2026-01-01)

1. **No required changes** - All existing API calls will continue to work.

2. **Optional enhancements:**
   - Use `processAs` property in `Dataset` to specify processing mode for training data
   - Check new `failedTrainingsets` property to identify specific failed training sets
   - Utilize `secondaryLocales` to understand multi-language support for models
   - Monitor new failure reasons (`DataNotReady`, `DataNotEnough`) for better error handling

3. **Update API version:**
   Change `api-version` query parameter from `2024-02-01-preview` to `2026-01-01`

---

## API Endpoints Summary

All endpoints remain unchanged between versions. The following operations are available:

| Resource | Operations |
|----------|------------|
| Projects | List, Get, Create, Delete |
| Consents | List, Get, Create, Post, Delete |
| Training Sets | List, Get, Create, Delete, Upload Data |
| Model Recipes | List |
| Models | List, Get, Create, Delete |
| Endpoints | List, Get, Create, Delete, Resume, Suspend |
| Base Models | List |
| Personal Voices | List, Get, Create, Post, Delete |
| Operations | Get |

---

## Document Version

- **Document Version:** 1.0
- **Last Updated:** January 2026
- **API Version:** 2026-01-01

---

## Contact

For questions about this API change document, please contact:
- **Team:** Azure AI - Speech Services
- **Documentation:** https://learn.microsoft.com/azure/ai-services/speech-service/
