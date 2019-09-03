import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
}