import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/presenter/customer/agent_list_presenter.dart';

class MockView extends Mock implements AgentListViewContract {}
class MockAgentRepo extends Mock implements AgentRepository {}
class MockLocationRepo extends Mock implements LocationRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final agentRepo = MockAgentRepo();
  final view = MockView();
  final locRepo = MockLocationRepo();
  AgentListPresenter presenter;

  setUp(() {
    presenter = AgentListPresenter(view);
    presenter.testConstructor(view, agentRepo, locRepo);
  });

  test('load agents nearby', () async {
    List<Agent> mockedResponse = [];
    mockedResponse.add(Agent());
    when(agentRepo.fetchAgentsNearby(1.0, 1.0, 1.0)).thenAnswer((_) async => Future.value(mockedResponse));
    await presenter.fetchAgentsNearby(1.0, 1.0, 1.0);
    verify(agentRepo.fetchAgentsNearby(1.0, 1.0, 1.0)).called(1);
    verify(view.onLoadAgentComplete(mockedResponse)).called(1);
    verifyNever(view.onLoadAgentError());

    clearInteractions(agentRepo);
    clearInteractions(view);

    final error = Exception();
    when(agentRepo.fetchAgentsNearby(any, any, any)).thenThrow(error);
    await presenter.fetchAgentsNearby(any, any, any);
    verify(agentRepo.fetchAgentsNearby(any, any, any));
    verifyNever(view.onLoadAgentComplete(any));
    verify(view.onLoadAgentError());
  });

  test('get current location', () async {
    final location = LatLng();
    when(locRepo.getCurrentLocation()).thenAnswer((_) async => Future.value(location));

    await presenter.getUserCurrentLocation();
    verify(locRepo.getCurrentLocation());
    verify(view.onGetCurrentUserLocationComplete(location.latitude, location.longitude));

    clearInteractions(locRepo);
    clearInteractions(view);

    final error = Exception();
    when(locRepo.getCurrentLocation()).thenThrow(error);

    await presenter.getUserCurrentLocation();
    verify(locRepo.getCurrentLocation());
    verifyNever(view.onGetCurrentUserLocationComplete(any, any));
  });

  test('check location permission', () async {
    final statusGranted = GeolocationStatus.granted;
    final statusDenied = GeolocationStatus.denied;
    final statusRestricted = GeolocationStatus.restricted;
    final statusUnknown = GeolocationStatus.unknown;
    final error = Exception();
    
    when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusGranted));
    await presenter.checkLocationPermission();
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionGranted());
    verifyNever(view.onLocationPermissionDenied());

    clearInteractions(locRepo);
    clearInteractions(view);
    when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusDenied));
    await presenter.checkLocationPermission();
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionDenied());
    verifyNever(view.onLocationPermissionGranted());

    clearInteractions(locRepo);
    clearInteractions(view);
    when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusRestricted));
    await presenter.checkLocationPermission();
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionDenied());
    verifyNever(view.onLocationPermissionGranted());

    clearInteractions(locRepo);
    clearInteractions(view);
    when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusUnknown));
    await presenter.checkLocationPermission();
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionDenied());
    verifyNever(view.onLocationPermissionGranted());

    clearInteractions(locRepo);
    clearInteractions(view);
    when(locRepo.getLocationPermission()).thenThrow(error);
    await presenter.checkLocationPermission();
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionDenied());
    verifyNever(view.onLocationPermissionGranted());
  });

  test('request permission location', () async {
    final response = {PermissionGroup.location:PermissionStatus.granted};
    final error = Exception();
    when(locRepo.requestLocationPermission()).thenAnswer((_) => Future.value(response));
    await presenter.requestLocationPermission();
    verify(locRepo.requestLocationPermission());
    verify(view.onLocationPermissionGranted());
    verifyNever(view.onLocationPermissionDenied());

    clearInteractions(locRepo);
    clearInteractions(view);
    when(locRepo.requestLocationPermission()).thenThrow(error);
    await presenter.requestLocationPermission();
    verify(locRepo.requestLocationPermission());
    verifyNever(view.onLocationPermissionGranted());
    verify(view.onLocationPermissionDenied());
  });
}