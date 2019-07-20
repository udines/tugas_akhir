import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/presenter/customer/agent_detail_presenter.dart';

class AgentDetailMock extends Mock {
  static AgentDetailViewContract view;
  AgentDetailPresenter presenter = AgentDetailPresenter(view);
}

main() {
  group('agent open check', () {
    final AgentDetailMock mock = AgentDetailMock();
    Agent agent = Agent(
      id: "agentId",
      address: "address",
      city: "city",
      costPerKG: 1000,
      costPerKM: 1000,
      isReceiveOrder: true,
      name: "agent",
      phone: '0898989898',
      timeOpen: '09:00',
      timeClose: '21:00',
    );

    test('test time before agent opens', () {
      DateTime date = DateTime(2019, 1, 1, 7, 0);
      var result = mock.presenter.isAgentOpen(agent, date);
      expect(result, false);
    });

    test('test agent open', () {
      DateTime date = DateTime(2019, 1, 1, 12, 0);
      var result = mock.presenter.isAgentOpen(agent, date);
      expect(result, true);
    });

    test('test agent close', () {
      DateTime date = DateTime(2019, 1, 1, 22, 0);
      var result = mock.presenter.isAgentOpen(agent, date);
      expect(result, false);
    });
  });
}