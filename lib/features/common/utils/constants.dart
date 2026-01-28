// Canvas constants
const double A4_WIDTH_MM = 210.0;
const double A4_HEIGHT_MM = 297.0;
const double DPI = 96.0;
const double MM_TO_PIXELS = DPI / 25.4;

// Editor constants
const int MAX_UNDO_ACTIONS = 50;
const double MIN_ZOOM = 0.25;
const double MAX_ZOOM = 4.0;
const double DEFAULT_ZOOM = 1.0;

// Layer constants
const int MIN_LAYERS = 1;
const int MAX_LAYERS = 10;

// Drawing constants
const double MIN_STROKE_WIDTH = 1.0;
const double MAX_STROKE_WIDTH = 20.0;
const double DEFAULT_STROKE_WIDTH = 2.0;

// Grid constants
const double MIN_GRID_SIZE = 5.0;
const double MAX_GRID_SIZE = 50.0;
const double DEFAULT_GRID_SIZE = 10.0;

// Calculator constants
const int DEFAULT_PRECISION = 10;
const int MAX_PRECISION = 15;
const int MIN_PRECISION = 2;

// File constants
const String PROJECT_EXTENSION = '.a4flow';
const String DOCUMENTS_FOLDER = 'a4flow_documents';

// Timeout constants
const Duration SAVE_TIMEOUT = Duration(seconds: 30);
const Duration EXPORT_TIMEOUT = Duration(seconds: 60);
const Duration LOAD_TIMEOUT = Duration(seconds: 30);

// Animation constants
const Duration ANIMATION_DURATION = Duration(milliseconds: 300);
const Duration QUICK_ANIMATION_DURATION = Duration(milliseconds: 150);

// Color constants
const String COLOR_PRIMARY = '#2196F3';
const String COLOR_SECONDARY = '#03DAC6';
const String COLOR_ERROR = '#B00020';
const String COLOR_SURFACE = '#FFFFFF';
const String COLOR_BACKGROUND = '#FAFAFA';

// Font constants
const String FONT_FAMILY_PRIMARY = 'Roboto';
const String FONT_FAMILY_MONO = 'RobotoMono';
const double FONT_SIZE_DISPLAY = 32.0;
const double FONT_SIZE_HEADLINE = 20.0;
const double FONT_SIZE_TITLE = 16.0;
const double FONT_SIZE_BODY = 14.0;
const double FONT_SIZE_LABEL = 12.0;

// Margin constants
const double DEFAULT_MARGIN_LEFT = 20.0;
const double DEFAULT_MARGIN_RIGHT = 20.0;
const double DEFAULT_MARGIN_TOP = 20.0;
const double DEFAULT_MARGIN_BOTTOM = 20.0;

// Spacing constants
const double SPACING_EXTRA_SMALL = 4.0;
const double SPACING_SMALL = 8.0;
const double SPACING_MEDIUM = 16.0;
const double SPACING_LARGE = 24.0;
const double SPACING_EXTRA_LARGE = 32.0;

// Border radius constants
const double BORDER_RADIUS_SMALL = 4.0;
const double BORDER_RADIUS_MEDIUM = 8.0;
const double BORDER_RADIUS_LARGE = 12.0;

// Touch target constants
const double MIN_TOUCH_TARGET = 44.0;

// Opacity constants
const double OPACITY_DISABLED = 0.5;
const double OPACITY_HOVER = 0.8;
const double OPACITY_ACTIVE = 1.0;
