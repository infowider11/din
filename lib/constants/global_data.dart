import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

String damSearchText = '';

List damList = [];
List<Marker> markers = [];
Position? currentPosition;

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

// List<String> selectedDamCategories = [];
// List<String>  selectedDamTypes = [];
// List<String>  selectedDamHydrologicalArea = [];
// List<String>  selectedDamRiverBasin = [];
// List<String>  selectedDamGeoPoliticalZone = [];
// List<String>  selectedDamState = [];
