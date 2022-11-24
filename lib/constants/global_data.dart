import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

String damSearchText = '';

List damList = [];
List<Marker> markers = [];
// Position? currentPosition;

List kdamCategories = [];
List kdamBakamType = [];
List kdamTypes = [];
List kdamHydrologicalArea = [];
List kdamRiver_basin = [];
List kdamGeo_political_zone = [];
List kstate = [];
// List filter_type = [];
// List damTypes = [];

Map selectedDamCategories = {};
Map selectedkdamBakamType = {};
Map selectedDamTypes = {};
Map selectedDamHydrologicalArea = {};
Map selectedDamRiverBasin = {};
Map selectedDamGeoPoliticalZone = {};
Map selectedDamState = {};
bool showMapHydro = false;
bool showMapState = false;
bool showMapRiver = false;
bool showMapGeo = false;

Map fishery = {
  'fishery_fishing': 1
};
Map livestock = {
  'livestock': 1
};
Map pollution_control = {
  'pollution_control': 1
};
Map recreation = {
  'recreation': 1
};
Map hydro_electricity = {
  'hydro_electricity': 1
};
Map flood_control = {
  'flood_control': 1
};
Map water_Supply = {
  'water_Supply': 1
};
Map irrigation = {
  'irrigation': 1
};


Map typeUsageStaticMap = {
  'fishery_fishing': 0,
  'livestock': 0,
  'pollution_control': 0,
  'recreation': 0,
  'hydro_electricity': 0,
  'flood_control': 0,
  'water_Supply': 0,
  'irrigation': 0,
};

List ImagesList = [];

// List<String> selectedDamCategories = [];
// List<String>  selectedDamTypes = [];
// List<String>  selectedDamHydrologicalArea = [];
// List<String>  selectedDamRiverBasin = [];
// List<String>  selectedDamGeoPoliticalZone = [];
// List<String>  selectedDamState = [];
