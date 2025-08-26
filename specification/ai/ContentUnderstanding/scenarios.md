# Champion Scenarios

## Analyze a PDF using a prebuilt document analyzer (binary input)

**Customer Value:** Extracts key content from local PDFs at scale to automate downstream workflows without manual data entry.

**REST API Flow:**

1. Start analysis with the prebuilt analyzer on binary content
2. Poll operation status until completed
3. Retrieve structured results (JSON)
4. (Optional) Download any generated result files

```http
POST /analyzers/prebuilt-documentAnalyzer:analyze
	Content-Type: application/pdf
	Body: <binary PDF>

GET /analyzers/prebuilt-documentAnalyzer/operations/{operationId}

GET /analyzerResults/{operationId}

GET /analyzerResults/{operationId}/files/{path}
```

Related sample: `content_analyzers_analyze_binary.py`

---

## Analyze a PDF and persist the raw JSON response

**Customer Value:** Enables auditability and offline post-processing by saving the raw analysis JSON to storage.

**REST API Flow:**

1. Start analysis with the prebuilt analyzer on binary content
2. Poll operation status until completed
3. Retrieve structured results (JSON)
4. Save JSON to storage (e.g., blob, filesystem)

```http
POST /analyzers/prebuilt-documentAnalyzer:analyze
GET /analyzers/prebuilt-documentAnalyzer/operations/{operationId}
GET /analyzerResults/{operationId}
```

Related sample: `content_analyzers_analyze_binary_raw_json.py`

---

## Analyze a document from a URL

**Customer Value:** Processes web-hosted or cloud-stored documents without downloading them locally.

**REST API Flow:**

1. Start analysis with a URL payload
2. Poll operation status until completed
3. Retrieve structured results (JSON)

```http
POST /analyzers/prebuilt-documentAnalyzer:analyze
	Content-Type: application/json
	{
		"url": "https://.../document.pdf"
	}

GET /analyzers/prebuilt-documentAnalyzer/operations/{operationId}
GET /analyzerResults/{operationId}
```

Related sample: `content_analyzers_analyze_url.py`

---

## Extract invoice fields using the prebuilt-invoice analyzer (URL)

**Customer Value:** Automates invoice ingestion to unlock AP automation and downstream reconciliation.

**REST API Flow:**

1. Start invoice analysis with a URL payload
2. Poll operation status until completed
3. Retrieve structured invoice fields

```http
POST /analyzers/prebuilt-invoice:analyze
	Content-Type: application/json
	{
		"url": "https://.../invoice.pdf"
	}

GET /analyzers/prebuilt-invoice/operations/{operationId}
GET /analyzerResults/{operationId}
```

Related sample: `content_analyzers_analyze_url_prebuilt_invoice.py`

---

## Create or replace a custom analyzer

**Customer Value:** Tailors extraction to business-specific documents, fields, and structures.

**REST API Flow:**

1. Create or replace analyzer with schema and configuration
2. Verify analyzer exists

```http
PUT /analyzers/{analyzerId}
	Content-Type: application/json
	{
		"config": {
			"schema": { /* field definitions */ },
			"analysisMode": "...",
			"processingLocation": "..."
		}
	}

GET /analyzers/{analyzerId}
```

Related sample: `content_analyzers_create_or_replace.py`

---

## Update, get, list, and delete analyzers

**Customer Value:** Governs analyzer lifecycle for change management and hygiene.

**REST API Flow:**

```http
PATCH /analyzers/{analyzerId}
	Content-Type: application/json
	{
		"config": { /* partial updates */ }
	}

GET /analyzers/{analyzerId}

GET /analyzers

DELETE /analyzers/{analyzerId}
```

Related samples: `content_analyzers_update.py`, `content_analyzers_get_analyzer.py`, `content_analyzers_list.py`, `content_analyzers_delete_analyzer.py`

---

## Retrieve analyzer operation status and results (including files)

**Customer Value:** Supports robust job orchestration and retrieval of rich artifacts (e.g., images, keyframes, attachments).

**REST API Flow:**

```http
GET /analyzers/{analyzerId}/operations/{operationId}

GET /analyzerResults/{operationId}

GET /analyzerResults/{operationId}/files/{path}
```

Related samples: `content_analyzers_get_operation_status.py`, `content_analyzers_get_result.py`, `content_analyzers_get_result_file.py`

---

## Classify content using a custom classifier (structured text or binary)

**Customer Value:** Routes documents/content to the right workflow by category with high accuracy.

**REST API Flow:**

1. Create classifier with categories
2. Submit content to classify (text, URL, or binary)
3. Poll classification operation
4. Retrieve classification result JSON

```http
POST /classifiers
	Content-Type: application/json
	{
		"classifierId": "{classifierId}",
		"categories": [ { "name": "..." } ]
	}

POST /classifiers/{classifierId}:classify
	Content-Type: application/json | application/pdf | image/jpeg
	Body: { "text": "..." } | { "url": "https://..." } | <binary>

GET /classifierResults/{operationId}
```

Related samples: `content_classifiers_create_or_replace.py`, `content_classifiers_classify.py`, `content_classifiers_classify_binary.py`, `content_classifiers_get_result.py`, `content_classifiers_get_operation_status.py`

---

## Update, get, list, and delete classifiers

**Customer Value:** Maintains classifier quality and cleans up unused models.

**REST API Flow:**

```http
PATCH /classifiers/{classifierId}
	Content-Type: application/json
	{
		"categories": [ /* updates */ ]
	}

GET /classifiers/{classifierId}

GET /classifiers

DELETE /classifiers/{classifierId}
```

Related samples: `content_classifiers_update.py`, `content_classifiers_get_classifier.py`, `content_classifiers_list.py`, `content_classifiers_delete_classifier.py`

---

## Detect faces in images (binary or URL)

**Customer Value:** Enables privacy and safety features or identity-aware experiences by detecting faces in imagery.

**REST API Flow:**

1. Submit image (binary or URL) for face detection
2. Receive bounding boxes and attributes per face

```http
POST /faces:detect
	Content-Type: image/jpeg | application/json
	Body: <binary image> | { "url": "https://.../image.jpg" }
```

Related samples: `faces_detect.py`, `faces_detect_url.py`

---

## Manage person directories and perform identification

**Customer Value:** Supports person enrollment and identity workflows such as identifying who appears in an image.

**REST API Flow:**

1. Create a person directory and add a person
2. Add or update faces for that person
3. Identify a person in a new image against the directory
4. Find similar faces across the directory
5. List persons and faces; clean up faces, persons, and directories

```http
POST /personDirectories
POST /personDirectories/{directoryId}/persons
POST /personDirectories/{directoryId}/persons/{personId}/faces
POST /personDirectories/{directoryId}:identify
POST /personDirectories/{directoryId}:findSimilar
GET  /personDirectories/{directoryId}/persons
GET  /personDirectories/{directoryId}/persons/{personId}/faces
DELETE /personDirectories/{directoryId}/persons/{personId}/faces/{faceId}
DELETE /personDirectories/{directoryId}/persons/{personId}
DELETE /personDirectories/{directoryId}
```

Related samples: `person_directories_create.py`, `person_directories_add_person.py`, `person_directories_update_person.py`, `person_directories_update_face.py`, `person_directories_identify_person.py`, `person_directories_find_similar_faces.py`, `person_directories_list_persons.py`, `person_directories_list_faces.py`, `person_directories_get.py`, `person_directories_get_person.py`, `person_directories_get_face.py`, `person_directories_delete_face.py`, `person_directories_delete_person.py`, `person_directories_delete.py`
