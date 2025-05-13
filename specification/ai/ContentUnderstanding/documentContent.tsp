import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ContentUnderstanding;

@doc("Document content.  Ex. text/plain, application/pdf, image/jpeg.")
model DocumentContent extends MediaContent {
  @doc("Content kind.")
  kind: MediaContentKind.document;

  @doc("Start page number (1-indexed) of the content.")
  startPageNumber: int32;

  @doc("End page number (1-indexed) of the content.")
  endPageNumber: int32;

  @doc("""
    Length unit used by the width, height, and source properties.
    For images/tiff, the default unit is pixel.  For PDF, the default unit is inch.
    """)
  unit?: LengthUnit;

  @doc("List of pages in the document.")
  pages?: DocumentPage[];

  @doc("List of paragraphs in the document.  Only if enableOcr and returnDetails are true.")
  paragraphs?: DocumentParagraph[];

  @doc("List of sections in the document.  Only if enableLayout and returnDetails are true.")
  sections?: DocumentSection[];

  @doc("List of tables in the document.  Only if enableLayout and returnDetails are true.")
  tables?: DocumentTable[];

  @doc("List of figures in the document.  Only if enableLayout and returnDetails are true.")
  figures?: DocumentFigure[];

  @doc("List of faces in the document.  Only if enableFace and returnDetails are true.")
  faces?: ImageFace[];
}

@doc("Length unit used by the width, height, and source properties.")
union LengthUnit {
  string,

  @doc("Pixel unit.")
  "pixel",

  @doc("Inch unit.")
  "inch",
}

@doc("Content from a document page.")
model DocumentPage {
  @doc("Page number (1-based).")
  @minValue(1)
  pageNumber: int32;

  @doc("Width of the page.")
  width?: float32;

  @doc("Height of the page.")
  height?: float32;

  @doc("Span(s) associated with the page in the markdown content.")
  spans?: ContentSpan[];

  @doc("""
    The general orientation of the content in clockwise direction,
    measured in degrees between (-180, 180].
    Only if enableOcr is true.
    """)
  @minValueExclusive(-180)
  @maxValue(180)
  angle?: float32;

  @doc("List of words in the page.  Only if enableOcr and returnDetails are true.")
  words?: DocumentWord[];

  @doc("List of lines in the page.  Only if enableOcr and returnDetails are true.")
  lines?: DocumentLine[];

  @doc("List of barcodes in the page.  Only if enableBarcode and returnDetails are true.")
  barcodes?: DocumentBarcode[];

  @doc("List of mathematical formulas in the page.  Only if enableFormula and returnDetails are true.")
  formulas?: DocumentFormula[];
}

@doc("""
  Word in a document, consisting of a contiguous sequence of characters.
  For non-space delimited languages, such as Chinese, Japanese, and Korean, 
  each character is represented as its own word.
  """)
model DocumentWord {
  @doc("Word text.")
  content: string;

  @doc("Encoded source that identifies the position of the word in the content.")
  source?: string;

  @doc("Span of the word in the markdown content.")
  span?: ContentSpan;

  @doc("Confidence of predicting the word.")
  @minValue(0)
  @maxValue(1)
  confidence?: float32;
}

@doc("Line in a document, consisting of an contiguous sequence of words.")
model DocumentLine {
  @doc("Line text.")
  content: string;

  @doc("Encoded source that identifies the position of the line in the content.")
  source?: string;

  @doc("Span of the line in the markdown content.")
  span?: ContentSpan;
}

@doc("Barcode in a document.")
model DocumentBarcode {
  @doc("Barcode kind.")
  kind: DocumentBarcodeKind;

  @doc("Barcode value.")
  value: string;

  @doc("Encoded source that identifies the position of the barcode in the content.")
  source?: string;

  @doc("Span of the barcode in the markdown content.")
  span?: ContentSpan;

  @doc("Confidence of predicting the barcode.")
  @minValue(0)
  @maxValue(1)
  confidence?: float32;
}

@doc("Mathematical formula in a document.")
model DocumentFormula {
  @doc("Formula kind.")
  kind: DocumentFormulaKind;

  @doc("LaTex expression describing the formula.")
  value: string;

  @doc("Encoded source that identifies the position of the formula in the content.")
  source?: string;

  @doc("Span of the formula in the markdown content.")
  span?: ContentSpan;

  @doc("Confidence of predicting the formula.")
  @minValue(0)
  @maxValue(1)
  confidence?: float32;
}

@doc("""
  Paragraph in a document, generally consisting of an contiguous sequence of lines
  with common alignment and spacing.
  """)
model DocumentParagraph {
  @doc("Semantic role of the paragraph.")
  role?: ParagraphRole;

  @doc("Paragraph text.")
  content: string;

  @doc("Encoded source that identifies the position of the paragraph in the content.")
  source?: string;

  @doc("Span of the paragraph in the markdown content.")
  span?: ContentSpan;
}

@doc("Table in a document, consisting table cells arranged in a rectangular layout.")
model DocumentTable {
  @doc("Number of rows in the table.")
  @minValue(1)
  rowCount: int32;

  @doc("Number of columns in the table.")
  @minValue(1)
  columnCount: int32;

  @doc("Cells contained within the table.")
  cells: DocumentTableCell[];

  @doc("Encoded source that identifies the position of the table in the content.")
  source?: string;

  @doc("Span of the table in the markdown content.")
  span?: ContentSpan;

  @doc("Table caption.")
  caption?: DocumentCaption;

  @doc("List of table footnotes.")
  footnotes?: DocumentFootnote[];
}

