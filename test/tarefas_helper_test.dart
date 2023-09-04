import 'package:flutter_test/flutter_test.dart';
import 'package:tarefas/tarefa_model.dart';
import 'package:tarefas/tarefas_helper_impl.dart';

void main() {
  testWidgets('tarefas helper ...', (tester) async {
    var tarefa = Tarefa(descricao: "Teste", prazo: DateTime.now().add(Duration(days: 30)));
    var helper = TarefasHelperImpl();
    try {
      var salvo =  await helper.salvar(tarefa);  
      print(salvo);
    } catch (e) {
      print(e);
    }

  });
}