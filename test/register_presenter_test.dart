import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tugas_akhir/data/location/location_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/register_presenter.dart';

class MockUserRepo extends Mock implements UserRepository {}
class MockLocRepo extends Mock implements LocationRepository {}
class MockView extends Mock implements RegisterViewContract {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final userRepo = MockUserRepo();
  final locRepo = MockLocRepo();
  final view = MockView();
  RegisterPresenter presenter;

  setUp(() {
    presenter = RegisterPresenter(view);
    presenter.testConstructor(view, userRepo, locRepo);
  });

  test('register user success', () async {
    final user = User();
    final email = 'anemail@mail.com';
    final password = 'aPassword123';
    when(userRepo.registerUser(email, password, user)).thenAnswer((_) => Future.value());
    await presenter.registerUser(email, password, user);
    verify(view.showLoading(true));
    verify(userRepo.registerUser(email, password, user));
    verify(view.showLoading(false)).called(1);
    verify(view.onRegisterSuccess(user));
    verifyNever(view.onRegisterFailed());
    verifyNever(view.onCredentialsInvalid());
  });

  test('register user fail', () async {
    final user = User();
    final throwable = Exception();
    final email = 'anemail@mail.com';
    final password = 'aPassword123';
    when(userRepo.registerUser(email, password, user)).thenThrow(throwable);
    await presenter.registerUser(email, password, user);
    verify(view.showLoading(true));
    verify(userRepo.registerUser(email, password, user));
    verifyNever(view.onRegisterSuccess(any));
    verify(view.showLoading(false)).called(1);
    verify(view.onRegisterFailed());
    verifyNever(view.onCredentialsInvalid());
  });

  test('register user invalid credentials', () async {
    final user = User();
    final wrongEmail = 'hehe';
    final wrongPassword = '123';
    await presenter.registerUser(wrongEmail, wrongPassword, user);
    verifyNever(view.showLoading(true));
    verifyNever(userRepo.registerUser(wrongEmail, wrongPassword, user));
    verifyNever(view.onRegisterSuccess(any));
    verifyNever(view.showLoading(false));
    verifyNever(view.onRegisterFailed());
    verify(view.onCredentialsInvalid());
  });

  group('email and password validation', () {
    test('check credential', () {
      final email = 'someemail@mail.com';
      final password = 'sOmEpAsSwOrD';
      final wrongEmail = 'huehue';
      final wrongPassword = 'hm';

      expect(presenter.checkCredentials(email, password), true);
      expect(presenter.checkCredentials(wrongEmail, password), false);
      expect(presenter.checkCredentials(email, wrongPassword), false);
      expect(presenter.checkCredentials(wrongEmail, wrongPassword), false);
    });
    test('email has no .com', () {
      var result = presenter.validateEmail("user@email");
      expect(result, false);
    });
    test('email has no @', () {
      var result = presenter.validateEmail("useremail.com");
      expect(result, false);
    });
    test ('email has no domain name', () {
      var result = presenter.validateEmail("user@.com");
      expect(result, false);
    });
    test('email valid', () {
      var result = presenter.validateEmail("user@email.com");
      expect(result, true);
    });

    test('password less than 6 characters', () {
      var result = presenter.validatePassword("abc");
      expect(result, false);
    });
    test('password is 6 characters', () {
      var result = presenter.validatePassword("abcdef");
      expect(result, true);
    });
    test('password more than 6 characters', () {
      var result = presenter.validatePassword("abcdefghijkl");
      expect(result, true);
    });
  });

  test('get user current location success', () async {
    final location = LatLng();
    final throwable = Exception();
    when(locRepo.getCurrentLocation()).thenAnswer((_) async => Future.value(location));
    await presenter.getUserCurrentLocation();
    verify(locRepo.getAddress(location.latitude, location.longitude));
    verify(locRepo.getCityByCoordinate(location.latitude, location.longitude));
    verify(locRepo.getPostalCode(location.latitude, location.longitude));
  });

  test('get user current location fail', () async {
    final location = LatLng();
    final throwable = Exception();
    when(locRepo.getCurrentLocation()).thenThrow(throwable);
    await presenter.getUserCurrentLocation();
    verifyNever(locRepo.getAddress(location.latitude, location.longitude));
    verifyNever(locRepo.getCityByCoordinate(location.latitude, location.longitude));
    verifyNever(locRepo.getPostalCode(location.latitude, location.longitude));
  });

