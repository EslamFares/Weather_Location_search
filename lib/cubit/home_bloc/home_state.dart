abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeChangeSearchWeatherState extends HomeStates {}

class HomeChangeLocationWeatherState extends HomeStates {}

class HomeChangeLoadingState extends HomeStates {}

class HomeChangeLoadingLocationState extends HomeStates {}

class HomeChangeNODataState extends HomeStates {}

class HomeChangeNODataLocationState extends HomeStates {}

class HomeChangeLocationReqState extends HomeStates {}

class GPSopenState extends HomeStates {}

//======================
class MapWeatherState extends HomeStates {}

class MaploadingLocationState extends HomeStates {}

class MapNoDatanState extends HomeStates {}
