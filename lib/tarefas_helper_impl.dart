import 'package:sembast/sembast.dart';
import 'package:tarefas/sembast_database.dart';

import 'tarefa_model.dart';
import 'tarefas_helper.dart';

class TarefasHelperImpl extends TarefasHelper {
  @override
  excluir() {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  listar() {
    // TODO: implement listar
    throw UnimplementedError();
  }

  @override
  obter() {
    // TODO: implement obter
    throw UnimplementedError();
  }

  @override
  salvar(Tarefa tarefa) async {
      var store = StoreRef.main();
      var db = SembastDatabase().getInstance();
      await store.record('tarefa').put(db,tarefa.getMap());
  }


}