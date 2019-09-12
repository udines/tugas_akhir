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

  test('load agents nearby success', () async {
    List<Agent> mockedResponse = [];
    mockedResponse.add(Agent());
    when(agentRepo.fetchAgentsNearby(1.0, 1.0, 1.0)).thenAnswer((_) async => Future.value(mockedResponse));
    await presenter.fetchAgentsNearby(1.0, 1.0, 1.0);
    expect(await agentRepo.fetchAgentsNearby(any, any, any), isInstanceOf<List<Agent>>());
    verify(agentRepo.fetchAgentsNearby(1.0, 1.0, 1.0)).called(1);
    verify(view.onLoadAgentComplete(mockedResponse)).called(1);
    verifyNever(view.onLoadAgentError());
  });

  test('load agents nearby error', () async {
    List<Agent> mockedResponse = [];
    mockedResponse.add(Agent());
    final error = Exception();
    when(agentRepo.fetchAgentsNearby(any, any, any)).thenThrow(error);
    await presenter.fetchAgentsNearby(any, any, any);
    verify(agentRepo.fetchAgentsNearby(any, any, any));
    verifyNever(view.onLoadAgentComplete(any));
    verify(view.onLoadAgentError());
  });

  test('get current location success', () async {
    final location = LatLng();
    when(locRepo.getCurrentLocation()).thenAnswer((_) async => Future.value(location));
    await presenter.getUserCurrentLocation();
    expect(await locRepo.getCurrentLocation(), isInstanceOf<LatLng>());
    verify(locRepo.getCurrentLocation());
    verify(view.onGetCurrentUserLocationComplete(location.latitude, location.longitude));
  });

  test('get current location fail', () async {
    final error = Exception();
    when(locRepo.getCurrentLocation()).thenThrow(error);
    await presenter.getUserCurrentLocation();
    verify(locRepo.getCurrentLocation());
    verifyNever(view.onGetCurrentUserLocationComplete(any, any));
  });

  test('check location permission returns granted', () async {
    final statusGranted = GeolocationStatus.granted;
    when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusGranted));
    await presenter.checkLocationPermission();
    expect(await locRepo.getLocationPermission(), isInstanceOf<GeolocationStatus>());
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionGranted());
    verifyNever(view.onLocationPermissionDenied());
  });

  test('check location permission returns denied', () async {
    final statusDenied = GeolocationStatus.denied;
    when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusDenied));
    await presenter.checkLocationPermission();
    expect(await locRepo.getLocationPermission(), isInstanceOf<GeolocationStatus>());
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionDenied());
    verifyNever(view.onLocationPermissionGranted());
  });

  test('check location permission returns restricted', () async {
    final statusRestricted = GeolocationStatus.restricted;
    when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusRestricted));
    await presenter.checkLocationPermission();
    expect(await locRepo.getLocationPermission(), isInstanceOf<GeolocationStatus>());
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionDenied());
    verifyNever(view.onLocationPermissionGranted());
  });

  test('check location permission returns unknown', () async {
    final statusUnknown = GeolocationStatus.unknown;
    when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusUnknown));
    await presenter.checkLocationPermission();
    expect(await locRepo.getLocationPermission(), isInstanceOf<GeolocationStatus>());
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionDenied());
    verifyNever(view.onLocationPermissionGranted());
  });

  test('check location permission returns error', () async {
    final error = Exception();
    when(locRepo.getLocationPermission()).thenThrow(error);
    await presenter.checkLocationPermission();
    verify(locRepo.getLocationPermission());
    verify(view.onLocationPermissionDenied());
    verifyNever(view.onLocationPermissionGranted());
  });

  test('request location permission granted', () async {
    final response = {PermissionGroup.location:PermissionStatus.granted};
    when(locRepo.requestLocationPermission()).thenAnswer((_) => Future.value(response));
    await presenter.requestLocationPermission();
    expect(await locRepo.requestLocationPermission(), isInstanceOf<Map<PermissionGroup, PermissionStatus>>());
    verify(locRepo.requestLocationPermission());
    verify(view.onLocationPermissionGranted());
    verifyNever(view.onLocationPermissionDenied());
  });

  test('request location permission error', () async {
    final error = Exception();
    when(locRepo.requestLocationPermission()).thenThrow(error);
    await presenter.requestLocationPermission();
    verify(locRepo.requestLocationPermission());
    verifyNever(view.onLocationPermissionGranted());
    verify(view.onLocationPermissionDenied());
  });
}