  group('get geolocation data', () {
    final lat = 1.1;
    final long = 2.2;
    final throwable = Exception();
    
    test('get postal code success', () async {
      final postalCode = '123456';
      when(locRepo.getPostalCode(lat, long)).thenAnswer((_) async => Future.value(postalCode));
      await presenter.getPostalCode(lat, long);
      verify(locRepo.getPostalCode(lat, long));
      verify(view.onGetPostalCodeSuccess(postalCode));
      verifyNever(view.onGetPostalCodeSuccess(''));
    });

    test('get postal code fail', () async {
      final postalCode = '123456';
      when(locRepo.getPostalCode(lat, long)).thenThrow(throwable);
      await presenter.getPostalCode(lat, long);
      verify(locRepo.getPostalCode(lat, long));
      verifyNever(view.onGetPostalCodeSuccess(postalCode));
      verify(view.onGetPostalCodeSuccess(''));
    });

    test('get city success', () async {
      final city = 'Some City';
      when(locRepo.getCityByCoordinate(lat, long)).thenAnswer((_) async => Future.value(city));
      await presenter.getCity(lat, long);
      verify(locRepo.getCityByCoordinate(lat, long));
      verify(view.onGetCitySuccess(city));
      verifyNever(view.onGetCitySuccess(''));
    });

    test('get city fail', () async {
      final city = 'Some City';
      when(locRepo.getCityByCoordinate(lat, long)).thenThrow(throwable);
      await presenter.getCity(lat, long);
      verify(locRepo.getCityByCoordinate(lat, long));
      verifyNever(view.onGetCitySuccess(city));
      verify(view.onGetCitySuccess(''));
    });

    test('get address success', () async {
      final address = 'Some address in the jungle';
      when(locRepo.getAddress(lat, long)).thenAnswer((_) async => Future.value(address));
      await presenter.getUserAddress(lat, long);
      verify(locRepo.getAddress(lat, long));
      verify(view.onGetAddressSuccess(address));
      verifyNever(view.onGetAddressSuccess(''));
    });

    test('get address fail', () async {
      final address = 'Some address in the jungle';
      when(locRepo.getAddress(lat, long)).thenThrow(throwable);
      await presenter.getUserAddress(lat, long);
      verify(locRepo.getAddress(lat, long));
      verify(view.onGetAddressSuccess(''));
      verifyNever(view.onGetAddressSuccess(address));
    });
  });

  group('check location permission', () {
    final statusGranted = GeolocationStatus.granted;
    final statusDenied = GeolocationStatus.denied;
    final statusRestricted = GeolocationStatus.restricted;
    final statusUnknown = GeolocationStatus.unknown;
    final error = Exception();
    
    test('location permission granted', () async {
      when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusGranted));
      await presenter.getInitialLocationInfo();
      expect(await locRepo.getLocationPermission(), isInstanceOf<GeolocationStatus>());
      verify(locRepo.getLocationPermission());
      verify(locRepo.getCurrentLocation());
      verifyNever(locRepo.requestLocationPermission());
      verifyNever(view.onPermissionDenied());
    });
    
    test('location permission denied', () async {
      when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusDenied));
      await presenter.getInitialLocationInfo();
      expect(await locRepo.getLocationPermission(), isInstanceOf<GeolocationStatus>());
      verify(locRepo.getLocationPermission());
      verifyNever(locRepo.getCurrentLocation());
      verify(locRepo.requestLocationPermission());
    });

    test('location permission restricted', () async {
      when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusRestricted));
      await presenter.getInitialLocationInfo();
      expect(await locRepo.getLocationPermission(), isInstanceOf<GeolocationStatus>());
      verify(locRepo.getLocationPermission());
      verifyNever(locRepo.getCurrentLocation());
      verify(locRepo.requestLocationPermission());
    });

    test('location permission unknown', () async {
      when(locRepo.getLocationPermission()).thenAnswer((_) => Future.value(statusUnknown));
      await presenter.getInitialLocationInfo();
      expect(await locRepo.getLocationPermission(), isInstanceOf<GeolocationStatus>());
      verify(locRepo.getLocationPermission());
      verifyNever(locRepo.getCurrentLocation());
      verify(locRepo.requestLocationPermission());
    });

    test('location permission throw exception', () async {
      when(locRepo.getLocationPermission()).thenThrow(error);
      await presenter.getInitialLocationInfo();
      verify(locRepo.getLocationPermission());
      verifyNever(locRepo.getCurrentLocation());
      verifyNever(locRepo.requestLocationPermission());
      verify(view.onPermissionDenied());
    });
  });

  test('request location permission success', () async {
    final response = {PermissionGroup.location:PermissionStatus.granted};
    when(locRepo.requestLocationPermission()).thenAnswer((_) => Future.value(response));
    await presenter.requestLocationPermission();
    expect(await locRepo.requestLocationPermission(), isInstanceOf<Map<PermissionGroup, PermissionStatus>>());
    verify(locRepo.requestLocationPermission());
    verify(locRepo.getCurrentLocation());
    verifyNever(view.onPermissionDenied());
  });

  test('request location permission fail', () async {
    final error = Exception();
    when(locRepo.requestLocationPermission()).thenThrow(error);
    await presenter.requestLocationPermission();
    verify(locRepo.requestLocationPermission());
    verifyNever(locRepo.getCurrentLocation());
    verify(view.onPermissionDenied());
  });
}