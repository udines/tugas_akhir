import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/customer/agent_detail_presenter.dart';

class MockView extends Mock implements AgentDetailViewContract {}
class MockUserRepo extends Mock implements UserRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  AgentDetailPresenter presenter;
  final view = MockView();
  final userRepo = MockUserRepo();
  Agent agent = Agent(
    id: "agentId",
    address: "address",
    isReceiveOrder: true,
    name: "agent",
    phone: '0898989898',
    timeOpen: '09:00',
    timeClose: '21:00',
  );

  setUp(() {
    presenter = AgentDetailPresenter(view);
    presenter.testConstructor(view, userRepo);
  });

  test('get current user success', () async {
    final user = User();
    when(userRepo.fetchCurrentUser()).thenAnswer((_) => Future.value(user));
    await presenter.getCurrentUser();
    expect(await userRepo.fetchCurrentUser(), isInstanceOf<User>());
    verify(userRepo.fetchCurrentUser());
    verify(view.onGetCurrentUserComplete(user));
    verifyNever(view.onGetCurrentUserError());
  });

  test('get current user fail', () async {
    final error = Exception();
    when(userRepo.fetchCurrentUser()).thenThrow(error);
    await presenter.getCurrentUser();
    verify(userRepo.fetchCurrentUser());
    verifyNever(view.onGetCurrentUserComplete(any));
    verify(view.onGetCurrentUserError());
  });

  test('test time before agent opens', () {
    DateTime date = DateTime(2019, 1, 1, 7, 0);
    var result = presenter.isAgentOpen(agent, date);
    expect(result, false);
  });

  test('test agent open', () {
    DateTime date = DateTime(2019, 1, 1, 12, 0);
    var result = presenter.isAgentOpen(agent, date);
    expect(result, true);
  });

  test('test agent close', () {
    DateTime date = DateTime(2019, 1, 1, 22, 0);
    var result = presenter.isAgentOpen(agent, date);
    expect(result, false);
  });

  test('date to string', () {
    final before10thMonth = DateTime(2019, 5, 10);
    final after10thMonth = DateTime(2019, 12, 10);
    final before10thDay = DateTime(2019, 12, 5);
    final after10thDay = DateTime(2019, 12, 12);
    expect(presenter.dateToString(before10thMonth), '2019-05-10');
    expect(presenter.dateToString(after10thMonth), '2019-12-10');
    expect(presenter.dateToString(before10thDay), '2019-12-05');
    expect(presenter.dateToString(after10thDay), '2019-12-12');
  });
}