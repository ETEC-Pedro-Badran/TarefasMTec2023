import 'package:intl/intl.dart';

class Tarefa {
  String? id;
  String descricao;
  DateTime prazo;
  DateTime? concluido;

  Tarefa(
      {this.id, required this.descricao, required this.prazo, this.concluido});

  @override
  String toString() {
    return "id:$id-descricao: $descricao -prazo: $prazo -concluido: $concluido";
  }

  Map<String, dynamic?> getMap() {
    var dfm = DateFormat("dd/MM/yyyy hh:mm:ss");
    var map = {
      "descricao": this.descricao,
      "prazo": dfm.format(this.prazo),
    };

    if (this.id != null) {
      map.addAll({"id": this.id!});
    }
    if (this.concluido != null) {
      map.addAll({"concluido": dfm.format(this.concluido!)});
    }
    return map;
  }
}
