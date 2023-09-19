
namespace ImageAnalysis;

model AdultMatch{
    @visibility("read")
    @doc("Gets the confidence score of whether the image contains adult content.")
    confidence: float64;
  
    @visibility("read")
    isMatch: boolean;
  }
      
  model AdultResult {
    @visibility("read")
    Adult: AdultMatch;
    
    @visibility("read")
    Gore: AdultMatch;
    
    @visibility("read")
    Racy: AdultMatch;
  }
  
  @doc("A basic rectangle")
  model BoundingBox{
    @doc("X coordinate")
    x: int64;
  
    @doc("Y coordinate")
    y: int64;
  
    @doc("Width of the box")
    w: int64;
  
    @doc("Height of the box")
    h: int64;
  }
          
  model CaptionResult {
    confidence:float64;
    text:string;
  }
  model CropRegion {
    aspectRatio:float64;
    boundingBox:BoundingBox;
  }
  model DenseCaption {
    boundingBox:BoundingBox;
    confidence:float64;
    text:string;
  }
  model DenseCaptionsResult {
    values:Array<DenseCaption>;
  }
  model DetectedObject {
    boundingBox:BoundingBox;
    id:string;
    tags:Array<Tag>;
  }
  @doc("Represents a person detected in an image")
  model DetectedPerson {
      @doc("Gets a rectangular boundary within which the person was detected.")
      @visibility("read")
      boundingBox: BoundingBox;
  
      @doc ("Gets the confidence value of the detected person.")
      @visibility("read")
      confidence: int64;
  }
  model DocumentLine {
    boundingBox:Array<float64>;
    content:string;
    spans:Array<DocumentSpan>;
  }
  model DocumentPage {
    angle:float64;
    height:float64;
    lines:Array<DocumentLine>;
    pageNumber:int64;
    spans:Array<DocumentSpan>;
    width:float64;
    words:Array<DocumentWord>;
  }
  model DocumentSpan {
    length:int64;
    offset:int64;
  }
  model DocumentStyle {
    confidence:float64;
    isHandwritten:boolean;
    spans: Array<DocumentSpan>;
  }
  model DocumentWord {
    boundingBox:Array<float64> ;
    confidence:float64;
    content:string;
    span:DocumentSpan;
  }
  model ImageAnalysisResult {
    adultResult:AdultResult;
    captionResult: CaptionResult;
    customModelResult: ImagePredictionResult;
    denseCaptionsResult: DenseCaptionsResult;
    metadata:ImageMetadataApiModel ;
    modelVersion:string ;
    objectsResult:ObjectsResult;
    peopleResult: PeopleResult;
    readResult: ReadResult;
    smartCropsResult: SmartCropsResult;
    tagsResult: TagsResult;
  }		
  model ImageMetadataApiModel {
    Height:int64;
    Width:int64
  }
  model ImagePredictionResult {
    objectsResult:ObjectsResult;
    tagsResult:TagsResult;
  }
  model ObjectsResult {
     values: Array<DetectedObject>;
  }
  model PeopleResult {
    values: Array<DetectedPerson> ;
  }
  model ReadResult {
    content: string;
    pages: Array<DocumentPage>;
    stringIndexType: string;
    styles: Array<DocumentStyle> ;
  }
  model SmartCropsResult {
    values: Array<CropRegion>;
  }
  model Tag {
    confidence: float64;
    name : string ;
  }
  model TagsResult {
    values: Array<Tag>;
  }
  

  @doc("Represents the configuration options that control the function of the ImageAnalyzer")
  model ImageAnalysisOptions{
    @doc("Gets or sets the gender neutrality of the Image Analysis caption result.")
    genderNeutralCaption: boolean;
  
  }