@doc("Table cell in a document table.")
model DocumentTableCell {
  @doc("Table cell kind.")
  kind?: DocumentTableCellKind = DocumentTableCellKind.content;

  @doc("Row index of the cell.")
  rowIndex: int32;

  @doc("Column index of the cell.")
  columnIndex: int32;

  @doc("Number of rows spanned by this cell.")
  @minValue(1)
  rowSpan?: int32 = 1;

  @doc("Number of columns spanned by this cell.")
  @minValue(1)
  columnSpan?: int32 = 1;

  @doc("Content of the table cell.")
  content: string;

  @doc("Encoded source that identifies the position of the table cell in the content.")
  source?: string;

  @doc("Span of the table cell in the markdown content.")
  span?: ContentSpan;

  @doc("Child elements of the table cell.")
  elements?: DocumentElement[];
}

@doc("Figure in a document.")
model DocumentFigure {
  @doc("Figure identifier.")
  id: string;

  @doc("Encoded source that identifies the position of the figure in the content.")
  source?: string;

  @doc("Span of the figure in the markdown content.")
  span?: ContentSpan;

  @doc("Child elements of the figure, excluding any caption or footnotes.")
  elements?: DocumentElement[];

  @doc("Figure caption.")
  caption?: DocumentCaption;

  @doc("List of figure footnotes.")
  footnotes?: DocumentFootnote[];
}

@doc("Section in a document.")
model DocumentSection {
  @doc("Span of the section in the markdown content.")
  span?: ContentSpan;

  @doc("Child elements of the section.")
  elements?: DocumentElement[];
}

@doc("Caption of a table or figure.")
model DocumentCaption {
  @doc("Content of the caption.")
  content: string;

  @doc("Encoded source that identifies the position of the caption in the content.")
  source?: string;

  @doc("Span of the caption in the markdown content.")
  span?: ContentSpan;

  @doc("Child elements of the caption.")
  elements?: DocumentElement[];
}

@doc("Footnote of a table or figure.")
model DocumentFootnote {
  @doc("Content of the footnote.")
  content: string;

  @doc("Encoded source that identifies the position of the footnote in the content.")
  source?: string;

  @doc("Span of the footnote in the markdown content.")
  span?: ContentSpan;

  @doc("Child elements of the footnote.")
  elements?: DocumentElement[];
}

@doc("""
  JSON pointer referencing an element of the document, such as paragraph,
  table, section, etc.
  """)
scalar DocumentElement extends string;

@doc("Barcode kind.")
union DocumentBarcodeKind {
  string,

  @doc("QR code, as defined in ISO/IEC 18004:2015.")
  QRCode: "QRCode",

  @doc("PDF417, as defined in ISO 15438.")
  PDF417: "PDF417",

  @doc("GS1 12-digit Universal Product Code.")
  UPCA: "UPCA",

  @doc("GS1 6-digit Universal Product Code.")
  UPCE: "UPCE",

  @doc("Code 39 barcode, as defined in ISO/IEC 16388:2007.")
  Code39: "Code39",

  @doc("Code 128 barcode, as defined in ISO/IEC 15417:2007.")
  Code128: "Code128",

  @doc("GS1 8-digit International Article Number (European Article Number).")
  EAN8: "EAN8",

  @doc("GS1 13-digit International Article Number (European Article Number).")
  EAN13: "EAN13",

  @doc("GS1 DataBar barcode.")
  DataBar: "DataBar",

  @doc("Code 93 barcode, as defined in ANSI/AIM BC5-1995.")
  Code93: "Code93",

  @doc("Codabar barcode, as defined in ANSI/AIM BC3-1995.")
  Codabar: "Codabar",

  @doc("GS1 DataBar Expanded barcode.")
  DataBarExpanded: "DataBarExpanded",

  @doc("Interleaved 2 of 5 barcode, as defined in ANSI/AIM BC2-1995.")
  ITF: "ITF",

  @doc("Micro QR code, as defined in ISO/IEC 23941:2022.")
  MicroQRCode: "MicroQRCode",

  @doc("Aztec code, as defined in ISO/IEC 24778:2008.")
  Aztec: "Aztec",

  @doc("Data matrix code, as defined in ISO/IEC 16022:2006.")
  DataMatrix: "DataMatrix",

  @doc("MaxiCode, as defined in ISO/IEC 16023:2000.")
  MaxiCode: "MaxiCode",
}

@doc("Formula kind.")
union DocumentFormulaKind {
  string,

  @doc("A formula embedded within the content of a paragraph.")
  inline: "inline",

  @doc("A formula in display mode that takes up an entire line.")
  display: "display",
}

@doc("Semantic role of the paragraph.")
union ParagraphRole {
  string,

  @doc("Text near the top edge of the page.")
  pageHeader: "pageHeader",

  @doc("Text near the bottom edge of the page.")
  pageFooter: "pageFooter",

  @doc("Page number.")
  pageNumber: "pageNumber",

  @doc("Top-level title describing the entire document.")
  title: "title",

  @doc("Sub heading describing a section of the document.")
  sectionHeading: "sectionHeading",

  @doc("Note usually placed after the main content on a page.")
  footnote: "footnote",

  @doc("Block of formulas, often with shared alignment.")
  formulaBlock: "formulaBlock",
}

@doc("Table cell kind.")
union DocumentTableCellKind {
  string,

  @doc("Main content/data.")
  content: "content",

  @doc("Description of the row content.")
  rowHeader: "rowHeader",

  @doc("Description the column content.")
  columnHeader: "columnHeader",

  @doc("Description of the row headers, usually located at the top left corner of a table.")
  stubHead: "stubHead",

  @doc("Description of the content in (parts of) the table.")
  description: "description",
}

@doc("Face in an image.")
model ImageFace {
  @doc("Face identifier.")
  faceId?: string;

  @doc("Confidence of predicting the face.")
  confidence?: float32;

  @doc("Encoded source that identifies the position of the face in the content.")
  source?: string;
}
